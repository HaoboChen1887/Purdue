# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.12

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\JetBrains\CLion 2018.2.2\bin\cmake\win\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\JetBrains\CLion 2018.2.2\bin\cmake\win\bin\cmake.exe" -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug"

# Include any dependencies generated for this target.
include CMakeFiles/HW3b.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/HW3b.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/HW3b.dir/flags.make

CMakeFiles/HW3b.dir/Dog.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/Dog.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/Dog.cpp.obj: ../Dog.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/HW3b.dir/Dog.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\Dog.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Dog.cpp"

CMakeFiles/HW3b.dir/Dog.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/Dog.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Dog.cpp" > CMakeFiles\HW3b.dir\Dog.cpp.i

CMakeFiles/HW3b.dir/Dog.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/Dog.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Dog.cpp" -o CMakeFiles\HW3b.dir\Dog.cpp.s

CMakeFiles/HW3b.dir/DogToy.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/DogToy.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/DogToy.cpp.obj: ../DogToy.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/HW3b.dir/DogToy.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\DogToy.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\DogToy.cpp"

CMakeFiles/HW3b.dir/DogToy.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/DogToy.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\DogToy.cpp" > CMakeFiles\HW3b.dir\DogToy.cpp.i

CMakeFiles/HW3b.dir/DogToy.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/DogToy.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\DogToy.cpp" -o CMakeFiles\HW3b.dir\DogToy.cpp.s

CMakeFiles/HW3b.dir/Duck.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/Duck.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/Duck.cpp.obj: ../Duck.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/HW3b.dir/Duck.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\Duck.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Duck.cpp"

CMakeFiles/HW3b.dir/Duck.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/Duck.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Duck.cpp" > CMakeFiles\HW3b.dir\Duck.cpp.i

CMakeFiles/HW3b.dir/Duck.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/Duck.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Duck.cpp" -o CMakeFiles\HW3b.dir\Duck.cpp.s

CMakeFiles/HW3b.dir/DuckSim.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/DuckSim.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/DuckSim.cpp.obj: ../DuckSim.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/HW3b.dir/DuckSim.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\DuckSim.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\DuckSim.cpp"

CMakeFiles/HW3b.dir/DuckSim.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/DuckSim.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\DuckSim.cpp" > CMakeFiles\HW3b.dir\DuckSim.cpp.i

CMakeFiles/HW3b.dir/DuckSim.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/DuckSim.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\DuckSim.cpp" -o CMakeFiles\HW3b.dir\DuckSim.cpp.s

CMakeFiles/HW3b.dir/FlyBehavior.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/FlyBehavior.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/FlyBehavior.cpp.obj: ../FlyBehavior.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/HW3b.dir/FlyBehavior.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\FlyBehavior.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\FlyBehavior.cpp"

CMakeFiles/HW3b.dir/FlyBehavior.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/FlyBehavior.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\FlyBehavior.cpp" > CMakeFiles\HW3b.dir\FlyBehavior.cpp.i

CMakeFiles/HW3b.dir/FlyBehavior.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/FlyBehavior.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\FlyBehavior.cpp" -o CMakeFiles\HW3b.dir\FlyBehavior.cpp.s

CMakeFiles/HW3b.dir/FlyWithWings.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/FlyWithWings.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/FlyWithWings.cpp.obj: ../FlyWithWings.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/HW3b.dir/FlyWithWings.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\FlyWithWings.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\FlyWithWings.cpp"

CMakeFiles/HW3b.dir/FlyWithWings.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/FlyWithWings.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\FlyWithWings.cpp" > CMakeFiles\HW3b.dir\FlyWithWings.cpp.i

CMakeFiles/HW3b.dir/FlyWithWings.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/FlyWithWings.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\FlyWithWings.cpp" -o CMakeFiles\HW3b.dir\FlyWithWings.cpp.s

CMakeFiles/HW3b.dir/Mallard.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/Mallard.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/Mallard.cpp.obj: ../Mallard.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/HW3b.dir/Mallard.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\Mallard.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Mallard.cpp"

CMakeFiles/HW3b.dir/Mallard.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/Mallard.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Mallard.cpp" > CMakeFiles\HW3b.dir\Mallard.cpp.i

CMakeFiles/HW3b.dir/Mallard.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/Mallard.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Mallard.cpp" -o CMakeFiles\HW3b.dir\Mallard.cpp.s

CMakeFiles/HW3b.dir/NoFly.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/NoFly.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/NoFly.cpp.obj: ../NoFly.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/HW3b.dir/NoFly.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\NoFly.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\NoFly.cpp"

CMakeFiles/HW3b.dir/NoFly.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/NoFly.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\NoFly.cpp" > CMakeFiles\HW3b.dir\NoFly.cpp.i

CMakeFiles/HW3b.dir/NoFly.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/NoFly.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\NoFly.cpp" -o CMakeFiles\HW3b.dir\NoFly.cpp.s

CMakeFiles/HW3b.dir/NoQuack.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/NoQuack.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/NoQuack.cpp.obj: ../NoQuack.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object CMakeFiles/HW3b.dir/NoQuack.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\NoQuack.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\NoQuack.cpp"

CMakeFiles/HW3b.dir/NoQuack.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/NoQuack.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\NoQuack.cpp" > CMakeFiles\HW3b.dir\NoQuack.cpp.i

CMakeFiles/HW3b.dir/NoQuack.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/NoQuack.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\NoQuack.cpp" -o CMakeFiles\HW3b.dir\NoQuack.cpp.s

CMakeFiles/HW3b.dir/Quack.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/Quack.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/Quack.cpp.obj: ../Quack.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object CMakeFiles/HW3b.dir/Quack.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\Quack.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Quack.cpp"

CMakeFiles/HW3b.dir/Quack.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/Quack.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Quack.cpp" > CMakeFiles\HW3b.dir\Quack.cpp.i

CMakeFiles/HW3b.dir/Quack.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/Quack.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Quack.cpp" -o CMakeFiles\HW3b.dir\Quack.cpp.s

CMakeFiles/HW3b.dir/QuackQuack.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/QuackQuack.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/QuackQuack.cpp.obj: ../QuackQuack.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object CMakeFiles/HW3b.dir/QuackQuack.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\QuackQuack.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\QuackQuack.cpp"

CMakeFiles/HW3b.dir/QuackQuack.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/QuackQuack.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\QuackQuack.cpp" > CMakeFiles\HW3b.dir\QuackQuack.cpp.i

CMakeFiles/HW3b.dir/QuackQuack.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/QuackQuack.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\QuackQuack.cpp" -o CMakeFiles\HW3b.dir\QuackQuack.cpp.s

CMakeFiles/HW3b.dir/RedHead.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/RedHead.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/RedHead.cpp.obj: ../RedHead.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object CMakeFiles/HW3b.dir/RedHead.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\RedHead.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\RedHead.cpp"

CMakeFiles/HW3b.dir/RedHead.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/RedHead.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\RedHead.cpp" > CMakeFiles\HW3b.dir\RedHead.cpp.i

CMakeFiles/HW3b.dir/RedHead.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/RedHead.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\RedHead.cpp" -o CMakeFiles\HW3b.dir\RedHead.cpp.s

CMakeFiles/HW3b.dir/Rubber.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/Rubber.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/Rubber.cpp.obj: ../Rubber.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_13) "Building CXX object CMakeFiles/HW3b.dir/Rubber.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\Rubber.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Rubber.cpp"

CMakeFiles/HW3b.dir/Rubber.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/Rubber.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Rubber.cpp" > CMakeFiles\HW3b.dir\Rubber.cpp.i

CMakeFiles/HW3b.dir/Rubber.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/Rubber.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Rubber.cpp" -o CMakeFiles\HW3b.dir\Rubber.cpp.s

CMakeFiles/HW3b.dir/Squeak.cpp.obj: CMakeFiles/HW3b.dir/flags.make
CMakeFiles/HW3b.dir/Squeak.cpp.obj: CMakeFiles/HW3b.dir/includes_CXX.rsp
CMakeFiles/HW3b.dir/Squeak.cpp.obj: ../Squeak.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_14) "Building CXX object CMakeFiles/HW3b.dir/Squeak.cpp.obj"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\HW3b.dir\Squeak.cpp.obj -c "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Squeak.cpp"

CMakeFiles/HW3b.dir/Squeak.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW3b.dir/Squeak.cpp.i"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Squeak.cpp" > CMakeFiles\HW3b.dir\Squeak.cpp.i

CMakeFiles/HW3b.dir/Squeak.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW3b.dir/Squeak.cpp.s"
	C:\PROGRA~2\MINGW-~1\I686-8~1.0-P\mingw32\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\Squeak.cpp" -o CMakeFiles\HW3b.dir\Squeak.cpp.s

# Object files for target HW3b
HW3b_OBJECTS = \
"CMakeFiles/HW3b.dir/Dog.cpp.obj" \
"CMakeFiles/HW3b.dir/DogToy.cpp.obj" \
"CMakeFiles/HW3b.dir/Duck.cpp.obj" \
"CMakeFiles/HW3b.dir/DuckSim.cpp.obj" \
"CMakeFiles/HW3b.dir/FlyBehavior.cpp.obj" \
"CMakeFiles/HW3b.dir/FlyWithWings.cpp.obj" \
"CMakeFiles/HW3b.dir/Mallard.cpp.obj" \
"CMakeFiles/HW3b.dir/NoFly.cpp.obj" \
"CMakeFiles/HW3b.dir/NoQuack.cpp.obj" \
"CMakeFiles/HW3b.dir/Quack.cpp.obj" \
"CMakeFiles/HW3b.dir/QuackQuack.cpp.obj" \
"CMakeFiles/HW3b.dir/RedHead.cpp.obj" \
"CMakeFiles/HW3b.dir/Rubber.cpp.obj" \
"CMakeFiles/HW3b.dir/Squeak.cpp.obj"

# External object files for target HW3b
HW3b_EXTERNAL_OBJECTS =

HW3b.exe: CMakeFiles/HW3b.dir/Dog.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/DogToy.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/Duck.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/DuckSim.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/FlyBehavior.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/FlyWithWings.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/Mallard.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/NoFly.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/NoQuack.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/Quack.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/QuackQuack.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/RedHead.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/Rubber.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/Squeak.cpp.obj
HW3b.exe: CMakeFiles/HW3b.dir/build.make
HW3b.exe: CMakeFiles/HW3b.dir/linklibs.rsp
HW3b.exe: CMakeFiles/HW3b.dir/objects1.rsp
HW3b.exe: CMakeFiles/HW3b.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_15) "Linking CXX executable HW3b.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\HW3b.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/HW3b.dir/build: HW3b.exe

.PHONY : CMakeFiles/HW3b.dir/build

CMakeFiles/HW3b.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\HW3b.dir\cmake_clean.cmake
.PHONY : CMakeFiles/HW3b.dir/clean

CMakeFiles/HW3b.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b" "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b" "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug" "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug" "C:\Users\Haobo Chen\OneDrive\Documents\Purdue University\Courses\Fall 2018\ECE 30862\HW3\HW3b\cmake-build-debug\CMakeFiles\HW3b.dir\DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/HW3b.dir/depend
