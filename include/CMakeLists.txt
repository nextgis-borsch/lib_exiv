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

set(INST_HEADER 
    ${PROJECT_SOURCE_DIR}/include/exiv2/asfvideo.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/basicio.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/bigtiffimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/bmpimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/config.h
    ${PROJECT_SOURCE_DIR}/include/exiv2/convert.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/cr2image.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/crwimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/datasets.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/easyaccess.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/epsimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/error.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/exif.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/exiv2.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/futils.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/gifimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/http.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/image.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/ini.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/iptc.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/jp2image.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/jpgimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/matroskavideo.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/metadatum.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/mrwimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/orfimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/pgfimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/pngimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/preview.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/properties.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/psdimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/quicktimevideo.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/rafimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/riffvideo.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/rw2image.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/rwlock.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/slice.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/ssh.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/tags.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/tgaimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/tiffimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/types.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/utilsvideo.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/value.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/version.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/webpimage.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/xmp_exiv2.hpp
    ${PROJECT_SOURCE_DIR}/include/exiv2/xmpsidecar.hpp
    PARENT_SCOPE
)

add_subdirectory(exiv2)
