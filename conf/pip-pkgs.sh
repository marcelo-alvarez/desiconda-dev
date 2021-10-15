# Install pip packages.
echo Installing pip packages at $(date)

pip install --no-binary :all: hpsspy mpi4py 

if [ $? != 0 ]; then
    echo "ERROR installing pip packages; exiting"
    exit 1
fi

echo Current time $(date) Done installing conda packages