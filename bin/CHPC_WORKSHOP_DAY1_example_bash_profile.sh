# Example bash_profile. Try and use only what you need!

#!/bin/sh  # You dont need this part.
# .bash_profile

#Uncomment these lines to double check if things are working:

#echo "This is my CHPC .profile..."
#echo "Running .bash_profile..."
#echo "This is dane checking stderr does something..." 1>&2

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Lets customize our PROMPT!!
# PS1 controls what your shell prompt looks like.
# \[\e[0;31m\] starts red text. The \[ and \] tell bash that the colour code
# does not take up visible space, which helps long commands wrap correctly.
# [\u@\h \W] shows [username@hostname current_directory].
# \$ shows "$" for a normal user and "#" for root.
# \[\e[m\] resets the colour back to the terminal default.

# This is useful to do, as it keeps you orientated which machine you are working on.

export PS1="\[\e[0;31m\][\u@\h \W]\$ \[\e[m\]"

# Very useful: Setting up an interactive job alias

alias interactiveJob="qsub -I -P WCHPC -q serial -l walltime=48:00:00"
#Replace this:                   ^^^^^^^^
# With your study ID, or if you dont have one: WCHPC

# Install modules...  (This is useful, as CHPC might already have things available.

#Install R environment
module add chpc/R/3.3.2-gcc6.2.0

# User specific environment and startup programs

# NB: The order here is often important. Often you need to first add the BIOMODULES for example.

module add chpc/BIOMODULES
module add afni/18.1.09
module add fsl/6.0.4
module add freesurfer/8.0.0-1

#Install freesurfer (Note you need to provide your information here.)

export FREESURFER_HOME=/mnt/lustre/users/splessis/freesurfer
#Your info here!                          ^^^^^^

echo "bash_profile: FREESURFER_HOME is now $FREESURFER_HOME..." # Double check that it is working properly.
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export PATH

# Add symlinks to LD_LIBRARY path: This is for code that freesurfer depends on. Make sure you copy libGLU over, and that you have read permissions.

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/lustre/users/splessis/cubic/libGLU
export LD_LIBRARY_PATH

# More exmaples of adding things to your PATH: Art toolbox for ACPC orientation, Tortoise, FSL etc etc.


export PATH=/mnt/lustre/users/splessis/cubic/splessis2/TORTOISE_V3.1.1/DIFFPREPV311/bin/bin:$PATH
export PATH=/mnt/lustre/users/splessis/cubic/splessis2/TORTOISE_V3.1.1/DIFFCALC/DIFFCALCV311:$PATH
export PATH=/mnt/lustre/users/splessis/cubic/splessis2/TORTOISE_V3.1.1/DRBUDDIV311/bin:$PATH
export PATH=/mnt/lustre/users/splessis/cubic/splessis2/TORTOISE_V3.1.1/DRTAMASV311/bin:$PATH
export PATH=/home/splessis/clustersurf_bin/acpcdetect_v2.0_LinuxCentOS6.7/bin:$PATH
export ARTHOME=/home/splessis/clustersurf_bin/acpcdetect_v2.0_LinuxCentOS6.7

# Add fsl

# FSL Configuration

FSLDIR=/mnt/lustre/users/splessis/cubic/splessis2/fsl
PATH=${FSLDIR}/bin:${PATH}
. ${FSLDIR}/etc/fslconf/fsl.sh
export FSLDIR PATH

# To add your workshopfiles to your environment do:
PATH=$PATH:/home/splessis/IBRO_2026_workshop/bin

