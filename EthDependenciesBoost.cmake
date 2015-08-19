# use multithreaded boost libraries, with -mt suffix
set(Boost_USE_MULTITHREADED ON)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")

# TODO hanlde other msvc versions or it will fail find them
	set(Boost_COMPILER -vc120)
# use static boost libraries *.lib
	set(Boost_USE_STATIC_LIBS ON) 

elseif (APPLE)

# use static boost libraries *.a
	set(Boost_USE_STATIC_LIBS ON) 

elseif (UNIX)
# use dynamic boost libraries .dll
	set(Boost_USE_STATIC_LIBS OFF) 

endif()

find_package(Boost 1.54.0 REQUIRED COMPONENTS thread date_time system regex chrono filesystem unit_test_framework program_options random)

message(" - boost header: ${Boost_INCLUDE_DIRS}")
message(" - boost lib   : ${Boost_LIBRARIES}")
