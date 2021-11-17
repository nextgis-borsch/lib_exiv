# set include path for FindXXX.cmake files
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

include(FindAnyProject)

# # don't use Frameworks on the Mac (#966)
# if (APPLE)
#      set(CMAKE_FIND_FRAMEWORK NEVER)
# endif()

# Check if the conan file exist to find the dependencies
if (EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    set(USING_CONAN ON)
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_basic_setup(NO_OUTPUT_DIRS KEEP_RPATHS TARGETS)
endif()

find_package(Threads REQUIRED)

if( EXIV2_ENABLE_PNG )
    find_anyproject(ZLIB REQUIRED)
endif( )

if( EXIV2_ENABLE_WEBREADY )
    if( EXIV2_ENABLE_CURL )
        find_anyproject(CURL REQUIRED)
    endif()

    if( EXIV2_ENABLE_SSH )
        find_package(libssh CONFIG REQUIRED)
        # Define an imported target to have compatibility with <=libssh-0.9.0
        # libssh-0.9.1 is broken regardless.
        if(NOT TARGET ssh)
            add_library(ssh SHARED IMPORTED)
            set_target_properties(ssh PROPERTIES
                IMPORTED_LOCATION "${LIBSSH_LIBRARIES}"
                INTERFACE_INCLUDE_DIRECTORIES "${LIBSSH_INCLUDE_DIR}"
            )
        endif()
    endif()
endif()

if (EXIV2_ENABLE_XMP AND EXIV2_ENABLE_EXTERNAL_XMP)
    message(FATAL_ERROR "EXIV2_ENABLE_XMP AND EXIV2_ENABLE_EXTERNAL_XMP are mutually exclusive.  You can only choose one of them")
else()
    if (EXIV2_ENABLE_XMP)
        find_anyproject(EXPAT REQUIRED)
    elseif (EXIV2_ENABLE_EXTERNAL_XMP)
        find_package(XmpSdk REQUIRED)
    endif ()
endif()

find_anyproject(ICONV REQUIRED)
