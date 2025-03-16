
#include <config.hpp>

#ifdef BUILD_FOR_IOS
#include <cstdlib>
#define VK_USE_PLATFORM_IOS_MVK
#include <vulkan/vulkan.hpp>

#define NS_PRIVATE_IMPLEMENTATION
#define UI_PRIVATE_IMPLEMENTATION
#define MTL_PRIVATE_IMPLEMENTATION
#define MTK_PRIVATE_IMPLEMENTATION
#define CA_PRIVATE_IMPLEMENTATION
#define MTLFX_PRIVATE_IMPLEMENTATION
#include <Metal/Metal.hpp>
#include <MetalFX/MetalFX.hpp>
#include <MetalKit/MetalKit.hpp>
#include <UIKit/UIKit.hpp>

#include <application/application.hpp>
#include <scripting/lua.hpp>
#include <servicelocators/servicelocator.hpp>

extern "C" UI::ViewController *get_native_bounds(UI::View *view,
                                                 UI::Screen *screen);
extern "C" CGPoint touch();
extern "C" float get_native_scale();
extern "C" {
void PlaySound(uint32_t index);
void StopSound(uint32_t index);
}

class EntropyApplication final : public UI::ApplicationDelegate {
public:
  class MTKViewDelegate final : public MTK::ViewDelegate {
  public:
    MTKViewDelegate(
        EntropyApplication *app,
        const std::shared_ptr<
            Entropy::Graphics::Vulkan::Renderers::VulkanRenderer> &renderer)
        : ViewDelegate() {
      const ServiceLocator *sl = ServiceLocator::GetInstance();
      _app = app;
      _physics2d = sl->getService<IPhysics2D>();
      _lua = sl->getService<ILua>();
      _timer = std::make_unique<Timer>(1.0f);
      _renderer = renderer;
      _lua->SetBasePath(GetProjectBasePath());
      _lua->Get()->set_function("PlaySound",
                                [](const uint32_t index) { PlaySound(index); });
      _lua->Get()->set_function("StopSound",
                                [](const uint32_t index) { StopSound(index); });
      _lua->Get()->script_file(GetScriptsDir() + "main.lua");
    }

    ~MTKViewDelegate() override = default;

    void drawInMTKView(MTK::View *pView) override {

      // Calculate frame delta time
      const auto tick_time = _timer->GetTick();
      deltaTime = tick_time - lastTick;
      lastTick = tick_time;

      _renderer->Render(_app->frame.size.width * get_native_scale(),
                        _app->frame.size.height * get_native_scale(), 1.0, 1.0);

      const auto on_render = _lua->Get()->get<sol::function>("OnRender");
      const auto on_input = _lua->Get()->get<sol::function>("OnInput");

      if (on_render.valid()) {
        on_render(deltaTime, _app->frame.size.width * get_native_scale(),
                  _app->frame.size.height * get_native_scale());
      }

      auto [x, y] = touch();
      ServiceLocator::GetInstance()
          ->getService<Entropy::Input::IMouse>()
          ->position =
          glm::vec2(x * get_native_scale(), y * get_native_scale());

      //_physics2d->Get()->Step(timeStep, velocityIterations,
      // positionIterations);
      // physics2d->world->DebugDraw();
    }

  private:
    int velocityIterations = 16;
    int positionIterations = 16;
    float timeStep = 1.0f / 60.f;
    float lastTick{};
    float deltaTime{};
    EntropyApplication *_app;
    std::shared_ptr<Entropy::Graphics::Vulkan::Renderers::VulkanRenderer>
        _renderer;
    std::shared_ptr<IPhysics2D> _physics2d;
    std::shared_ptr<ILua> _lua;
    std::unique_ptr<Timer> _timer;
  };

  EntropyApplication() {
    _autoreleasePool = NS::AutoreleasePool::alloc()->init();
    _renderer = std::make_shared<
        Entropy::Graphics::Vulkan::Renderers::VulkanRenderer>();
  }

  ~EntropyApplication() override {
    _pMtkView->release();
    _pWindow->release();
    _pViewController->release();
    _pDevice->release();
    delete _pViewDelegate;
    _autoreleasePool->release();
  }

  inline bool applicationDidFinishLaunching(UI::Application *pApp,
                                            NS::Value *options) override {

    frame = UI::Screen::mainScreen()->bounds();

    const VkExtent2D extent = {static_cast<uint32_t>(frame.size.width),
                               static_cast<uint32_t>(frame.size.height)};

    _pWindow = UI::Window::alloc()->init(frame);
    _pDevice = MTL::CreateSystemDefaultDevice();
    _pMtkView = MTK::View::alloc()->init(frame, _pDevice);

    _pViewController = get_native_bounds(
        reinterpret_cast<UI::View *>(_pMtkView), UI::Screen::mainScreen());

    _pMtkView->setColorPixelFormat(
        MTL::PixelFormat::PixelFormatBGRA8Unorm_sRGB);
    _pMtkView->setClearColor(MTL::ClearColor::Make(0.0, 1.0, 0.0, 0.0));

    _pViewDelegate = new MTKViewDelegate(this, _renderer);
    _pMtkView->setDelegate(_pViewDelegate);

    auto *mtkView = reinterpret_cast<UI::View *>(_pMtkView);
    mtkView->setAutoresizingMask(UI::ViewAutoresizingFlexibleWidth |
                                 UI::ViewAutoresizingFlexibleHeight);

    _pViewController->view()->addSubview(mtkView);
    _pWindow->setRootViewController(_pViewController);

    _pWindow->makeKeyAndVisible();

    CA::MetalLayer *layer = _pMtkView->currentDrawable()->layer();

    ServiceLocator *sl = ServiceLocator::GetInstance();

    VkIOSSurfaceCreateInfoMVK createInfo{};
    createInfo.sType = VK_STRUCTURE_TYPE_IOS_SURFACE_CREATE_INFO_MVK;
    createInfo.pNext = nullptr;
    createInfo.flags = 0;
    createInfo.pView = layer;

    if (vkCreateIOSSurfaceMVK(sl->getService<IVulkanInstance>()->Get(),
                              &createInfo, nullptr, &_surface) != VK_SUCCESS) {
      spdlog::error("Failed to create a window surface for platform 'iOS'");
      return false;
    }

    _renderer->_swapchain->Build(_surface, extent, nullptr);

    _renderer->_renderPass->RecreateDepthBuffer(
        extent.width * get_native_scale(), extent.height * get_native_scale());
    _renderer->_renderPass->CreateFrameBuffers(
        sl->getService<ISwapchain>(), extent.width * get_native_scale(),
        extent.height * get_native_scale());

    return true;
  }

public:
  inline void Run() { UI::ApplicationMain(0, 0, this); }
  CGRect frame{};

private:
  UI::Window *_pWindow = nullptr;
  MTK::View *_pMtkView = nullptr;
  MTL::Device *_pDevice = nullptr;
  MTKViewDelegate *_pViewDelegate = nullptr;
  NS::AutoreleasePool *_autoreleasePool = nullptr;
  UI::ViewController *_pViewController = nullptr;
  std::shared_ptr<Entropy::Graphics::Vulkan::Renderers::VulkanRenderer>
      _renderer;
  VkSurfaceKHR _surface = VK_NULL_HANDLE;
};

int main() {

  ServiceLocator *sl = ServiceLocator::GetInstance();

  // Vulkan services
  sl->registerService(std::make_shared<VulkanInstance>());
  sl->registerService(std::make_shared<PhysicalDevice>());
  sl->registerService(std::make_shared<LogicalDevice>());
  sl->registerService(std::make_shared<Allocator>());
  sl->registerService(std::make_shared<SwapChain>());
  sl->registerService(
      std::make_shared<Entropy::Graphics::Vulkan::CommandPools::CommandPool>());
  sl->registerService(std::make_shared<DescriptorPool>());
  sl->registerService(
      std::make_shared<Entropy::Graphics::Vulkan::Caches::PipelineCache>());

  // Cameras
  sl->registerService(std::make_shared<CameraManager>());
  const auto cameraManager = sl->getService<ICameraManager>();
  const auto camera = new OrthographicCamera();
  cameraManager->currentCamera = camera;

  // 2D Physics
  sl->registerService(std::make_shared<Entropy::Physics::Physics2D>());

  // ECS
  sl->registerService(std::make_shared<World>());

  // Scripting
  sl->registerService(std::make_shared<Lua>());

  // Input
  sl->registerService(std::make_shared<Entropy::Input::Keyboard>());
  sl->registerService(std::make_shared<Entropy::Input::Mouse>());

  auto app = EntropyApplication();
  app.Run();

  return EXIT_SUCCESS;
}

#else
struct Entropia final : Entropy::Entrypoints::Application {
  /**
   * Initializes the application by retrieving the Lua scripting service from
   * the service locator and executing the main Lua script. This method
   * overrides the OnInit function in the base class.
   */
  void OnInit() override {
    const ServiceLocator *sl = ServiceLocator::GetInstance();
    const auto lua = sl->getService<ILua>();
    lua->SetBasePath("../");
    lua->Get()->script_file("../scripts/main.lua");
  }

  /**
   * Handles the rendering of the application.
   * This method overrides the OnRender function in the base class.
   *
   * @param screen_width
   * @param screen_height
   * @param deltaTime The time elapsed since the last frame, used for updating
   * the rendering accordingly.
   */
  void OnRender(int screen_width, int screen_height, float deltaTime) override {
  }
};

int main() {
  auto game = Entropia();
  game.Run();
  return EXIT_SUCCESS;
}

#endif
