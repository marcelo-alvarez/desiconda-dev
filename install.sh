#!/bin/bash

echo Starting desiconda installation at $(date)

# print commands as they are run so we know where we are if something fails
set -x

# Script directory

pushd $(dirname $0) > /dev/null
topdir=$(pwd)
popd > /dev/null

scriptname=$(basename $0)
fullscript="${topdir}/${scriptname}"

if [[ -z "${testrun}" ]]; then
  testrun=0
fi

CONFIGUREENV=$topdir/conf/$CONF-env
INSTALLPKGS=$topdir/conf/$PKGS-pkgs

CONDADIR=$PREFIX/conda
MODULEDIR=$PREFIX/modulefiles/desiconda

export PATH=$CONDADIR/bin/:$PATH

# Initialize environment
source $CONFIGUREENV

# Install conda root environment
echo Installing conda root environment at $(date)

mkdir -p $CONDADIR/bin
mkdir -p $CONDADIR/lib

if [ $testrun -eq 0 ]
then
  curl -SL $MINICONDA \
    -o miniconda.sh \
    && /bin/bash miniconda.sh -b -f -p $CONDADIR \
    && rm miniconda.sh \
    && rm -rf $CONDADIR/pkgs/* \
    && rm -f $CONDADIR/compiler_compat/ld
else
  mkdir -p $CONDADIR
fi

# Install conda packages.
if [ $testrun -eq 0 ]
then
  source $INSTALLPKGS
fi

# Set permissions
echo Setting permissions at $(date)

chgrp -R $GRP $CONDADIR
chmod -R u=rwX,g=rX,o-rwx $CONDADIR

# Install modulefile
echo Installing the desiconda modulefile at $(date)

MODULEDIR=$PREFIX/modulefiles/desiconda
mkdir -p $MODULEDIR

cp $topdir/modulefile.gen desiconda.module

sed -i 's@_CONDADIR_@'"$CONDADIR"'@g' desiconda.module
sed -i 's@_CONDAVERSION_@'"$CONDAVERSION"'@g' desiconda.module
sed -i 's@_PYVERSION_@'"$PYVERSION"'@g' desiconda.module

cp desiconda.module $MODULEDIR/$CONDAVERSION
cp desiconda.modversion $MODULEDIR/.version_$CONDAVERSION

chgrp -R $GRP $MODULEDIR
chmod -R u=rwX,g=rX,o-rwx $MODULEDIR

# All done
echo Done at $(date)
