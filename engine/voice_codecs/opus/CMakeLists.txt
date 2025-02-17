#//-----------------------------------------------------------------------------
#//	VAUDIO_OPUS.QPC
#//
#//	Project Script
#//-----------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.16)
project(vaudio_opus)
set(SRCDIR "${CMAKE_SOURCE_DIR}")
set(CMAKE_MODULE_PATH ${SRCDIR}/cmake)
set(OUTBINNAME "vaudio_opus_client")
set(OUTBINDIR ${SRCDIR}/../game/bin)

set(NOSTINKYLINKIES "1") #link this project carefully ourselves

include(${CMAKE_MODULE_PATH}/detect_platform.cmake)
include(${CMAKE_MODULE_PATH}/source_dll_base.cmake)

include_directories(${SRCDIR}/engine/audio/public)
include_directories(${SRCDIR}/engine/voice_codecs/frame_encoder)
include_directories(${SRCDIR}/thirdparty/opus/include)


target_sources(${OUTBINNAME} PRIVATE "voiceencoder_opus.cpp")

target_link_libraries(${OUTBINNAME} libtier0_client tier1_client )