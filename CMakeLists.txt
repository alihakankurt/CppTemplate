cmake_minimum_required(VERSION 4.0.1)
project(hello VERSION 0.1.0 LANGUAGES CXX)

## -------------------------- ##
##   Global CMake Variables   ##
## -------------------------- ##
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/Bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/Bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/Bin)


## -------------------------- ##
##      Compiler Options      ##
## -------------------------- ##
add_library(CompileOptions INTERFACE)

if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    target_compile_options(CompileOptions INTERFACE
        ## Warnings
        -Wall -Wextra # Enable all warnings
        -Wshadow # Local variables shadowing another variable.
        -Wcast-align # Casting that changes the alignment of pointers.
        -Wconversion # Implicit conversions that may alter values.
        -Wsign-conversion # Implicit conversions that may change the sign of integers.
        -Wmissing-noreturn # Functions that could be declared with attribute `noreturn`.
        -Wunreachable-code # Code that will never be executed.
        -Wformat=2 # Stricter use of format strings.

        ## No Warnings
        -Wno-unused-function # No warnings for unused functions.
        -Wno-unused-parameter # No warnings for unused parameters.

        ## Errors
        -Werror=address # Suspicious uses of address expressions.
        -Werror=init-self # Variables that are initialized with themselves.
        -Werror=uninitialized # Variables that are used without having been initialized.
        -Werror=pointer-arith # No void or function pointer arithmetic allowed.
        -Werror=write-strings # C strings must be const char*.
        -Werror=return-type # Mismatched function return types.
        -Werror-string-compare # Unreasonable string comparisons.
        -Werror=switch # Missing cases in switch statements.
        -Werror=implicit-fallthrough # Implicit fallthroughs in switch statements.
        -Werror=missing-include-dirs # Missing include directories that specified by the programmer.

        ## C++ specific
        -Werror=delete-non-virtual-dtor # Deleting non-virtual destructors.
        -Werror=missing-field-initializers # Missing fields in initializers.
        -Werror=pessimizing-move # Pessimizing move operations.
        -fno-rtti # No RTTI.
        -fno-exceptions # No standard exceptions.

        ## Optimization
        $<$<CONFIG:Debug>:-O0 -g3 -ggdb3>
        $<$<CONFIG:Release>:-O3 -march=native>
    )
elseif (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    target_compile_options(CompileOptions INTERFACE
        /W4 # All warnings.
        /utf-8 # Source character set is UTF-8.
        /wd4201 # No warnings for unnamed structs and unions.
        /wd4505 # No warnings for unused functions.

        ## Optimization
        $<$<CONFIG:Debug>:/Od>
        $<$<CONFIG:Release>:/O2>
    )
endif()

# On Windows, don't suggest about safe versions of functions.
if (WIN32)
    target_compile_definitions(CompileOptions INTERFACE
        _CRT_SECURE_NO_WARNINGS
        _CRT_SECURE_NO_WARNINGS_GLOBALS
        _CRT_NONSTDC_NO_WARNINGS
    )
endif()


## -------------------------- ##
##    Include Directories     ##
## -------------------------- ##
add_library(Includes INTERFACE)
target_include_directories(Includes INTERFACE
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/Include>
    $<INSTALL_INTERFACE:Include>
)


## -------------------------- ##
##         Executable         ##
## -------------------------- ##
set(SOURCE_FILES
    Source/Main.cpp
)

add_executable(${PROJECT_NAME} ${SOURCE_FILES})
target_include_directories(${PROJECT_NAME} PRIVATE $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/Source>)
target_link_libraries(${PROJECT_NAME} PRIVATE CompileOptions Includes)


## -------------------------- ##
##       Installation         ##
## -------------------------- ##
install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}Targets
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/Bin
    LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/Lib
    ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/Lib
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/Include/ DESTINATION ${CMAKE_INSTALL_PREFIX}/Include)

install(FILES ${PROJECT_SOURCE_DIR}/LICENSE DESTINATION ${CMAKE_INSTALL_PREFIX})
