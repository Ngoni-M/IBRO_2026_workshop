#!/bin/sh

#  CHPC_WORKSHOP_DAY1_FreesurferBasics.sh
#  
#
#  Created by Stéfan du Plessis on 2018/11/20.
#  

##############################################
# Task 1.1: Now you are ready for Big Dragon #
##############################################

# Now use your hard earned skills to install freesurfer!

# 1. Login to CHPC like so:

ssh <yourusername>@lengau.chpc.ac.za

# 2. Add the "interactiveJob" alias from the example .bash_profile. Run it and launch an interactive job:

cd ~
emacs ~/.bash_profile

# Check the example CHPC_WORKSHOP_DAY1_example_bash_profile.sh included in the workshop files.

# Save, exit, then:

. .bash_profile
interactiveJob

# 3. Copy the Freesurfer tar-ball located in: /mnt/lustre/users/splessis/cubic/splessis2/freesurferTar
#    to your scratch folder: /mnt/lustre/users/<yourusername> e.g. /mnt/lustre/users/splessis/

cp -vr /mnt/lustre/users/splessis/cubic/splessis2/freesurferTar/* /mnt/lustre/users/$USER/

# 4. Untar the tarball (See above example), and add freesurfer to your PATH. Check the example .bash_profile included in the course notes, for an example.

# 5. Copy the example data over... (NB: Be sure you are using an interactive job!)

cd /mnt/lustre/users/$USER/

# While it is copying, you can open a new terminal so long.

# 6. Freesurfer has one basic command. recon-all. It also works like the other unix commands.
# See if it works...

recon-all

# If not, then you will need to check that your bash_profile is working properly.

# The following should give outputs. Note what they say!

echo $SUBJECTS_DIR
echo $FREESURFER_HOME

# This is another way variables make our lives easier:

cd $SUBJECTS_DIR
pwd

# To activate Freesurfer, run the following command:

cp /mnt/lustre/users/splessis/cubic/splessis2/freesurfer6/license.txt $FREESURFER_HOME/

# Better yet, apply for one on their website: its quick n easy.

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
interactive_job # If this is not working, check your interactive job alias, in your .bash_profile again.

cd /mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects/Subject1/subject_RMS/

recon-all -i anon1.dcm -s SUBJECT1 -all -hippocampal-subfields-T1

# Press <control-c> after a few minutes.
# Now check what it does:

recon-all -i anon1.dcm -s SUBJECT1 -all -hippocampal-subfields-T1

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
