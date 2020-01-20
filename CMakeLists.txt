cmake_minimum_required(VERSION 3.10)

project(tutorial)

if(ANDROID)
    list(APPEND CMAKE_FIND_ROOT_PATH "$ENV{Qt5_Android}")
else()
    list(APPEND CMAKE_PREFIX_PATH "$ENV{Qt5_Host}")
endif()

find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)

if(ANDROID)
    add_library(tutorial SHARED main.cpp)
    set_target_properties(tutorial
        PROPERTIES
        LIBRARY_OUTPUT_NAME tutorial
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
    )
    get_filename_component(ANDROID_APP_SO
        ${CMAKE_BINARY_DIR}/libtutorial.so ABSOLUTE
    )
else()
    add_executable(tutorial main.cpp)
endif()

target_link_libraries(tutorial
    Qt5::Core
    Qt5::Widgets
)
install(TARGETS tutorial
    LIBRARY DESTINATION libs/${CMAKE_ANDROID_ARCH_ABI})

set(CMAKE_INSTALL_PREFIX "")

if(ANDROID)
    add_subdirectory(android)
endif()
