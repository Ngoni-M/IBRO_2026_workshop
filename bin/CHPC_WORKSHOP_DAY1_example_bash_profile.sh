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

# Define YOUR subjects dir. (Remember to create it!!)
SUBJECTS_DIR=/mnt/lustre/users/splessis/dummy_data

echo "SUBJECTS_DIR is now $SUBJECTS_DIR"

#Your info here!                          ^^^^^^

echo "bash_profile: FREESURFER_HOME is now $FREESURFER_HOME..." # Double check that it is working properly.
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export PATH

# Set this to point to your license file. See Freesurfer basics: you need to copy this to your home
# on CHPC
export FS_LICENSE=$HOME/license.txt

# Add symlinks to LD_LIBRARY path: This is for code that freesurfer depends on. Make sure you copy libGLU over, and that you have read permissions.

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/lustre/users/splessis/cubic/libGLU
export LD_LIBRARY_PATH

# Add fsl

# FSL Configuration

FSLDIR=/mnt/lustre/users/splessis/cubic/splessis2/fsl
PATH=${FSLDIR}/bin:${PATH}
. ${FSLDIR}/etc/fslconf/fsl.sh
export FSLDIR PATH

# To add your workshopfiles to your environment do:
PATH=$PATH:/home/splessis/IBRO_2026_workshop/bin

