# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.0

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

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.0.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.0.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/kunal/Developer/tennis/Source

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/kunal/Developer/tennis/source

# Include any dependencies generated for this target.
include CMakeFiles/videotracking.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/videotracking.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/videotracking.dir/flags.make

CMakeFiles/videotracking.dir/videotracking.cpp.o: CMakeFiles/videotracking.dir/flags.make
CMakeFiles/videotracking.dir/videotracking.cpp.o: videotracking.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /Users/kunal/Developer/tennis/source/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/videotracking.dir/videotracking.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/videotracking.dir/videotracking.cpp.o -c /Users/kunal/Developer/tennis/Source/videotracking.cpp

CMakeFiles/videotracking.dir/videotracking.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/videotracking.dir/videotracking.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /Users/kunal/Developer/tennis/Source/videotracking.cpp > CMakeFiles/videotracking.dir/videotracking.cpp.i

CMakeFiles/videotracking.dir/videotracking.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/videotracking.dir/videotracking.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /Users/kunal/Developer/tennis/Source/videotracking.cpp -o CMakeFiles/videotracking.dir/videotracking.cpp.s

CMakeFiles/videotracking.dir/videotracking.cpp.o.requires:
.PHONY : CMakeFiles/videotracking.dir/videotracking.cpp.o.requires

CMakeFiles/videotracking.dir/videotracking.cpp.o.provides: CMakeFiles/videotracking.dir/videotracking.cpp.o.requires
	$(MAKE) -f CMakeFiles/videotracking.dir/build.make CMakeFiles/videotracking.dir/videotracking.cpp.o.provides.build
.PHONY : CMakeFiles/videotracking.dir/videotracking.cpp.o.provides

CMakeFiles/videotracking.dir/videotracking.cpp.o.provides.build: CMakeFiles/videotracking.dir/videotracking.cpp.o

# Object files for target videotracking
videotracking_OBJECTS = \
"CMakeFiles/videotracking.dir/videotracking.cpp.o"

# External object files for target videotracking
videotracking_EXTERNAL_OBJECTS =

videotracking: CMakeFiles/videotracking.dir/videotracking.cpp.o
videotracking: CMakeFiles/videotracking.dir/build.make
videotracking: /usr/local/lib/libopencv_videostab.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_video.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_ts.a
videotracking: /usr/local/lib/libopencv_superres.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_stitching.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_photo.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_ocl.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_objdetect.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_nonfree.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_ml.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_legacy.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_imgproc.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_highgui.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_gpu.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_flann.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_features2d.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_core.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_contrib.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_calib3d.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_nonfree.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_ocl.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_gpu.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_photo.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_objdetect.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_legacy.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_video.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_ml.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_calib3d.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_features2d.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_highgui.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_imgproc.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_flann.2.4.9.dylib
videotracking: /usr/local/lib/libopencv_core.2.4.9.dylib
videotracking: CMakeFiles/videotracking.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable videotracking"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/videotracking.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/videotracking.dir/build: videotracking
.PHONY : CMakeFiles/videotracking.dir/build

CMakeFiles/videotracking.dir/requires: CMakeFiles/videotracking.dir/videotracking.cpp.o.requires
.PHONY : CMakeFiles/videotracking.dir/requires

CMakeFiles/videotracking.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/videotracking.dir/cmake_clean.cmake
.PHONY : CMakeFiles/videotracking.dir/clean

CMakeFiles/videotracking.dir/depend:
	cd /Users/kunal/Developer/tennis/source && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/kunal/Developer/tennis/Source /Users/kunal/Developer/tennis/Source /Users/kunal/Developer/tennis/source /Users/kunal/Developer/tennis/source /Users/kunal/Developer/tennis/source/CMakeFiles/videotracking.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/videotracking.dir/depend

