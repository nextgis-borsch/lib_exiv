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

add_library(${LIB_NAME}-xmp STATIC
    src/ExpatAdapter.cpp
    src/MD5.cpp
    src/ParseRDF.cpp
    src/UnicodeConversions.cpp
    src/WXMPIterator.cpp
    src/WXMPMeta.cpp
    src/WXMPUtils.cpp
    src/XML_Node.cpp
    src/XMPCore_Impl.cpp
    src/XMPIterator.cpp
    src/XMPMeta-GetSet.cpp
    src/XMPMeta-Parse.cpp
    src/XMPMeta-Serialize.cpp
    src/XMPMeta.cpp
    src/XMPUtils-FileInfo.cpp
    src/XMPUtils.cpp
    include/MD5.h
    include/TXMPIterator.hpp
    include/TXMPMeta.hpp
    include/TXMPUtils.hpp
    include/XMP_Const.h
    include/XMP_Environment.h
    include/XMP.incl_cpp
    include/XMPSDK.hpp
    include/XMP_Version.h
)

target_link_libraries(${LIB_NAME}-xmp
    PRIVATE 
        ${EXPAT_LIBRARY}
)

target_include_directories(${LIB_NAME}-xmp
    PUBLIC 
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/xmpsdk/include>
    PRIVATE 
        ${EXPAT_INCLUDE_DIR}
)

# Prevent a denial-service-attack related to XML entity expansion
# ("billion laughs attack").
# See https://bugzilla.redhat.com/show_bug.cgi?id=888769
target_compile_definitions(${LIB_NAME}-xmp PRIVATE BanAllEntityUsage=1)
if (MSVC)
    target_compile_definitions(${LIB_NAME}-xmp PRIVATE XML_STATIC)
endif()

check_include_file( "stdint.h"  EXV_HAVE_STDINT_H )
if (EXV_HAVE_STDINT_H)
    target_compile_definitions(${LIB_NAME}-xmp PRIVATE EXV_HAVE_STDINT_H)
endif()

if (BUILD_SHARED_LIBS)
    set_property(TARGET ${LIB_NAME}-xmp PROPERTY POSITION_INDEPENDENT_CODE ON)
endif()