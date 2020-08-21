cmake_minimum_required(VERSION 3.12)
project(HW3b)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(HW3b
        Dog.cpp
        Dog.h
        DogToy.cpp
        DogToy.h
        Duck.cpp
        Duck.h
        DuckSim.cpp
        FlyBehavior.cpp
        FlyBehavior.h
        FlyWithWings.cpp
        FlyWithWings.h
        Mallard.cpp
        Mallard.h
        NoFly.cpp
        NoFly.h
        NoQuack.cpp
        NoQuack.h
        Quack.cpp
        Quack.h
        QuackQuack.cpp
        QuackQuack.h
        RedHead.cpp
        RedHead.h
        Rubber.cpp
        Rubber.h
        Squeak.cpp
        Squeak.h)
