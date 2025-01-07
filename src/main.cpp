#include <application/application.hpp>
#include <scripting/lua.hpp>
#include <servicelocators/servicelocator.hpp>

struct Entropia final : Entropy::EntryPoints::Application {
    /**
     * Initializes the application by retrieving the Lua scripting service from the service locator
     * and executing the main Lua script.
     * This method overrides the OnInit function in the base class.
     */
    void OnInit() override {
        const ServiceLocator *sl = ServiceLocator::GetInstance();
        const auto lua = sl->getService<ILua>();
        lua->SetBasePath("/Users/joakimwennergren/Entropia/");
        lua->Get()->script_file("../scripts/main.lua");
    }

    /**
     * Handles the rendering of the application.
     * This method overrides the OnRender function in the base class.
     *
     * @param screen_width
     * @param screen_height
     * @param deltaTime The time elapsed since the last frame, used for updating the rendering accordingly.
     */
    void OnRender(float screen_width, float screen_height, float deltaTime) override {
    }
};

int main() {
    auto game = Entropia();
    game.Run();
    return EXIT_SUCCESS;
}
