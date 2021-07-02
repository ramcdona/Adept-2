
set(ADEPT_SOURCE_HEADER adept_source.h)

string(TIMESTAMP ADEPT_DATE)

get_filename_component(SCRIPTNAME ${CMAKE_CURRENT_LIST_FILE} NAME)

configure_file(${ADEPT_SOURCE_HEADER}.in ${ADEPT_SOURCE_HEADER})

# Done as three globs to ensure order is preserved.
file(GLOB cpiheaderfile RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "../config_platform_independent.h")
file(GLOB headerfiles RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "../adept/*.h")
file(GLOB sourcefiles RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "../adept/*.cpp")
set(files ${cpiheaderfile} ${headerfiles} ${sourcefiles})

foreach(file ${files})
    message(STATUS "Adding ${file}")

    get_filename_component(fname ${file} NAME)

    file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/${ADEPT_SOURCE_HEADER} "\n\n// =================================================================\n// Contents of ")
    file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/${ADEPT_SOURCE_HEADER} ${fname})
    file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/${ADEPT_SOURCE_HEADER} "\n// =================================================================\n\n")

    file(READ ${file} contents)
    file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/${ADEPT_SOURCE_HEADER} "${contents}")
endforeach()

file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/${ADEPT_SOURCE_HEADER} "\n\n\#endif")

message(STATUS "Done")
