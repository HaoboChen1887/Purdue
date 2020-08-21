cmake_minimum_required(VERSION 3.12)
project(HW4)

set(CMAKE_CXX_STANDARD 14)

include_directories(HW4)

add_executable(HW4
        HW4/Base.cpp
        HW4/Base.h
        HW4/D1.cpp
        HW4/D1.h
        HW4/D1a.cpp
        HW4/D1a.h
        HW4/D2.cpp
        HW4/D2.h
        HW4/main.cpp)
