cmake_minimum_required(VERSION 3.10)

project(demo-clocks)

if(ANDROID)
    include(cmake/qt-for-android.cmake)
    set_qt_search_path()
endif()

set(CMAKE_AUTORCC ON)
find_package(Qt5Qml REQUIRED)
find_package(Qt5Quick REQUIRED)

set(SOURCE_FILES
    main.cpp
    clocks.qrc
)

set(USED_LIBRARIES
    Qt5::Qml
    Qt5::Quick
)

if(ANDROID)
    add_android_app(demo-clocks
        SOURCES ${SOURCE_FILES}
	LIBRARIES ${USED_LIBRARIES}
    )
else()
    add_executable(demo-clocks ${SOURCE_FILES}) 
    target_link_libraries(demo-clocks ${USED_LIBRARIES})
endif()
