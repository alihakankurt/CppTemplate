function (SetCompilerFlags TARGET_NAME)

    if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        target_compile_options(${TARGET_NAME} INTERFACE
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
            -Werror=string-compare # Unreasonable string comparisons.
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
        target_compile_options(${TARGET_NAME} INTERFACE
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
        target_compile_definitions(${TARGET_NAME} INTERFACE
            _CRT_SECURE_NO_WARNINGS
            _CRT_SECURE_NO_WARNINGS_GLOBALS
            _CRT_NONSTDC_NO_WARNINGS
        )
    endif()

endfunction()
