===========
desiconda2
===========

Introduction
---------------

This package contains scripts for installing conda and all compiled
dependencies needed by the spectroscopic pipeline.

Quick start
----------------

On cori, run::

    git clone https://github.com/marcelo-alvarez/desiconda2 /path-to-git-clone/desiconda2
    cd /path-to-git-clone/desiconda2
    DCONDAVERSION=$(data '+%Y%m%d')-2.0.0 PREFIX=$HOME CONF=default PKGS=default ./install.sh
    module use $HOME/desiconda-test/modulefiles
    module load desiconda
    
Example
----------------

Imagine you wanted to install a set of dependencies for DESI software on a
cluster (rather than manually getting all the dependencies in place).  
You plan on installing desiconda in your home directory ($HOME/software/desi).  
Since you git-cloned the latest tagged version of desiconda using::

    git clone https://github.com/marcelo-alvarez/desiconda2 /path-to-git-clone/desiconda2

you are happy with the corresponding version string for the install prefix.  
The spectro pipeline primarily works with python3, so that is what you specified 
in the "conf/myenv-env.sh" file you created (based on the existing 
conf/default-env.sh). You also put all the commands for dependencies you 
want to install in the "conf/mypkgs-pkgs.sh" file you created (based on the 
existing conf/mypkgs-pkgs.sh). 

This install.sh script, in the top-level directory, will create the environment and
install the dependencies and module files. When you run this script, it will
download many MB of binary and source packages, extract files, and compile things.
It will do this in your current working directory.
Also the output will be very long, so pipe it to a log file::

    $> PREFIX=$HOME/software/desi CONF=myenv PKGS=mypkgs /path-to-git-clone/desiconda2/install.sh 2>&1 | tee log

After this runs, the script should clean up after itself and the only file 
remaining should be the log file.  If other files exist, then something went
wrong.  Look in the log file to find the first package that failed to build.
All packages after that point may or may not have completed.

If everything worked, then you can see your new desiconda install with::

    $> module use $HOME/software/desi/modulefiles
    $> module avail desiconda

And you can load it with::

    $> module load desiconda

The install also creates a "version" file that can be used to set the default
version of the desiconda module.  In this example you could make version 
2.0 the default with::

    $> cd $HOME/software/desi/modulefiles/desiconda
    $> rm -f .version; ln -s .version_1.1.3 .version


Configuration
~~~~~~~~~~~~~~~~~~

If environment and pacakge files (conf/[envtag]-env and conf/[pkgtag]-pkgs) for
your use case already exists in the "conf" directory, then
just use them.  Otherwise, create or edit files in the "conf" subdirectory that 
are named after the environment and set of packages you wish to create and install.
See existing files conf/default-env and conf/default-pkg for spectroscopic
pipeline dependencies on cori. 

Installation
~~~~~~~~~~~~~~~~~~~~~~~~

For normal installs, simply run the install script.  This installs the
software and modulefile, as well as a module version file named
".version_$VERSION" in the module install directory.  You can manually
move this into place or symlink it if and when you want to make that the 
default version.  You can run the install script from an alternate build 
directory.  

As an example, suppose we want to install the script we made in the
previous section for cori.  We'll make a temporary directory on
scratch to do the building, since it is going to download and compile
several big packages.  We'll also dump all output to a log file so that
we can look at it afterwards if there are any problems::

    $> cd $SCRATCH
    $> mkdir build
    $> cd build
    $> PREFIX=$HOME/software/desi CONF=myenv PKGS=mypkgs /path/to/git/desiconda2/install.sh >log 2>&1 &
    $> tail -f log

After installation, the $PREFIX directory will contain directories
and files::

    $PREFIX/desiconda/$VERSION_conda
    $PREFIX/desiconda/$VERSION_aux
    $PREFIX/modulefiles/desiconda/$VERSION
    $PREFIX/modulefiles/desiconda/.version_$VERSION

If you want to make this version of desiconda the default, then just
do::

    $> ln -s .version_$VERSION .version

