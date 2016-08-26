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
cuda_add_executable(addition_parallel addition_parallel.cu)
cuda_add_executable(addition_threads addition_threads.cu)
cuda_add_executable(addition_threads_and_blocks addition_threads_and_blocks.cu)

## Linker
##-------------------
target_link_libraries(addition	${CUDA_LIBRARIES})
target_link_libraries(addition_parallel	${CUDA_LIBRARIES})
target_link_libraries(addition_threads	${CUDA_LIBRARIES})
target_link_libraries(addition_threads_and_blocks	${CUDA_LIBRARIES})

