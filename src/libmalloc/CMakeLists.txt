project(darling-libsystem_malloc)

cmake_minimum_required(VERSION 2.4.0)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse -msse2 -msse3 -w -fblocks -ggdb")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__DARWIN_UNIX03 -fPIC -w -include ${CMAKE_CURRENT_SOURCE_DIR}/../duct/include/commpage.h -nostdinc")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -nostdlib -Wl,--version-script=${DARLING_TOP_DIRECTORY}/darwin.map")

if(CMAKE_SIZEOF_VOID_P EQUAL 4 OR CMAKE_INSTALL_LIBDIR STREQUAL "lib32")
	set(BITS 32)
	add_definitions(-DTARGET_CPU_X86=1)
else(CMAKE_SIZEOF_VOID_P EQUAL 4 OR CMAKE_INSTALL_LIBDIR STREQUAL "lib32")
	set(BITS 64)
	add_definitions(-DTARGET_CPU_X86_64=1)
endif(CMAKE_SIZEOF_VOID_P EQUAL 4 OR CMAKE_INSTALL_LIBDIR STREQUAL "lib32")

add_definitions(-DTARGET_OS_MAC=1)
add_definitions(-DHAVE_STDINT_H=1)
add_definitions(-D__APPLE__ -D__DYNAMIC__)
add_definitions("'-DMAGMALLOC_MALLOCERRORBREAK()='")

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/malloc)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../libc/gen)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../kernel/libsyscall)

set(libmalloc_sources
	src/bitarray.c
	src/magazine_malloc.c
	src/malloc.c
	src/nano_malloc.c
	src/stack_logging.c
	src/stack_logging_disk.c
)

SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/darling")
SET(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE) 
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

add_library(system_malloc SHARED ${libmalloc_sources})

install(TARGETS system_malloc DESTINATION ${CMAKE_INSTALL_LIBDIR}/darling)

