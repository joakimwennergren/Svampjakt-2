# Set minimum cmake version
cmake_minimum_required(VERSION 3.28.1)

# Declare project
project(Svampjakt2)

# set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")
# set (CMAKE_LINKER_FLAGS_DEBUG "${CMAKE_LINKER_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")

# set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
# set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")
# set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)

# add_compile_options(-fsanitize=address)
# add_link_options(-fsanitize=address)

# List source files
file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/src/*.cpp)

# Add Entropy
add_subdirectory("/Users/joakimwennergren/Entropy-Engine" Entropy)

# Create the library
add_executable(${PROJECT_NAME} ${SOURCES})

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
target_link_libraries(${PROJECT_NAME}
        Entropy
)
