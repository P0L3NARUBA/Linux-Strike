include("${CMAKE_MODULE_PATH}/common_functions.cmake")
include("${CMAKE_MODULE_PATH}/source_posix_base.cmake")

MacroRequired(OUTBINNAME)
MacroRequired(OUTBINDIR)

set(OUTBINDIR "${OUTBINDIR}${PLATSUBDIR}")

#set(ConfigurationType "Dynamic Library (.dll)") #not used

#Target
add_library(${OUTBINNAME} SHARED)

#		$GameOutputFile					"$OUTBINDIR/$OUTBINNAME$OUTDLLEXT"
#		$OutputFile					"$(OBJ_DIR)/$OUTBINNAME$OUTDLLEXT"
set_target_properties(${OUTBINNAME} PROPERTIES OUTPUT_NAME "${OUTBINNAME}")
set_target_properties(${OUTBINNAME} PROPERTIES SUFFIX "${OUTDLLEXT}")
set_target_properties(${OUTBINNAME} PROPERTIES PREFIX "")

target_compile_definitions(${OUTBINNAME} PRIVATE -DDLLNAME=${OUTBINNAME})

# Make SURE we dont have undefined symbols
if( LINUXALL )
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--no-undefined")
endif()

message("Adding dll target: ${OUTBINNAME}${OUTDLLEXT}\n")

set_target_properties( ${OUTBINNAME} PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${OUTBINDIR}"
        LIBRARY_OUTPUT_DIRECTORY "${OUTBINDIR}"
        RUNTIME_OUTPUT_DIRECTORY "${OUTBINDIR}"
        RUNTIME_OUTPUT_DIRECTORY_RELEASE "${OUTBINDIR}"
        RUNTIME_OUTPUT_DIRECTORY_DEBUG "${OUTBINDIR}"
        )

if( NOSKELETONBASE )
    message(STATUS "Not including Skeleton base.")
else()
    # Skeleton Project - All derived projects get this as a starting base
    target_sources(${OUTBINNAME} PRIVATE "${SRCDIR}/public/tier0/memoverride.cpp")
endif()
