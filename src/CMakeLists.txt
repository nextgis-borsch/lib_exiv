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

add_library( ${LIB_NAME}
    ../include/exiv2/config.h
    ../include/exiv2/exiv2.hpp
    ../include/exiv2/rwlock.hpp
    ../include/exiv2/slice.hpp
    basicio.cpp             ../include/exiv2/basicio.hpp
    bigtiffimage.cpp
    bmpimage.cpp            ../include/exiv2/bmpimage.hpp
    convert.cpp             ../include/exiv2/convert.hpp
    cr2image.cpp            ../include/exiv2/cr2image.hpp
    crwimage.cpp            ../include/exiv2/crwimage.hpp
    datasets.cpp            ../include/exiv2/datasets.hpp
    easyaccess.cpp          ../include/exiv2/easyaccess.hpp
    epsimage.cpp            ../include/exiv2/epsimage.hpp
    error.cpp               ../include/exiv2/error.hpp
    exif.cpp                ../include/exiv2/exif.hpp
    futils.cpp              ../include/exiv2/futils.hpp
    gifimage.cpp            ../include/exiv2/gifimage.hpp
    http.cpp                ../include/exiv2/http.hpp
    image.cpp               ../include/exiv2/image.hpp
    ini.cpp                 ../include/exiv2/ini.hpp
    iptc.cpp                ../include/exiv2/iptc.hpp
    jp2image.cpp            ../include/exiv2/jp2image.hpp
    jpgimage.cpp            ../include/exiv2/jpgimage.hpp
    metadatum.cpp           ../include/exiv2/metadatum.hpp
    mrwimage.cpp            ../include/exiv2/mrwimage.hpp
    orfimage.cpp            ../include/exiv2/orfimage.hpp
    pgfimage.cpp            ../include/exiv2/pgfimage.hpp
    preview.cpp             ../include/exiv2/preview.hpp
    properties.cpp          ../include/exiv2/properties.hpp
    psdimage.cpp            ../include/exiv2/psdimage.hpp
    rafimage.cpp            ../include/exiv2/rafimage.hpp
    rw2image.cpp            ../include/exiv2/rw2image.hpp
    tags.cpp                ../include/exiv2/tags.hpp
    tgaimage.cpp            ../include/exiv2/tgaimage.hpp
    tiffimage.cpp           ../include/exiv2/tiffimage.hpp
    types.cpp               ../include/exiv2/types.hpp
    value.cpp               ../include/exiv2/value.hpp
    version.cpp             ../include/exiv2/version.hpp
    webpimage.cpp           ../include/exiv2/webpimage.hpp
    xmp.cpp                 ../include/exiv2/xmp_exiv2.hpp
    xmpsidecar.cpp          ../include/exiv2/xmpsidecar.hpp
    $<TARGET_OBJECTS:${LIB_NAME}_int>
)

set(TARGETS ${TARGETS} ${LIB_NAME} PARENT_SCOPE)

generate_export_header(${LIB_NAME}
    EXPORT_MACRO_NAME EXIV2API
    EXPORT_FILE_NAME ${CMAKE_BINARY_DIR}/exiv2lib_export.h
    STATIC_DEFINE ${LIB_NAME}_STATIC
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
    COMPILE_DEFINITIONS ${LIB_NAME}_EXPORTS
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


if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
    install(FILES
        ${CMAKE_BINARY_DIR}/exv_conf.h
        ${CMAKE_BINARY_DIR}/exiv2lib_export.h
        DESTINATION ${INSTALL_INC_DIR}/exiv2)
endif()

message(STATUS "Targets : ${TARGETS}")