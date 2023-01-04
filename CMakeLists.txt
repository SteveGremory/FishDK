cmake_minimum_required(VERSION 3.14)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})

file(GLOB COMPILER_SOURCES
    compiler/frontend/lexer/*.cc
    compiler/frontend/parser/*.cc
    compiler/backend/codegen/*.cc
    compiler/*.cc
)

# FCC -> Fish Compiler Compiler (because we haven't bootstrapped yet)
add_executable(FCC ${COMPILER_SOURCES})
target_include_directories(FCC PUBLIC
    compiler/frontend
    compiler/backend 
)

llvm_map_components_to_libnames(llvm_libs support core irreader)

target_link_libraries(FCC ${llvm_libs})