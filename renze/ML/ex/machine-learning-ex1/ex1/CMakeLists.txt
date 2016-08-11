cmake_minimum_required (VERSION 2.8)
project (squirrel C CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g")
set(CMAKE_CXX_FLAGS_RELEASE "-O2")
set(CMAKE_BUILD_TYPE "Debug")

# OpenCV release
find_package(OpenCV REQUIRED COMPONENTS core highgui imgproc objdetect video)
include_directories(SYSTEM ${OpenCV_INCLUDE_DIRS})
list(APPEND squirrel_LINKER_LIBS ${OpenCV_LIBS})

# OpenCV 2.4.9 debug
# include source code
#include_directories("/disk/usr/local/include")
#list(APPEND squirrel_LINKER_LIBS "/disk/usr/local/lib/libopencv_core.so")
#list(APPEND squirrel_LINKER_LIBS "/disk/usr/local/lib/libopencv_highgui.so")
#list(APPEND squirrel_LINKER_LIBS "/disk/usr/local/lib/libopencv_imgproc.so")
#list(APPEND squirrel_LINKER_LIBS "/disk/usr/local/lib/libopencv_objdetect.so")
#list(APPEND squirrel_LINKER_LIBS "/disk/usr/local/lib/libopencv_video.so")
#list(APPEND squirrel_LINKER_LIBS "/usr/lib/x86_64-linux-gnu/libglog.so")

# Boost
find_package(Boost REQUIRED COMPONENTS system filesystem program_options)
include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
list(APPEND squirrel_LINKER_LIBS
    ${Boost_SYSTEM_LIBRARIES}
    ${Boost_FILESYSTEM_LIBRARY}
    ${Boost_PROGRAM_OPTIONS_LIBRARY})

# OpenCV 3.0
#include_directories("/home/kangyong/opencv-3.1.0/include")
#list(APPEND squirrel_LINKER_LIBS "/home/kangyong/opencv-3.1.0/build/lib/libopencv_core.so")
#list(APPEND squirrel_LINKER_LIBS "/home/kangyong/opencv-3.1.0/build/lib/libopencv_highgui.so")
#list(APPEND squirrel_LINKER_LIBS "/home/kangyong/opencv-3.1.0/build/lib/libopencv_imgproc.so")
#list(APPEND squirrel_LINKER_LIBS "/home/kangyong/opencv-3.1.0/build/lib/libopencv_objdetect.so")
#list(APPEND squirrel_LINKER_LIBS "/home/kangyong/opencv-3.1.0/build/lib/libopencv_videoio.so")
#list(APPEND squirrel_LINKER_LIBS "/home/kangyong/opencv-3.1.0/build/lib/libopencv_video.so")
#list(APPEND squirrel_LINKER_LIBS "/home/kangyong/opencv-3.1.0/build/lib/libopencv_imgcodecs.so")
#list(APPEND squirrel_LINKER_LIBS "/usr/lib/x86_64-linux-gnu/libglog.so")


set(PROJECT_ROOT "../..")

include_directories(${PROJECT_ROOT}/include)
set(MODULE_SRC_ROOT ${PROJECT_ROOT}/src/squirrel)
file(GLOB src_files ${MODULE_SRC_ROOT}/*.cpp)

add_executable(main main.cpp ${src_files})
target_link_libraries(main ${squirrel_LINKER_LIBS})
