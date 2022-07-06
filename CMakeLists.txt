cmake_minimum_required(VERSION 3.6)
project(Adept2)

SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

set(CMAKE_CXX_STANDARD 14)

include(CTest)

if( ADEPT_USE_OPENMP )
find_package(OpenMP)
MESSAGE( STATUS "OpenMP_FOUND " ${OpenMP_FOUND})
# OpenMP_FOUND
# OpenMP_VERSION
# <lang> is one of C, CXX, or Fortran
# OpenMP_<lang>_FOUND
# OpenMP_<lang>_FLAGS
# OpenMP_<lang>_INCLUDE_DIRS
# OpenMP_<lang>_LIB_NAMES
# OpenMP_<libname>_LIBRARY
# OpenMP_<lang>_LIBRARIES
endif()

if( ADEPT_USE_LAPACK )
find_package(LAPACK)
MESSAGE( STATUS "LAPACK_FOUND " ${LAPACK_FOUND})
# LAPACK_FOUND
# LAPACK_LINKER_FLAGS
# LAPACK_LIBRARIES
# LAPACK95_LIBRARIES
# LAPACK95_FOUND
endif()

if( ADEPT_USE_BLAS )
find_package(BLAS)
MESSAGE( STATUS "BLAS_FOUND " ${BLAS_FOUND})
# BLAS_FOUND
# BLAS_LINKER_FLAGS
# BLAS_LIBRARIES
# BLAS95_LIBRARIES
# BLAS95_FOUND
endif()

if( ADEPT_USE_GSL )
find_package(GSL)
# GSL_FOUND
# GSL_INCLUDE_DIRS
# GSL_LIBRARIES
# GSL_VERSION
endif()

# From https://github.com/joaoleal/CppADCodeGen/
find_package(ADOLC)
# ADOLC_FOUND
# ADOLC_INCLUDE_DIRS
# ADOLC_LIBRARY_DIRS
# ADOLC_LIBRARIES

# From https://github.com/joaoleal/CppADCodeGen/
find_package(CppAD)
# CPPAD_FOUND
# CPPAD_INCLUDE_DIRS
# CPPAD_LIBRARY_DIRS
# CPPAD_LIBRARIES

# Does net yet exist.
# find_package(SACADO)

set(ADEPT_HEADERS
        include/adept/Active.h
        include/adept/ActiveConstReference.h
        include/adept/ActiveReference.h
        include/adept/Allocator.h
        include/adept/Array.h
        include/adept/ArrayWrapper.h
        include/adept/BinaryOperation.h
        include/adept/Expression.h
        include/adept/ExpressionSize.h
        include/adept/FixedArray.h
        include/adept/GradientIndex.h
        include/adept/IndexedArray.h
        include/adept/Minimizer.h
        include/adept/Optimizable.h
        include/adept/Packet.h
        include/adept/RangeIndex.h
        include/adept/ScratchVector.h
        include/adept/SpecialMatrix.h
        include/adept/Stack.h
        include/adept/StackStorage.h
        include/adept/StackStorageOrig.h
        include/adept/StackStorageOrigStl.h
        include/adept/Statement.h
        include/adept/Storage.h
        include/adept/UnaryOperation.h
        include/adept/array_shortcuts.h
        include/adept/base.h
        include/adept/contiguous_matrix.h
        include/adept/cppblas.h
        include/adept/eval.h
        include/adept/exception.h
        include/adept/interp.h
        include/adept/inv.h
        include/adept/matmul.h
        include/adept/noalias.h
        include/adept/outer_product.h
        include/adept/quick_e.h
        include/adept/reduce.h
        include/adept/scalar_shortcuts.h
        include/adept/settings.h
        include/adept/solve.h
        include/adept/spread.h
        include/adept/store_transpose.h
        include/adept/traits.h
        include/adept/vector_utilities.h
        include/adept/where.h
        )

set(ADEPT_SOURCES
        adept/Array.cpp
        adept/Minimizer.cpp
        adept/Stack.cpp
        adept/StackStorageOrig.cpp
        adept/Storage.cpp
        adept/cppblas.cpp
        adept/cpplapack.h
        adept/index.cpp
        adept/inv.cpp
        adept/jacobian.cpp
        adept/line_search.cpp
        adept/minimize_conjugate_gradient.cpp
        adept/minimize_levenberg_marquardt.cpp
        adept/minimize_limited_memory_bfgs.cpp
        adept/settings.cpp
        adept/solve.cpp
        adept/vector_utilities.cpp
        )

add_subdirectory(include)

add_library(adept STATIC ${ADEPT_SOURCES} ${ADEPT_HEADERS})
add_library(adept::adept ALIAS adept)
target_include_directories(adept PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
        )

install(TARGETS adept
        EXPORT adept
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        INCLUDES DESTINATION include
        )

install(FILES ${ADEPT_HEADERS} DESTINATION include/adept)
install(FILES include/adept.h include/adept_arrays.h include/adept_optimize.h ${CMAKE_CURRENT_BINARY_DIR}/include/adept_source.h DESTINATION include)

install(FILES Adept2Config.cmake DESTINATION cmake)

install(EXPORT adept
        NAMESPACE adept::
        DESTINATION cmake)

if(BUILD_TESTING)
    enable_testing()
    add_subdirectory(test)
endif(BUILD_TESTING)
