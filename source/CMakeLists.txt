cmake_minimum_required(VERSION 2.8)

project( video )

find_package( OpenCV REQUIRED )

add_executable( video video.cpp )
target_link_libraries( video ${OpenCV_LIBS} )

add_executable( opticalflow opticalflow.cpp )
target_link_libraries( opticalflow ${OpenCV_LIBS} )

add_executable( detectcolor detectcolor.cpp )
target_link_libraries( detectcolor ${OpenCV_LIBS} )

add_executable( motiontracking motiontracking.cpp )
target_link_libraries( motiontracking ${OpenCV_LIBS} )

add_executable( optical_flow_demo optical_flow_demo.cpp )
target_link_libraries( optical_flow_demo ${OpenCV_LIBS} )

add_executable( videotracking videotracking.cpp )
target_link_libraries( videotracking ${OpenCV_LIBS} )

add_executable( lkdemo lkdemo.cpp )
target_link_libraries( lkdemo ${OpenCV_LIBS} )

add_executable( circles circles.cpp )
target_link_libraries( circles ${OpenCV_LIBS} )

