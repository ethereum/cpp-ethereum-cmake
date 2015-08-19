# setup directory for cmake generated files and include it globally 
# it's not used yet, but if we have more generated files, consider moving them to ETH_GENERATED_DIR
set(ETH_GENERATED_DIR "${PROJECT_BINARY_DIR}/gen")
include_directories(${ETH_GENERATED_DIR})
include_directories(${CPPETHEREUM_BUILD})

add_definitions(-DETH_TRUE)

# custom cmake scripts
set(ETH_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(ETH_SCRIPTS_DIR ${ETH_CMAKE_DIR}/scripts)
message(STATUS "CMake Helper Path: ${ETH_CMAKE_DIR}")
message(STATUS "CMake Script Path: ${ETH_SCRIPTS_DIR}")

# from https://github.com/rpavlik/cmake-modules/blob/master/FindWindowsSDK.cmake
if (WIN32)
	find_package(WINDOWSSDK REQUIRED)
	message(STATUS "WindowsSDK dirs: ${WINDOWSSDK_DIRS}")
	set (CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${WINDOWSSDK_DIRS})
endif()

# homebrew installs qts in opt
if (APPLE)
	set (CMAKE_PREFIX_PATH "/usr/local/opt/qt5" ${CMAKE_PREFIX_PATH})
	set (CMAKE_PREFIX_PATH "/usr/local/opt/v8-315" ${CMAKE_PREFIX_PATH})
else()
	set (CMAKE_PREFIX_PATH "${CMAKE_CURRENT_LIST_DIR}/../cpp-ethereum/extdep/install/windows/x64" ${CMAKE_PREFIX_PATH})
endif()

find_program(CTEST_COMMAND ctest)
message(STATUS "ctest path: ${CTEST_COMMAND}")

find_package (CryptoPP 5.6.2 EXACT REQUIRED)
message(STATUS "CryptoPP header: ${CRYPTOPP_INCLUDE_DIRS}")
message(STATUS "CryptoPP lib   : ${CRYPTOPP_LIBRARIES}")

find_package (LevelDB REQUIRED)
message(STATUS "LevelDB header: ${LEVELDB_INCLUDE_DIRS}")
message(STATUS "LevelDB lib: ${LEVELDB_LIBRARIES}")

find_package (RocksDB)
if (ROCKSDB_FOUND)
	message(STATUS "RocksDB header: ${ROCKSDB_INCLUDE_DIRS}")
	message(STATUS "RocksDB lib: ${ROCKSDB_LIBRARIES}")
endif()

if (JSCONSOLE)
	find_package (v8 REQUIRED)
	message(STATUS "v8 header: ${V8_INCLUDE_DIRS}")
	message(STATUS "v8 lib   : ${V8_LIBRARIES}")
	add_definitions(-DETH_JSCONSOLE)
endif()

# TODO the Jsoncpp package does not yet check for correct version number
find_package (Jsoncpp 0.60 REQUIRED)
message(STATUS "Jsoncpp header: ${JSONCPP_INCLUDE_DIRS}")
message(STATUS "Jsoncpp lib   : ${JSONCPP_LIBRARIES}")

# TODO get rid of -DETH_JSONRPC
# TODO add EXACT once we commit ourselves to cmake 3.x
if (JSONRPC)
	find_package (json_rpc_cpp 0.4 REQUIRED)
	message (STATUS "json-rpc-cpp header: ${JSON_RPC_CPP_INCLUDE_DIRS}")
	message (STATUS "json-rpc-cpp lib   : ${JSON_RPC_CPP_LIBRARIES}")
	add_definitions(-DETH_JSONRPC)

 	find_package(MHD) 
	message(STATUS "microhttpd header: ${MHD_INCLUDE_DIRS}")
	message(STATUS "microhttpd lib   : ${MHD_LIBRARIES}")
	message(STATUS "microhttpd dll   : ${MHD_DLLS}")
endif() #JSONRPC

# TODO readline package does not yet check for correct version number
# TODO make readline package dependent on cmake options
# TODO get rid of -DETH_READLINE
find_package (Readline 6.3.8)
if (READLINE_FOUND)
	message (STATUS "readline header: ${READLINE_INCLUDE_DIRS}")
	message (STATUS "readline lib   : ${READLINE_LIBRARIES}")
	add_definitions(-DETH_READLINE)
endif ()

# TODO miniupnpc package does not yet check for correct version number
# TODO make miniupnpc package dependent on cmake options
# TODO get rid of -DMINIUPNPC
find_package (Miniupnpc 1.8.2013)
if (MINIUPNPC_FOUND)
	message (STATUS "miniupnpc header: ${MINIUPNPC_INCLUDE_DIRS}")
	message (STATUS "miniupnpc lib   : ${MINIUPNPC_LIBRARIES}")
	add_definitions(-DETH_MINIUPNPC)
endif()

# TODO gmp package does not yet check for correct version number
# TODO it is also not required in msvc build
find_package (Gmp 6.0.0)
if (GMP_FOUND)
	message(STATUS "gmp header: ${GMP_INCLUDE_DIRS}")
	message(STATUS "gmp lib   : ${GMP_LIBRARIES}")
endif()

# curl is only requried for tests
# TODO specify min curl version, on windows we are currently using 7.29
find_package (CURL)
message(STATUS "curl header: ${CURL_INCLUDE_DIRS}")
message(STATUS "curl lib   : ${CURL_LIBRARIES}")

# cpuid required for eth
find_package (Cpuid)
if (CPUID_FOUND)
	message(STATUS "cpuid header: ${CPUID_INCLUDE_DIRS}")
	message(STATUS "cpuid lib   : ${CPUID_LIBRARIES}")
endif()

find_package (OpenCL)
if (OpenCL_FOUND)
	message(STATUS "opencl header: ${OpenCL_INCLUDE_DIRS}")
	message(STATUS "opencl lib   : ${OpenCL_LIBRARIES}")
endif()

# find location of jsonrpcstub
find_program(ETH_JSON_RPC_STUB jsonrpcstub)
message(STATUS "jsonrpcstub location    : ${ETH_JSON_RPC_STUB}")

# do not compile GUI
if (GUI)
	# we need to find path to windeployqt on windows
	if (USENPM)

		# TODO check node && npm version
		find_program(ETH_NODE node)
		string(REGEX REPLACE "node" "" ETH_NODE_DIRECTORY ${ETH_NODE})
		message(STATUS "nodejs location : ${ETH_NODE}")

		find_program(ETH_NPM npm)
		string(REGEX REPLACE "npm" "" ETH_NPM_DIRECTORY ${ETH_NPM})
		message(STATUS "npm location    : ${ETH_NPM}")

		if (NOT ETH_NODE)
			message(FATAL_ERROR "node not found!")
		endif()
		if (NOT ETH_NPM)
			message(FATAL_ERROR "npm not found!")
		endif()
	endif()

endif() #GUI

if (APPLE)
	link_directories(/usr/local/lib)
	include_directories(/usr/local/include)
endif()

