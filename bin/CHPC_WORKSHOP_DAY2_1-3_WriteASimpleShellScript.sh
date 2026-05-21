#!/bin/sh

#########################################
# Task 2.1: Write a simple Shell script #
#########################################

# The sample data you will be using is located at:
# /mnt/lustre/users/splessis/cubic/splessis2/ExampleSubjects

#

# First copy it over to your subjects directory (If you havent done so already):

cp -vr /mnt/lustre/users/splessis/cubic/splessis2/ExampleSubjects $SUBJECTS_DIR

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

# Then, when you think it works, expand on it like this:

##############

#!/bin/bash

DICOM_DIR=/mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects
SUBJECTS_DIR=/mnt/lustre/users/$USER/freesurfer/subjects/ExampleSubjects_output

mkdir $SUBJECTS_DIR

cd $DICOM_DIR

# Loop for running over all subjects:

SUBJECTS_LIST=`ls -d Subject*`
counter=0
rm -f $HOME/MyAmazingArray

for SUBJECT in $SUBJECTS_LIST
do

let counter=$counter+1
echo "Subject $counter is $SUBJECT."

SINGLE_SUBJECTS_DIR=`ls -d $DICOM_DIR/$SUBJECT/*RMS`

echo "SINGLE_SUBJECTS_DIR is $SINGLE_SUBJECTS_DIR"

FIRST_DICOM_FILE=`ls $SINGLE_SUBJECTS_DIR/*.dcm | head -n1`

# Not really the first dcm, but hey, it will work for now...
# Now we create a text file, where each line is a recon-all command for an individual subject.

echo "recon-all -i $FIRST_DICOM_FILE -s $SUBJECT -sd $SUBJECTS_DIR -motioncor -nuintensitycor"
echo "recon-all -i $FIRST_DICOM_FILE -s $SUBJECT -sd $SUBJECTS_DIR -motioncor -nuintensitycor" >> $HOME/MyAmazingArray

# Note the flags "-motioncor -nuintensitycor" are just the preliminary steps.

done

#############


# Now check out your array you made:

cat $HOME/MyAmazingArray

############################################################################
# Task 2.2 convert your Shell script to a Job script and submit it to CHPC #
############################################################################

# We can now use it in a jobscript to send it to individual nodes:

# Now we will convert our Shell script to a jobfile, just to show you they are essentially the same. Lets call it myJobFile.job

cp $HOME/bin/MyExampleShellScript $HOME/myJobFile.job

emacs $HOME/myJobFile.job

#Include the following at the job of the file:

##########

#! /bin/bash

#PBS -l select=2:ncpus=24
#PBS -l walltime=48:00:00
#PBS -P WCHPC
#PBS -N MyAmazingRunArray
#PBS -q normal

######

# Remove your old arrayfile:

rm $HOME/MyAmazingArray

# And run it using qsub:

qsub $HOME/myJobFile.job

# Check what it is doing:

qsub | grep $USER

# When it is done, do the following:

cat $HOME/MyAmazingArray

# Now lets make a jobfile that runs each of the lines in the array you made on an available Node:

emacs $HOME/myArrayJobFile.job

# Add this:

############

#! /bin/bash

#PBS -l select=2:ncpus=24
#PBS -l walltime=48:00:00
#PBS -P WCHPC
#PBS -N MyAmazingRunArray
#PBS -q normal

# This pulls out the line number that corresponds with the subject ...

SINGLE_SUBJECT_COMMAND=`sed -n "${PBS_ARRAY_INDEX} p" $ARRAY_FILE`

# Note ${PBS_ARRAY_INDEX} is an environment variable, which you didnt need to create. Its part of the scheduler.

# eval is a program that turns a text string into a command:

eval $SINGLE_SUBJECT_COMMAND
echo "eval $SINGLE_SUBJECT_COMMAND"

############

# Now run it like this:

ARRAY_FILE=$HOME/MyAmazingArray
arraySize=`cat $ARRAY_FILE | wc -l`

# Check with an echo what you are doing:

echo "qsub -v ARRAY_FILE=${ARRAY_FILE} -e $HOME/clustersurfRunArray.errout -o $HOME/clustersurfRunArray.stdout -J 0-$arraySize $HOME/myJobFile.job"

# Run it ... this will send your script to the queue. Each subject will run on the first available node.

qsub -v ARRAY_FILE=${ARRAY_FILE} -e $HOME/clustersurfRunArray.errout -o $HOME/clustersurfRunArray.stdout -J 0-$arraySize $HOME/myArrayJobFile.job

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

cat clustersurfRunArray.stdout # This is the output each node made. Useful, when writing new jobscripts.
cat clustersurfRunArray.errout # This is also useful to check, as it may have errors in it.

##########################################################
# Task 2.3 Use Clustersurf to Submit 10 example subjects #
##########################################################

# Now we will use one of our scripts to run all 10 subjects. It works on the same principles we just covered:

# 1.) You have one script that creates individual jobfiles.
# 2.) Another that runs them as an array.

SUBJECTS_DIR=/mnt/lustre/users/$USER/freesurfer/subjects
cd $SUBJECTS_DIR
mkdir ExampleSubjectsClustersurf_Output/ # Lets create a subfolder in our subjects dir to organize things.

# Creates the jobfiles:
CHPC_WORKSHOP_DAY2_clustersurfManual2 -flags "-motioncor -nuintensitycor" -subj ExampleSubjectsClustersurf_Output/ -d ExampleSubjects

ls ExampleSubjectsClustersurf_Output/jobFiles/
cat ExampleSubjectsClustersurf_Output/jobFiles/recon-all-jobs*

# Now submit your array with the second script:

CHPC_WORKSHOP_DAY2_clustersurfRunArray ExampleSubjectsClustersurf_Output

# Check for output:

qsub | grep $USER
ls ExampleSubjectsClustersurf_Output/

# If that works, erase all the output, and setup the entire freesurfer pipeline like this:
CHPC_WORKSHOP_DAY2_clustersurfManual2 -flags "-all" -subj ExampleSubjectsClustersurf_Output/ -d ExampleSubjects

# Check what you have done...
ls ExampleSubjectsClustersurf_Output
ls ExampleSubjectsClustersurf_Output/jobFiles
cat ExampleSubjectsClustersurf_Output/jobFiles/*.job

# And run:

CHPC_WORKSHOP_DAY2_clustersurfRunArray ExampleSubjectsClustersurf_Output

# And check on it. Will likely take 4 hours.
qstat | grep $USER













