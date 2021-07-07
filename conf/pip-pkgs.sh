# Install pip packages.
echo Installing pip packages at $(date)

pip install --no-binary :all: \
    https://github.com/desihub/speclite/archive/v0.9.tar.gz \
    hpsspy \
    photutils \
    healpy \
    coveralls \
&& pip install \
    cupy-cuda102 \
    line_profiler \
    xlrd \
    configobj

if [ $? != 0 ]; then
    echo "ERROR installing pip packages; exiting"
    exit 1
fi
