# it must be a macro, cause 'include_directories' 
# are not propagated to parent scope
macro(eth_defaults)
	set(ETH_DIR             "${CMAKE_CURRENT_LIST_DIR}/../cpp-ethereum"         CACHE PATH "The path to the cpp-ethereum directory")
	set(ETH_BUILD_DIR_NAME  "build"                                             CACHE STRING "The name of the build directory in cpp-ethereum")
	set(ETH_BUILD_DIR       "${ETH_DIR}/${ETH_BUILD_DIR_NAME}")
	set(SOL_DIR             "${CMAKE_CURRENT_LIST_DIR}/../solidity"             CACHE PATH "The path to the solidity directory")
	set(SOL_BUILD_DIR_NAME  "build"                                             CACHE STRING "The name of the build directory in soliditiy")
	set(SOL_BUILD_DIR       "${SOL_DIR}/${SOL_BUILD_DIR_NAME}")

	# A place where we should look for ethereum libraries
	set(CMAKE_LIBRARY_PATH ${ETH_BUILD_DIR} ${CMAKE_LIBRARY_PATH})
	set(CMAKE_LIBRARY_PATH ${SOL_BUILD_DIR} ${CMAKE_LIBRARY_PATH})

	# Include a directory with BuildInfo.h
	include_directories(${ETH_BUILD_DIR})

	# Include Ethereum and Solidity source code
	include_directories(${ETH_DIR})
	include_directories(${SOL_DIR})
endmacro(eth_defaults)
