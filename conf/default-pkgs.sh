# conda packages
echo Installing conda packages at $(date)

conda install --copy --yes \
    nose \
    requests \
    future \
    cython \
    cmake \
    numpy \
    scipy \
    mkl=2020.0 \
    matplotlib \
    seaborn \
    pyyaml \
    astropy \
    pytest-astropy \
    hdf5 \
    h5py \
    psutil \
    ephem \
    psycopg2 \
    pytest \
    pytest-cov \
    numba \
    sqlalchemy \
    scikit-learn \
    scikit-image \
    ipython \
    jupyter \
    ipywidgets \
    bokeh \
    wurlitzer \
    certipy \
    sphinx \
    iminuit \
    cudatoolkit \
&& conda install --copy --yes -c conda-forge \
    fitsio \
    dask \
    distributed \
    papermill \
&& mplrc="$CONDADIR/lib/python$PYVERSION/site-packages/matplotlib/mpl-data/matplotlibrc"; \
    cat ${mplrc} | sed -e "s#^backend.*#backend : TkAgg#" > ${mplrc}.tmp; \
    mv ${mplrc}.tmp ${mplrc} \
&& rm -rf $CONDADIR/pkgs/*

if [ $? != 0 ]; then
    echo "ERROR installing conda packages; exiting"
    exit 1
fi

conda list --export | grep -v conda > "$CONDADIR/pkg_list.txt"

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

# Install mpi4py.
echo Installing mpi4py at $(date)

@mpi4py@

# GalSim and dependencies
echo Installing GalSim and friends at $(date)

@scons@

@tmv@

@galsim@

# Remove patches if needed

if [ ! -e ./conf ]; then
    # this is an out-of-source build
    rm -rf ./rules
fi

# Compile python modules
echo Pre-compiling python modules at $(date)

python@PYVERSION@ -m compileall -f "$CONDADIR/lib/python@PYVERSION@/site-packages"

# Import packages that may need to generate files in the install prefix
echo Import python modules that might trigger downloads at $(date)

python@PYVERSION@ -c "import astropy"
python@PYVERSION@ -c "import matplotlib.font_manager as fm; f = fm.FontManager"
