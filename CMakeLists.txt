cmake_minimum_required(VERSION 2.6)

PROJECT (RocinPrototype) 

FILE(GLOB SOURCE_FILES *.cpp)
FILE(GLOB INCLUDE_FILES *.h) 

SET(TARGET "Rocin_Prototype" CACHE STRING "Name of example to build")

SET(CMAKE_CONFIGURATION_TYPES "RelWithDebInfo;Release;Debug"
      CACHE STRING "Semicolon separated list of supported configuration types, only supports Debug, Release, MinSizeRel, and RelWithDebInfo, anything else will be ignored." FORCE )

SET(OPENSIM_INSTALL_DIR "C:/!Libs/OpenSim-4" 
		CACHE PATH "Top-level directory of OpenSim install")
SET(SIMBODY_INSTALL_DIR "C:/!Libs/Simbody" 
		CACHE PATH "Top-level directory of Simbody install")

# Location of headers
SET(SIMTK_HEADERS_DIR ${OPENSIM_INSTALL_DIR}/sdk/include/SimTK/include)
SET(OPENSIM_HEADERS_DIR ${OPENSIM_INSTALL_DIR}/sdk/include)
SET(SIMBODY_HEADERS_DIR ${SIMBODY_INSTALL_DIR}/include)
INCLUDE_DIRECTORIES(${SIMTK_HEADERS_DIR} ${OPENSIM_HEADERS_DIR} ${SIMBODY_HEADERS_DIR})
# Libraries and dlls
SET(OPENSIM_LIBS_DIR ${OPENSIM_INSTALL_DIR}/sdk/lib)
SET(OPENSIM_DLLS_DIR ${OPENSIM_INSTALL_DIR}/bin)
SET(SIMBODY_LIBS_DIR ${SIMBODY_INSTALL_DIR}/lib)
SET(SIMBODY_DLLS_DIR ${SIMBODY_INSTALL_DIR}/bin)
LINK_DIRECTORIES(${OPENSIM_LIBS_DIR} ${OPENSIM_DLLS_DIR} ${SIMBODY_LIBS_DIR} ${SIMBODY_DLLS_DIR})

SET(NameSpace "" CACHE STRING "Prefix for simtk lib names, includes trailing '_'. Leave empty to use stock SimTK libraries.")

IF(WIN32)
	SET(PLATFORM_LIBS  pthreadVC2_x64)
ELSE (WIN32)
  SET(NameSpace "")
  IF(APPLE)
	SET(PLATFORM_LIBS  SimTKAtlas)
  ELSE(APPLE)
	SET(PLTAFORM_LIBS SimTKAtlas_Lin_generic)
  ENDIF(APPLE)
ENDIF (WIN32)

LINK_LIBRARIES(
	debug osimCommon_d optimized osimCommon
	debug osimSimulation_d optimized osimSimulation
	debug osimAnalyses_d optimized osimAnalyses
	debug osimActuators_d optimized osimActuators
	debug osimTools_d optimized osimTools
	debug ${NameSpace}SimTKcommon_d optimized ${NameSpace}SimTKcommon
	debug ${NameSpace}SimTKmath_d optimized  ${NameSpace}SimTKmath
	debug ${NameSpace}SimTKsimbody_d optimized ${NameSpace}SimTKsimbody
	#SimTKlapack
	liblapack
	${PLATFORM_LIBS})


ADD_EXECUTABLE(${TARGET}  ${SOURCE_FILES} ${INCLUDE_FILES}) 

#IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
#	SET(CMAKE_INSTALL_PREFIX ${EXECUTABLE_OUTPUT_PATH}
#			CACHE STRING "Install path prefix." FORCE)
#ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

MARK_AS_ADVANCED(CMAKE_INSTALL_PREFIX)

SET_TARGET_PROPERTIES(
	${TARGET} PROPERTIES
	PROJECT_LABEL RocinPrototype)

#INSTALL_TARGETS(/bin ${TARGET})