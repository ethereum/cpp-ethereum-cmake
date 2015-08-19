# we need json rpc to build alethzero
if (NOT JSON_RPC_CPP_FOUND)
	message (FATAL_ERROR "JSONRPC is required for GUI client")
endif()

# find all of the Qt packages
# remember to use 'Qt' instead of 'QT', cause unix is case sensitive
set (ETH_QT_VERSION 5.4)

find_package (Qt5Core ${ETH_QT_VERSION} REQUIRED)
find_package (Qt5Gui ${ETH_QT_VERSION} REQUIRED)
find_package (Qt5Quick ${ETH_QT_VERSION} REQUIRED)
find_package (Qt5Qml ${ETH_QT_VERSION} REQUIRED)
find_package (Qt5Network ${ETH_QT_VERSION} REQUIRED)
find_package (Qt5Widgets ${ETH_QT_VERSION} REQUIRED)
find_package (Qt5WebEngine ${ETH_QT_VERSION} REQUIRED)
find_package (Qt5WebEngineWidgets ${ETH_QT_VERSION} REQUIRED)

if (APPLE AND (NOT "${Qt5Core_VERSION_STRING}" VERSION_LESS "5.5"))
# TODO: remove indirect dependencies once macdeployqt is fixed
	find_package (Qt5WebEngineCore)
	find_package (Qt5DBus)
	find_package (Qt5PrintSupport)
endif()

# we need to find path to macdeployqt on mac
if (APPLE)
	set (MACDEPLOYQT_APP ${Qt5Core_DIR}/../../../bin/macdeployqt)
	message(" - macdeployqt path: ${MACDEPLOYQT_APP}")
endif()

if (WIN32)
	set (WINDEPLOYQT_APP ${Qt5Core_DIR}/../../../bin/windeployqt)
	message(" - windeployqt path: ${WINDEPLOYQT_APP}")
endif()

if (APPLE)
	find_program(ETH_APP_DMG appdmg)
	message(" - appdmg location : ${ETH_APP_DMG}")
endif()
