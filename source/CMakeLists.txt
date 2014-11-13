cmake_minimum_required(VERSION 2.8)

project( video )

find_package( OpenCV REQUIRED )

add_executable( video video.cpp )
target_link_libraries( video ${OpenCV_LIBS} )

add_executable( person person.cpp )
target_link_libraries( person ${OpenCV_LIBS} )

add_executable( optical_flow_demo optical_flow_demo.cpp )
target_link_libraries( optical_flow_demo ${OpenCV_LIBS} )

add_executable( detectcolor detectcolor.cpp )
target_link_libraries( detectcolor ${OpenCV_LIBS} )

