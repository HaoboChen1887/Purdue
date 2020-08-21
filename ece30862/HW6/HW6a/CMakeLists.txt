cmake_minimum_required(VERSION 3.12)
project(HW6a)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(HW6a
        Alarm.cpp
        Alarm.h
        GPS.cpp
        GPS.h
        main.cpp
        Map.cpp
        Map.h
        Observer.cpp
        Observer.h
        Subject.cpp
        Subject.h)
