set(DIST_URL "https://download.microsoft.com/download/7bf9fad4-0f21-486d-a750-fc990ded5624/amd64/1033/msodbcsql.msi")
set(SHA512 9BA470D95673EEB7A5E7D3759AB86410556E77CC24B018CCB8ADD044D7086ADE4AE762B588440E1C0E31E6ED8642C36EF75BF14D24F0C75C3D88AFFD4C862F02)

set(ODBC_EXTRACT_DIR ${CURRENT_BUILDTREES_DIR}/archive)
set(ODBC_SDK_ROOT_DIR "${ODBC_EXTRACT_DIR}\\Program Files\\Microsoft SQL Server\\Client SDK\\ODBC\\180\\SDK")

if (EXISTS ${ODBC_EXTRACT_DIR})
    file(REMOVE_RECURSE ${ODBC_EXTRACT_DIR})
endif ()

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
