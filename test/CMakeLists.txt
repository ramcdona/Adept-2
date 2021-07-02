function(add_adept_test2 TESTNAME TESTSOURCE)
    set(TEST_HEADERS
            algorithm.h
            algorithm_with_and_without_ad.h)
    set(TEST_ADDITIONAL "")
    foreach(arg IN LISTS ARGN)
        set(TEST_ADDITIONAL ${TEST_ADDITIONAL} ${arg})
    endforeach()
    add_executable(${TESTNAME} ${TESTSOURCE} ${TEST_HEADERS} ${TEST_ADDITIONAL})
    target_link_libraries(${TESTNAME}
            PRIVATE
            adept::adept)
    add_test(NAME ${TESTNAME} COMMAND ./${TESTNAME})
endfunction()

function(add_adept_test TESTNAME)
    add_adept_test2( ${TESTNAME} ${TESTNAME}.cpp ${ARGN})
endfunction()

add_adept_test(test_adept algorithm.cpp)
# add_adept_test(test_adept_with_and_without_ad algorithm.cpp)
add_adept_test(test_array_derivatives)
add_adept_test(test_array_speed)
add_adept_test(test_arrays)
add_adept_test(test_checkpoint)
add_adept_test(test_constructors)
add_adept_test(test_derivatives)
add_adept_test(test_fixed_arrays)
#add_adept_test(test_gsl_interface)
add_adept_test(test_misc algorithm.cpp)

add_executable(test_no_lib test_no_lib.cpp algorithm.cpp )
target_include_directories(test_no_lib PRIVATE ${ADEPT_INCLUDE_DIR})
add_test(NAME test_no_lib COMMAND ./test_no_lib)

add_adept_test(test_radiances simulate_radiances.cpp)
add_adept_test(test_radiances_array simulate_radiances.cpp)
add_adept_test(test_thread_safe)
add_adept_test(test_thread_safe_arrays)
add_adept_test(test_packet_operations)
add_adept_test(test_fastexp)
add_adept_test(test_reduce_active)
add_adept_test(test_minimizer)

add_adept_test2(test_arrays_active test_arrays.cpp)
target_compile_definitions(test_arrays_active PUBLIC ALL_ACTIVE)

add_adept_test2(test_arrays_active_pausable test_arrays.cpp)
target_compile_definitions(test_arrays_active_pausable PUBLIC ADEPT_RECORDING_PAUSABLE ALL_ACTIVE)

add_adept_test2(test_complex_arrays test_arrays.cpp)
target_compile_definitions(test_complex_arrays PUBLIC ALL_COMPLEX)

add_adept_test2(test_fixed_arrays_active test_fixed_arrays.cpp)
target_compile_definitions(test_fixed_arrays_active PUBLIC ALL_ACTIVE)
