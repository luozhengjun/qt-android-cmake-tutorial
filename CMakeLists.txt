cmake_minimum_required(VERSION 3.10)

project(tutorial)

include(cmake/qt-for-android.cmake)
set_qt_search_path()

find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)

set(SOURCE_FILES main.cpp)
set(USED_LIBRARIES
    Qt5::Core
    Qt5::Widgets
)
if(ANDROID)
    add_android_app(tutorial
        SOURCES ${SOURCE_FILES}
        LIBRARIES ${USED_LIBRARIES}
    )
else()
    add_executable(tutorial ${SOURCE_FILES})
    target_link_libraries(tutorial ${USED_LIBRARIES})
endif()

