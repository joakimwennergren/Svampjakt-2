# Set minimum cmake version
cmake_minimum_required(VERSION 3.28.1)

# Declare project
project(Svampjakt2)

# set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")
# set (CMAKE_LINKER_FLAGS_DEBUG "${CMAKE_LINKER_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")

# set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
# set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")
# set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)

#add_compile_options(-fsanitize=address)
#add_link_options(-fsanitize=address)

set(CMAKE_XCODE_GENERATE_SCHEME TRUE)

# List source files
file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/src/*.cpp)

# Add Entropy
add_subdirectory("/Users/joakimwennergren/Entropy-Engine" Entropy)


# Create the executable
add_executable(${PROJECT_NAME}
        iOS/LaunchScreen.storyboard
        iOS/UI.swift
        scripts
        sounds
        sprites
        fonts
        /Users/joakimwennergren/Entropy-Engine/shaders/compiled/static
        ${SOURCES}
)

set_target_properties(${PROJECT_NAME} PROPERTIES
        BUNDLE_IDENTIFIER se.databeam.svampjakt_debug
        XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER se.databeam.svampjakt_debug
        XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "YES"
        XCODE_ATTRIBUTE_CLANG_ENABLE_MODULES "YES"
        XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@executable_path/Frameworks"
        XCODE_ATTRIBUTE_CODE_SIGN_STYLE "Automatic" # already default value
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
        MACOSX_BUNDLE_SHORT_VERSION_STRING 1.0.0
        MACOSX_BUNDLE_BUNDLE_VERSION 1.0.0
        XCODE_ATTRIBUTE_DEVELOPMENT_TEAM "HC784924PR"
        #XCODE_EMBED_FRAMEWORKS "${Vulkan_MoltenVK_LIBRARY};${Vulkan_LIBRARIES};"
        #XCODE_EMBED_FRAMEWORKS_CODE_SIGN_ON_COPY "YES"
        XCODE_EMBED_FRAMEWORKS_REMOVE_HEADERS_ON_COPY "YES"
        XCODE_ATTRIBUTE_SKIP_INSTALL NO
        XCODE_ATTRIBUTE_INSTALL_PATH "$(LOCAL_APPS_DIR)"
        XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_APPICON_NAME "AppIcon"
        XCODE_ATTRIBUTE_DEAD_CODE_STRIPPING NO
)

set_source_files_properties(
        iOS/LaunchScreen.storyboard
        scripts
        sounds
        sprites
        fonts
        /Users/joakimwennergren/Entropy-Engine/shaders/compiled/static
        PROPERTIES
        MACOSX_PACKAGE_LOCATION Resources

)

# Compiler flags
if (MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17 /utf-8")
endif (MSVC)

include_directories(${PROJECT_NAME} PUBLIC
        src/
)

# Compiler flags
# target_compile_options(${PROJECT_NAME} PUBLIC -std=c++17)

# Link common dependencies
#target_link_libraries(${PROJECT_NAME}
#        Entropy
#)

target_link_libraries(${PROJECT_NAME} PRIVATE Entropy)
