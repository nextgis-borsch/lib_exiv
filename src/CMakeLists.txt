################################################################################
# Copyright (C) 2020, NextGIS <info@nextgis.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
################################################################################

include(CMakePackageConfigHelpers)

include_directories(${CMAKE_CURRENT_BINARY_DIR})


add_library( ${LIB_NAME}_int OBJECT
    canonmn_int.cpp         canonmn_int.hpp
    casiomn_int.cpp         casiomn_int.hpp
    cr2header_int.cpp       cr2header_int.hpp
    crwimage_int.cpp        crwimage_int.hpp
    fujimn_int.cpp          fujimn_int.hpp
    helper_functions.cpp    helper_functions.hpp
    image_int.cpp           image_int.hpp
    makernote_int.cpp       makernote_int.hpp
    minoltamn_int.cpp       minoltamn_int.hpp
    nikonmn_int.cpp         nikonmn_int.hpp
    olympusmn_int.cpp       olympusmn_int.hpp
    orfimage_int.cpp        orfimage_int.hpp
    panasonicmn_int.cpp     panasonicmn_int.hpp
    pentaxmn_int.cpp        pentaxmn_int.hpp
    rw2image_int.cpp        rw2image_int.hpp
    safe_op.hpp
    samsungmn_int.cpp       samsungmn_int.hpp
    sigmamn_int.cpp         sigmamn_int.hpp
    sonymn_int.cpp          sonymn_int.hpp
    tags_int.cpp            tags_int.hpp
    tiffcomposite_int.cpp   tiffcomposite_int.hpp
    tiffimage_int.cpp       tiffimage_int.hpp
    tiffvisitor_int.cpp     tiffvisitor_int.hpp
    tifffwd_int.hpp
    timegm.h
    unused.h
)

set(TARGET_OBJECTS
    basicio.cpp
    bigtiffimage.cpp
    bmpimage.cpp
    convert.cpp
    cr2image.cpp
    crwimage.cpp
    datasets.cpp
    easyaccess.cpp
    epsimage.cpp
    error.cpp
    exif.cpp
    futils.cpp
    gifimage.cpp
    http.cpp
    image.cpp
    ini.cpp
    iptc.cpp
    jp2image.cpp
    jpgimage.cpp
    metadatum.cpp
    mrwimage.cpp
    orfimage.cpp
    pgfimage.cpp
    preview.cpp
    properties.cpp
    psdimage.cpp
    rafimage.cpp
    rw2image.cpp
    tags.cpp
    tgaimage.cpp
    tiffimage.cpp
    types.cpp
    value.cpp
    version.cpp
    webpimage.cpp
    xmp.cpp
    xmpsidecar.cpp
    $<TARGET_OBJECTS:${LIB_NAME}_int>
)

set(INST_HEADER ${INST_HEADER}
    ${CMAKE_BINARY_DIR}/exv_conf.h
    ${CMAKE_BINARY_DIR}/exiv2lib_export.h
)

if(OSX_FRAMEWORK)
    add_library(${LIB_NAME} SHARED ${TARGET_OBJECTS} ${INST_HEADER})
    set_property(SOURCE ${INST_HEADER} PROPERTY MACOSX_PACKAGE_LOCATION "Headers/exiv2")
    set_target_properties(${LIB_NAME} PROPERTIES
      FRAMEWORK TRUE
      FRAMEWORK_VERSION ${FRAMEWORK_VERSION}
      MACOSX_FRAMEWORK_SHORT_VERSION_STRING ${VERSION}
      MACOSX_FRAMEWORK_BUNDLE_VERSION ${VERSION}
      MACOSX_FRAMEWORK_IDENTIFIER org.exiv2
      XCODE_ATTRIBUTE_INSTALL_PATH "@rpath"
      PUBLIC_HEADER "${INST_HEADER}"
    )
else()
    add_library( ${LIB_NAME} ${TARGET_OBJECTS} ${INST_HEADER})
endif()

generate_export_header(${LIB_NAME}
    EXPORT_MACRO_NAME EXIV2API
    EXPORT_FILE_NAME ${CMAKE_BINARY_DIR}/exiv2lib_export.h
    DEPRECATED_MACRO_NAME EXIV2LIB_DEPRECATED
    NO_EXPORT_MACRO_NAME EXIV2LIB_NO_EXPORT
    STATIC_DEFINE exiv2lib_STATIC
    NO_DEPRECATED_MACRO_NAME EXIV2LIB_NO_DEPRECATED 
)

# Conditional addition of sources to library targets
# ---------------------------------------------------------

if( EXIV2_ENABLE_WEBREADY )
    if( EXIV2_ENABLE_CURL)
        target_sources(${LIB_NAME} PRIVATE easyaccess.cpp ../include/exiv2/easyaccess.hpp)
    endif()

    if( EXIV2_ENABLE_SSH )
        target_sources(${LIB_NAME} PRIVATE ssh.cpp ../include/exiv2/ssh.hpp)
    endif()
endif()

if( EXIV2_ENABLE_PNG )
    target_sources(${LIB_NAME}_int PRIVATE pngchunk_int.cpp)
    target_sources(${LIB_NAME} PRIVATE pngimage.cpp ../include/exiv2/pngimage.hpp)
endif()

if( EXIV2_ENABLE_VIDEO )
    target_sources(${LIB_NAME} PRIVATE
        asfvideo.cpp            ../include/exiv2/asfvideo.hpp
        matroskavideo.cpp       ../include/exiv2/matroskavideo.hpp
        quicktimevideo.cpp      ../include/exiv2/quicktimevideo.hpp
        riffvideo.cpp           ../include/exiv2/riffvideo.hpp
        utilsvideo.cpp          ../include/exiv2/utilsvideo.hpp
    )
endif()

# Other library target properties
# ---------------------------------------------------------

if (${CMAKE_CXX_COMPILER_ID} STREQUAL GNU)
    # Do not check format overflows on this file, to skip a false positive warning
    set_source_files_properties(value.cpp PROPERTIES COMPILE_FLAGS -Wno-format-overflow)
endif()

set_target_properties( ${LIB_NAME} PROPERTIES
    VERSION       ${PROJECT_VERSION}
    SOVERSION     ${PROJECT_VERSION_MINOR}
    PDB_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMPILE_FLAGS ${EXTRA_COMPILE_FLAGS}
)

if (MSVC)
    set_target_properties(${LIB_NAME} PROPERTIES LINK_FLAGS "/ignore:4099")
endif()

set_target_properties( ${LIB_NAME}_int PROPERTIES
    POSITION_INDEPENDENT_CODE ON
    COMPILE_DEFINITIONS exiv_EXPORTS
)

target_include_directories(${LIB_NAME}_int PRIVATE ${ZLIB_INCLUDE_DIR})
target_include_directories(${LIB_NAME} PRIVATE ${ZLIB_INCLUDE_DIR})

if (EXIV2_ENABLE_XMP)
    target_link_libraries(${LIB_NAME} PRIVATE ${LIB_NAME}-xmp)
elseif(EXIV2_ENABLE_EXTERNAL_XMP)
    target_link_libraries(${LIB_NAME} PUBLIC ${XMPSDK_LIBRARY})
    target_include_directories(${LIB_NAME} PUBLIC ${XMPSDK_INCLUDE_DIR})
    target_compile_definitions(${LIB_NAME} PUBLIC EXV_ADOBE_XMPSDK=2016)
endif()

# Use include/exiv2 to build libary code
target_include_directories(${LIB_NAME} PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include/exiv2>
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_include_directories(${LIB_NAME}_int PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include/exiv2>
)

if (EXIV2_ENABLE_WEBREADY)

    if( EXIV2_ENABLE_SSH )
        target_link_libraries(${LIB_NAME} PUBLIC ssh)
    endif()

    if( EXIV2_ENABLE_CURL )
        target_include_directories(${LIB_NAME} SYSTEM PRIVATE ${CURL_INCLUDE_DIR} )
        target_link_libraries(${LIB_NAME} PRIVATE ${CURL_LIBRARIES})
        if (USING_CONAN)
            target_compile_definitions(${LIB_NAME} PRIVATE ${CONAN_COMPILE_DEFINITIONS_LIBCURL})
            target_link_libraries(${LIB_NAME} PRIVATE ${CONAN_EXE_LINKER_FLAGS_LIBCURL})
            if ( MSVC ) 
                target_link_libraries(${LIB_NAME} PRIVATE Crypt32)
            elseif (NOT APPLE)
                target_link_libraries(${LIB_NAME} PRIVATE CONAN_PKG::OpenSSL)
            endif()
        endif()
    endif()

endif()

if (WIN32)
    target_compile_definitions(${LIB_NAME} PRIVATE PSAPI_VERSION=1) # to be compatible with <= WinVista (#905)
endif()

if (NOT MSVC)
    if ( CMAKE_SYSTEM_NAME STREQUAL "FreeBSD" )
        target_link_libraries( ${LIB_NAME} PRIVATE -lprocstat)
    endif()

    if (CYGWIN OR MINGW OR MSYS)
        target_link_libraries( ${LIB_NAME} PRIVATE psapi ws2_32 shell32 )
    endif()

    target_link_libraries( ${LIB_NAME} PRIVATE Threads::Threads)
else()
    target_link_libraries( ${LIB_NAME} PRIVATE psapi ws2_32 shell32 )
endif()

if( EXIV2_ENABLE_PNG )
    target_link_libraries( ${LIB_NAME} PRIVATE ${ZLIB_LIBRARIES} )
endif()

if( ICONV_FOUND )
    target_link_libraries( ${LIB_NAME} PRIVATE ${ICONV_LIBRARIES} )
endif()

# Add all targets to the build-tree export set
export(TARGETS ${TARGETS}
   FILE ${PROJECT_BINARY_DIR}/${PACKAGE_UPPER_NAME}Targets.cmake)

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
    install(FILES
        ${CMAKE_BINARY_DIR}/exv_conf.h
        ${CMAKE_BINARY_DIR}/exiv2lib_export.h
        DESTINATION ${INSTALL_INC_DIR})
endif()

if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
    install(TARGETS ${TARGETS}
        EXPORT ${PACKAGE_UPPER_NAME}Targets
        RUNTIME DESTINATION ${INSTALL_BIN_DIR}
        LIBRARY DESTINATION ${INSTALL_LIB_DIR}
        ARCHIVE DESTINATION ${INSTALL_LIB_DIR}
        INCLUDES DESTINATION ${INSTALL_INC_DIR}
        FRAMEWORK DESTINATION ${INSTALL_LIB_DIR} )
        
    # Install the <Package>Config.cmake
    install(FILES
     ${PROJECT_BINARY_DIR}/${PACKAGE_UPPER_NAME}Config.cmake
     DESTINATION ${INSTALL_CMAKECONF_DIR} COMPONENT dev)

    # Install the export set for use with the install-tree
    install(EXPORT ${PACKAGE_UPPER_NAME}Targets DESTINATION ${INSTALL_CMAKECONF_DIR} COMPONENT dev)
endif()