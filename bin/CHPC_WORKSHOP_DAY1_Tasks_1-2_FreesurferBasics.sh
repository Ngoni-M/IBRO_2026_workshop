#!/bin/sh

#  CHPC_WORKSHOP_DAY1_FreesurferBasics.sh
#  
#
#  Created by Stéfan du Plessis on 2018/11/20.
#  Updated on 2026/05/21
#  

##############################################
# Task 1.1: Now you are ready for Big Dragon #
##############################################

# Now use your hard earned skills to load freesurfer and prepare a subjects folder!

# 1. Login to CHPC like so:

ssh <yourusername>@lengau.chpc.ac.za

# 2. Add the "interactiveJob" alias from the example .bash_profile. Run it and launch an interactive job:

cd ~
emacs ~/.bash_profile

# Check the example CHPC_WORKSHOP_DAY1_example_bash_profile.sh included in the workshop files.

# Save, exit, then:

. .bash_profile
interactiveJob

# 3. The example .bash_profile now loads Freesurfer using the CHPC module system.
#    Check that your .bash_profile contains the relevant module lines, especially:

module add chpc/BIOMODULES
module add freesurfer/8.0.0-1

# 4. Make a new subjects folder on your Lustre space, then bind Freesurfer to it
#    by setting SUBJECTS_DIR in your .bash_profile.

# First make sure there is a subjects dir

mkdir -p /mnt/lustre/users/$USER/subjects

# Then add to your .bash_profile

export SUBJECTS_DIR=/mnt/lustre/users/$USER/subjects

# 5. Create the dummy DICOM data locally first.
#
#    Do this on your own computer, from inside the workshop repository folder.
#    The helper script creates a dummy_data/ folder that looks like this:
#
#    dummy_data/
#      subject1/
#      subject2/
#      ...
#      subject10/

python3 -m venv .venv
. .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install pydicom

python3 helper_scripts/make_dummy_dicom_subjects.py

# 6. Copy the locally-created dummy_data folder to your CHPC Lustre space.
#
#    Use the same CHPC account you are using for the workshop. This may be your
#    usual CHPC account or a temporary workshop account.
#
#    Run this from your own computer, from inside the workshop repository folder:

scp -r dummy_data <yourusername>@lengau.chpc.ac.za:/mnt/lustre/users/<yourusername>/

# 7. Back on CHPC, check that the dummy data arrived.

cd /mnt/lustre/users/$USER/
ls dummy_data

# 8. Freesurfer has one basic command. recon-all. It also works like the other unix commands.
# See if it works...

recon-all

# If not, then you will need to check that your bash_profile is working properly.

# The following should give outputs. Note what they say!

echo $SUBJECTS_DIR
echo $FREESURFER_HOME

# This is another way variables make our lives easier:

cd $SUBJECTS_DIR
pwd

# The module should provide the Freesurfer installation and license.
# If recon-all complains about a missing license, ask an instructor before continuing.

###########################################################
# Task 1.2 - Running a single subject on the command-line #
###########################################################

# recon-all works the following way:

# recon-all -i <YourFirstDCM file> -i <Optional second input, if you have more than one T1 you gathered in the same session>
#           -s <The Subject Name. Freesurfer will create a diretory with this name in your $SUBJECTS_DIR>
#           -sd <You can provide al alternative subjects directory here>.
#           -all <This runs the entire freesurfer pipeline.>
#           -hippocampal-subfields-T1 <Runs the hippocampal subfields>

# 1.) Note you only need the -i input once.
# 2.) If freesurfer already started running a subject, it will refuse to run, unless you use the "-no-isrunning" flag.

# So do the following:

ssh <yourusername>@lengau.chpc.ac.za # If you arent already logged in.
cd $SUBJECTS_DIR
interactiveJob # If this is not working, check your interactive job alias, in your .bash_profile again.

cd /mnt/lustre/users/$USER/dummy_data/subject1/*RMS*/

# First, look at the DICOM files in this folder:

ls *.dcm | head

# The filenames are long monstrosities on purpose!
# MR means this is an MR image. The long number is a DICOM UID: a unique
# identifier written by the scanner/software so each image can be tracked
# without relying on a friendly name.
# You do not need to type the whole thing by hand. We can ask the shell to
# choose the first DICOM file for us:

FIRST_DICOM_FILE=`ls *.dcm | head -n1`
recon-all -i $FIRST_DICOM_FILE -s SUBJECT1 -all -hippocampal-subfields-T1

# Press <control-c> after a few minutes.
# Now check what it does:

recon-all -i $FIRST_DICOM_FILE -s SUBJECT1 -all -hippocampal-subfields-T1

# Now do this:
recon-all -s SUBJECT1 -all -hippocampal-subfields-T1 -no-isrunning

# Now, open a new terminal, while it is running...

ssh <yourusername>@lengau.chpc.ac.za
cd $SUBJECTS_DIR
ls
cd SUBJECT1

# Have a look around what freesurfer is doing.

# That is it! Next up, I will show you an example of how to run freesrufer on CHPC, and write an array job script.

##########
# DONE!! #
##########
