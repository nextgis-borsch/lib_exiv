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

if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
    install(FILES
            asfvideo.hpp
            basicio.hpp
            bigtiffimage.hpp
            bmpimage.hpp
            config.h
            convert.hpp
            cr2image.hpp
            crwimage.hpp
            datasets.hpp
            easyaccess.hpp
            epsimage.hpp
            error.hpp
            exif.hpp
            exiv2.hpp
            futils.hpp
            gifimage.hpp
            http.hpp
            image.hpp
            ini.hpp
            iptc.hpp
            jp2image.hpp
            jpgimage.hpp
            matroskavideo.hpp
            metadatum.hpp
            mrwimage.hpp
            orfimage.hpp
            pgfimage.hpp
            pngimage.hpp
            preview.hpp
            properties.hpp
            psdimage.hpp
            quicktimevideo.hpp
            rafimage.hpp
            riffvideo.hpp
            rw2image.hpp
            rwlock.hpp
            slice.hpp
            ssh.hpp
            tags.hpp
            tgaimage.hpp
            tiffimage.hpp
            types.hpp
            utilsvideo.hpp
            value.hpp
            version.hpp
            webpimage.hpp
            xmp_exiv2.hpp
            xmpsidecar.hpp
        DESTINATION
            ${INSTALL_INC_DIR}/exiv2)
endif()
