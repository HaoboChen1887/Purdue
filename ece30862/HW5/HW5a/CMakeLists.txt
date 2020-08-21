cmake_minimum_required(VERSION 3.12)
project(HW5a)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(HW5a
        Base.cpp
        Base.h
        dPriv.cpp
        dPriv.h
        dProt.cpp
        dProt.h
        dPublic.cpp
        dPublic.h
        main.cpp
        PrivDerived.cpp
        PrivDerived.h
        ProtDerived.cpp
        ProtDerived.h
        PublicDerived.cpp
        PublicDerived.h)
