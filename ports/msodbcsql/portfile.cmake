
set(ODBC_EXTRACT_DIR ${CURRENT_BUILDTREES_DIR}/archive)
if (EXISTS ${ODBC_EXTRACT_DIR})
    file(REMOVE_RECURSE ${ODBC_EXTRACT_DIR})
endif ()

if(VCPKG_TARGET_IS_WINDOWS)
    set(DIST_URL "https://download.microsoft.com/download/7bf9fad4-0f21-486d-a750-fc990ded5624/amd64/1033/msodbcsql.msi")
    set(SHA512 9BA470D95673EEB7A5E7D3759AB86410556E77CC24B018CCB8ADD044D7086ADE4AE762B588440E1C0E31E6ED8642C36EF75BF14D24F0C75C3D88AFFD4C862F02)
    set(ODBC_SDK_ROOT_DIR "${ODBC_EXTRACT_DIR}\\Program Files\\Microsoft SQL Server\\Client SDK\\ODBC\\180\\SDK")
    vcpkg_download_distfile(
        MSI_LOC
        URLS ${DIST_URL}
        FILENAME msodbcsql.msi
        SHA512 ${SHA512}
    )
    vcpkg_extract_archive(
        ARCHIVE ${MSI_LOC}
        DESTINATION ${ODBC_EXTRACT_DIR}
    )
    file(COPY ${ODBC_SDK_ROOT_DIR}/include/msodbcsql.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
    file(COPY ${ODBC_SDK_ROOT_DIR}/lib/x64/msodbcsql18.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    file(COPY ${CMAKE_CURRENT_LIST_DIR}/msodbcsqlConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/msodbcsql)
    vcpkg_install_copyright(FILE_LIST "${ODBC_SDK_ROOT_DIR}/../License Terms/License_msodbcsql_ENU.txt")
elseif (VCPKG_TARGET_IS_APPLE)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
    set(DIST_URL "https://download.microsoft.com/download/28977c7a-6a67-4e76-aaf6-7d8516ef91d8/msodbcsql18-18.7.1.1-arm64.tar.gz")
    set(ODBC_SDK_ROOT_DIR "${ODBC_EXTRACT_DIR}\\msodbcsql-18.7.1.1")
    vcpkg_download_distfile(
        ARCHIVE_LOC
        URLS ${DIST_URL}
        FILENAME msodbcsql18.tar.gz
        SHA512 ebc4e463472013a71b5608db772a150a8bfe42833a683a8e466bcb4c4a210502e075ea048cbd41d840be854b19a2f065f989f3fa0fe01a6f0e21e32e1837f298
    )
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
        set(DIST_URL "https://download.microsoft.com/download/28977c7a-6a67-4e76-aaf6-7d8516ef91d8/msodbcsql18-18.7.1.1-amd64.tar.gz")
        set(ODBC_SDK_ROOT_DIR "${ODBC_EXTRACT_DIR}\\msodbcsql-18.7.1.1")
        vcpkg_download_distfile(
            ARCHIVE_LOC
            URLS ${DIST_URL}
            FILENAME msodbcsql18.tar.gz
            SHA512 ffa0896de0d25b12279787280067f08ffac2da0729358b6df6ae47bb60f818226a934c37f17ef34cb035ae11bda3cc83b6ef615165fd1d90932a3f59283655e0
        )
    else ()
        message(FATAL_ERROR "Unsupported target architecture ${VCPKG_TARGET_ARCHITECTURE}")
    endif ()
    vcpkg_extract_archive(
        ARCHIVE ${ARCHIVE_LOC}
        DESTINATION ${ODBC_EXTRACT_DIR}
    )
    file(COPY ${ODBC_SDK_ROOT_DIR}/include/msodbcsql18/msodbcsql.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
    file(COPY ${ODBC_SDK_ROOT_DIR}/lib/libmsodbcsql.18.dylib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    file(COPY ${CMAKE_CURRENT_LIST_DIR}/msodbcsqlConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/msodbcsql)
    vcpkg_install_copyright(FILE_LIST "${ODBC_SDK_ROOT_DIR}/share/doc/msodbcsql18/LICENSE.txt")
endif ()
