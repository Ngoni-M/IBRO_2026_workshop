#!/bin/bash

#########################################
# Task 2.1: Write a simple Shell script #
#########################################

# First create the dummy DICOM data in your workshop workspace folder.
# Do this from the IBRO_2026_Workshop folder:

python3 -m venv .venv
source .venv/bin/activate
pip install pydicom
python helper_scripts/make_dummy_dicom_subjects.py

# This creates dummy_data/ with 10 copied subjects named subject1, subject2, and so on.
# Now copy dummy_data/ to your FreeSurfer subjects directory for the rest of this task:

mkdir -p $SUBJECTS_DIR/ExampleSubjects
rsync -av dummy_data/ $SUBJECTS_DIR/ExampleSubjects/

# Now create a new script

mkdir $HOME/bin

# Put $HOME/bin on your PATH and:

emacs $HOME/bin/MyExampleShellScript

# ... with the following information:

#!/bin/sh

cd /mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects

# Loop for running over all subjects:

SUBJECTS_LIST=`ls -d Subject*`
counter=0

for SUBJECT in $SUBJECTS_LIST
do

let counter=$counter+1
echo "Subject $counter is $SUBJECT."

done

# Then, when you think it works, expand on it like this.
# This version does not make one long command list.
# Instead, it writes one CHPC job file for each subject.

##############

#!/bin/bash

DICOM_DIR=/mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects
SUBJECTS_DIR=/mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects_output
JOB_DIR=$SUBJECTS_DIR/jobFiles

mkdir -p $JOB_DIR

cd $DICOM_DIR

# Loop for running over all subjects:

SUBJECTS_LIST=`ls -d Subject*`
counter=0

for SUBJECT in $SUBJECTS_LIST
do

let counter=$counter+1
echo "Subject $counter is $SUBJECT."

SINGLE_SUBJECTS_DIR=`ls -d $DICOM_DIR/$SUBJECT/*RMS`

echo "SINGLE_SUBJECTS_DIR is $SINGLE_SUBJECTS_DIR"

FIRST_DICOM_FILE=`ls $SINGLE_SUBJECTS_DIR/*.dcm | head -n1`

# Not really the first dcm, but hey, it will work for now...
# Now we create a job file for this subject.
# Each job file contains the CHPC instructions and one recon-all command.

JOB_FILE=$JOB_DIR/recon-all-$SUBJECT.job

echo "#! /bin/bash" > $JOB_FILE
echo "" >> $JOB_FILE
echo "#PBS -l select=2:ncpus=24" >> $JOB_FILE
echo "#PBS -l walltime=48:00:00" >> $JOB_FILE
echo "#PBS -P WCHPC" >> $JOB_FILE
echo "#PBS -N recon-all-$SUBJECT" >> $JOB_FILE
echo "#PBS -q normal" >> $JOB_FILE
echo "" >> $JOB_FILE
echo "recon-all -i $FIRST_DICOM_FILE -s $SUBJECT -sd $SUBJECTS_DIR -motioncor -nuintensitycor" >> $JOB_FILE

echo "Created job file: $JOB_FILE"

# Note the flags "-motioncor -nuintensitycor" are just the preliminary steps.

done

#############


# Now check out the job files you made:

ls $JOB_DIR
cat $JOB_DIR/*.job

############################################################
# Task 2.2 submit the job files you created to CHPC        #
############################################################

# The job files are ready to send to CHPC.
# You can submit one job file by hand like this:

qsub $JOB_DIR/recon-all-Subject1.job

# Check what it is doing:

qstat | grep $USER

# To submit all the job files, use a small loop.
# This is the same basic pattern used by CHPC_WORKSHOP_DAY2_submitReconAllJobs.

##########

#! /bin/bash

SUBJECTS_DIR=/mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects_output
JOB_DIR=$SUBJECTS_DIR/jobFiles

for JOB_FILE in $JOB_DIR/*.job
do
    qsub $JOB_FILE
    echo "Submitted job file: $JOB_FILE"
done

############

# While it is running, you can do the following checks:

qstat | grep $USER # This will show you whats happening at the moment.

# You can stop it by doing:
qdel <YourCHPCTicket>

# Explore a bit:

cd /mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects_output

ls */scripts/IsRunning* # The Subjects that are running.
ls */scripts/recon-all.log # The log files
cat Subject1/scripts/recon-all.log # You can view one log file at a time. Hint: Press up, and change the number to go through each.

# Wait about 10 minutes

ls */scripts/recon-all.done # This will show who completed.
ls */scripts/recon-all.error # These ones finished with an error.

#############################################################
# Task 2.3 Use FreeSurfer Jobs to Submit 10 example subjects #
#############################################################

# Now we will use one of our scripts to run all 10 subjects. It works on the same principles we just covered:

# 1.) You have one script that creates individual job files.
# 2.) Another script submits each job file with qsub.

SUBJECTS_DIR=/mnt/lustre/users/$USER/freesurfer/subjects
cd $SUBJECTS_DIR
mkdir -p ExampleSubjectsFreeSurfer_Output/ # Lets create a subfolder in our subjects dir to organize things.

# Creates the job files:
CHPC_WORKSHOP_DAY2_prepareReconAllJobs -d ExampleSubjects -sd ExampleSubjectsFreeSurfer_Output/

# Check the job files before you submit them:

ls ExampleSubjectsFreeSurfer_Output/jobFiles/
cat ExampleSubjectsFreeSurfer_Output/jobFiles/*.job

# Now submit your jobs with the second script:

CHPC_WORKSHOP_DAY2_submitReconAllJobs ExampleSubjectsFreeSurfer_Output

# Check what is in the queue:

qstat | grep $USER

# The full recon-all command will likely take a few hours.









