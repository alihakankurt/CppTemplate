function (InstallTarget TARGET_NAME)

    install(TARGETS ${TARGET_NAME} EXPORT ${TARGET_NAME}Targets
        ARCHIVE DESTINATION "Lib/"
        LIBRARY DESTINATION "Lib/"
        RUNTIME DESTINATION "Bin/"
    )

    get_target_property(target_type ${TARGET_NAME} TYPE)
    if (target_type MATCHES "LIBRARY" AND EXISTS "${CMAKE_PROJECT_DIR}/Include/")
        install(DIRECTORY "${PROJECT_SOURCE_DIR}/Include/"
            DESTINATION "Include"
            FILES_MATCHING
                PATTERN "*.h"
                PATTERN "*.hpp"
        )
    endif()

    install(EXPORT ${TARGET_NAME}Targets
        FILE ${TARGET_NAME}Targets.cmake
        NAMESPACE ${TARGET_NAME}::
        DESTINATION CMake
    )

endfunction()

function (InstallProject)

    foreach (file LICENSE LICENSE.txt LICENSE.md README README.txt README.md)
        if (EXISTS "${PROJECT_SOURCE_DIR}/${file}")
            install(FILES "${PROJECT_SOURCE_DIR}/${file}" DESTINATION .)
        endif()
    endforeach()

endfunction()
