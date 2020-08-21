cmake_minimum_required(VERSION 3.12)
project(HW5)

set(CMAKE_CXX_STANDARD 14)

include_directories(HW5a)
include_directories(HW5b)

add_executable(HW5
    HW5a/Base.cpp
    HW5a/Base.h
    HW5a/dPriv.cpp
    HW5a/dPriv.h
    HW5a/dProt.cpp
    HW5a/dProt.h
    HW5a/dPublic.cpp
    HW5a/dPublic.h
    HW5a/main.cpp
    HW5a/PrivDerived.cpp
    HW5a/PrivDerived.h
    HW5a/ProtDerived.cpp
    HW5a/ProtDerived.h
    HW5a/PublicDerived.cpp
    HW5a/PublicDerived.h
    HW5b/Faculty.cpp
    HW5b/Faculty.h
    HW5b/main.cpp
    HW5b/Person.cpp
    HW5b/Person.h
    HW5b/Student.cpp
    HW5b/Student.h)
