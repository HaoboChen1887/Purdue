cmake_minimum_required(VERSION 3.12)
project(HW7)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(HW7
        Base.cpp
        Base.h
        D.cpp
        D.h
        main.cpp)
