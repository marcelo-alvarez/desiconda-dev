# Install mpi4py.
echo Installing mpi4py at $(date)

module swap PrgEnv-${PE_ENV,,} PrgEnv-gnu
MPICC="cc -shared" pip install --no-binary=mpi4py mpi4py
