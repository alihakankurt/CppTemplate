cmake_minimum_required(VERSION 4.0.1)
project(Template VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/Lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/Lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/Bin)

include(CMake/SetCompilerFlags.cmake)
include(CMake/Installation.cmake)

add_executable(Hello)

SetCompilerFlags(Hello)

target_include_directories(Hello
    PUBLIC
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/Include>
        $<INSTALL_INTERFACE:Include>
    PRIVATE
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/Source>
)

target_sources(Hello PRIVATE
    Source/Main.cpp
)

InstallTarget(Hello)
InstallProject()
