export MINICONDA=https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
export CONDAVERSION=2.0
export PYVERSION=3.8
export GRP=desi

export MPICC=cc
export MPICXX=CC

export MPI_CPPFLAGS = ${CRAY_MPICH2_DIR}/include
export MPI_LDFLAGS = ${CRAY_MPICH2_DIR}/lib
export MPI_CXXLIB = mpichcxx
export MPI_LIB = mpich
export MPI_EXTRA_COMP =
export MPI_EXTRA_LINK = -shared

export BLAS_INCLUDE =
export BLAS = -lopenblas -fopenmp -lpthread -lgfortran -lm
export LAPACK =

##########################################################################################
# OLD CONF FILE
##########################################################################################
# Serial compilers

#INTEL_COMP = no
#CC = gcc
#CXX = g++
#FC = gfortran

# MPI compilers

#MPICC = cc
#MPICXX = CC
#MPIFC = ftn

# Compile flags

#CFLAGS = -O3 -fPIC -pthread
#CXXFLAGS = -O3 -fPIC -pthread
#FCFLAGS = -O3 -fPIC -fexceptions -pthread

#OPENMP_CFLAGS = -fopenmp
#OPENMP_CXXFLAGS = -fopenmp
#LDFLAGS = -lpthread -fopenmp

# Are we doing a cross-compile?

CROSS =

# Miniconda install

#INTEL_CONDA = no
#MINICONDA = https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
#PYVERSION = 3.8

# Use Cray MPICH

#MPI_CPPFLAGS = ${CRAY_MPICH2_DIR}/include
#MPI_LDFLAGS = ${CRAY_MPICH2_DIR}/lib
#MPI_CXXLIB = mpichcxx
#MPI_LIB = mpich
#MPI_EXTRA_COMP =
#MPI_EXTRA_LINK = -shared

# For BLAS/LAPACK, we use openblas

#BLAS_INCLUDE =
#BLAS = -lopenblas -fopenmp -lpthread -lgfortran -lm
#LAPACK =

# Boost toolchain name

#BOOSTCHAIN = gcc

# Group and permissions to set

#CHGRP = desi
#CHMOD = "u=rwX,g=rX,o-rwx"
