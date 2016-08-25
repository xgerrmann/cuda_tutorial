cmake_minimum_required(VERSION 2.8)
# About this project
#-------------------
project(src)

message("${PROJECT_NAME}")

# Add headers and source files here
#-------------------

#find_package(CUDA QUIET REQUIRED)
find_package(CUDA REQUIRED)
if(${CUDA_FOUND})
	message("Cuda found")
endif()
#-------------------
cuda_add_executable(addition addition.cu)

## Linker
##-------------------
target_link_libraries(addition	${CUDA_LIBRARIES})

