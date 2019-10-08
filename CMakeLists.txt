cmake_minimum_required(VERSION 3.1.0)

project(wayland-log-reader)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if (CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

find_package(Qt5 COMPONENTS Widgets Quick WaylandCompositor REQUIRED)

add_executable(wayland-log-reader
    main.cpp
    qml.qrc
)

target_link_libraries(wayland-log-reader
    Qt5::Widgets
    Qt5::Quick
)
