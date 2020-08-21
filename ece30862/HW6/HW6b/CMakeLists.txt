cmake_minimum_required(VERSION 3.12)
project(HW6b)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(HW6b
        Base.cpp
        Base.h
        Derived.cpp
        Derived.h
        main.cpp)
