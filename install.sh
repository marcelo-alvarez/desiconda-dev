#!/bin/bash

echo Current time $(date) Starting desiconda install

# print commands as they are run so we know where we are if something fails
# set -x

# Script directory
pushd $(dirname $0) > /dev/null
topdir=$(pwd)
popd > /dev/null

scriptname=$(basename $0)
fullscript="${topdir}/${scriptname}"

# Convenience environment variables
CONFDIR=$topdir/conf

CONFIGUREENV=$CONFDIR/$CONF-env.sh
INSTALLPKGS=$CONFDIR/$PKGS-pkgs.sh

CONDADIR=$PREFIX/conda
MODULEDIR=$PREFIX/modulefiles/desiconda

export PATH=$CONDADIR/bin:$PATH

# Initialize environment
source $CONFIGUREENV

# Install conda root environment
echo Current time $(date) Installing miniconda

mkdir -p $CONDADIR/bin
mkdir -p $CONDADIR/lib

curl -SL $MINICONDA \
  -o miniconda.sh \
  && /bin/bash miniconda.sh -b -f -p $CONDADIR

source $CONDADIR/bin/activate
export PYVERSION=`python get_version.py`
echo Using Python version $PYVERSION

echo Current time $(date) Done installing miniconda
# Install packages
echo Current time $(date) Installing packages
source $INSTALLPKGS

echo Current time $(date) Done installing packages
# Compile python modules
echo Current time $(date) Pre-compiling modules

python$PYVERSION -m compileall -f "$CONDADIR/lib/python$PYVERSION/site-packages"

echo Current time $(date) Done pre-compiling modules
# Set permissions
echo Current time $(date) Setting permissions

chgrp -R $GRP $CONDADIR
chmod -R u=rwX,g=rX,o-rwx $CONDADIR

echo Current time $(date) Done setting permissions
# Install modulefile
echo Current time $(date) Installing desiconda module

MODULEDIR=$PREFIX/modulefiles/desiconda
mkdir -p $MODULEDIR

cp $topdir/modulefile.gen desiconda.module

sed -i 's@_CONDADIR_@'"$CONDADIR"'@g' desiconda.module
sed -i 's@_CONDAVERSION_@'"$CONDAVERSION"'@g' desiconda.module
sed -i 's@_PYVERSION_@'"$PYVERSION"'@g' desiconda.module

cp desiconda.module $MODULEDIR/$CONDAVERSION
cp desiconda.modversion $MODULEDIR/.version_$CONDAVERSION

# Change module permissions
chgrp -R $GRP $MODULEDIR
chmod -R u=rwX,g=rX,o-rwx $MODULEDIR

# All done
echo Current time $(date) Done at
