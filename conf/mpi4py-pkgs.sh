# Install mpi4py.
echo Current time $(date) Installing mpi4py

module swap PrgEnv-${PE_ENV,,} PrgEnv-gnu
MPICC="cc -shared" pip install --no-binary=mpi4py mpi4py

echo Current time $(date) Done installing mpi4py
