cmake_minimum_required(VERSION 3.12)
project(HW5b)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(HW5b
        Faculty.cpp
        Faculty.h
        mainDynamicCast.cpp
        Person.cpp
        Person.h
        Student.cpp
        Student.h)
