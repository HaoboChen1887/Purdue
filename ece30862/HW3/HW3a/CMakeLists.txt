cmake_minimum_required(VERSION 3.12)
project(HW3a)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(HW3a
        Base.cpp
        Base.h
        Derived.cpp
        Derived.h
        main.cpp)
