# Install pip packages.
echo Installing pip packages at $(date)

# attempting to move following to conda install
# healpy
# photoutils
# xlrd
# coveralls
# configobj
# cupy replacing cupy-cuda102
# line_profiler

pip install --no-binary :all: speclite hpsspy 
        
if [ $? != 0 ]; then
    echo "ERROR installing pip packages; exiting"
    exit 1
fi
