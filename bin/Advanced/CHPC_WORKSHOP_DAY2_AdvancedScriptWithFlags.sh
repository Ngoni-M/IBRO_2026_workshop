#!/bin/sh

#  CHPC_WORKSHOP_DAY2_AdvancedScriptWithFlags.sh
#  
#
#  Created by Stéfan du Plessis on 2018/11/15.
#  

# It helps understanding this script, as then you will fully understand how flags work, how they are often used poorly, and what to try when things go wrong.
# This also forms the basis for clustersurf_manual script. More on that later.

# Run it like this:

# CHPC_WORKSHOP_DAY2_AdvancedScriptWithFlags.sh -d $HOME/CHPCWorkShop2018/dummyDicomFolder -subj /exampleSubjectsDir -f "-AnyFreesurferFlag"

###

#################
# MANAGE INPUTS #
#################

while [[ $# > 1 ]] # This goes through all the inputs...
do
key="$1" # The key is the same as the "-flag" bit...

case $key in

-d|--dicomDir|-dicomDir) # Here it checks for an input
echo "You have told me about a subjects directory. It is located in: $2"
DICOM_DIR=$2 # $2 is the input after the key...
shift
;;
-subj|--subjects_dir|-sd|-target|-targetDir)
echo "You have told me about a subjects directory. It is located in: $2"
SUBJECTS_DIR=$2
shift
;;
-f|--freesurfer_commands|-flags|-flag|-cmd|-cmds)
echo "I found more flags!! It reads $2"
FREESURFER_CMDS=$2
shift
;;
*)
shift
;;

esac
shift
done

################
# SUBFUNCTIONS #
################

SubFunctionA(){

echo "Hi, I am subfunction A!"

echo "Subfunction A: And this is my first input: $1"
echo "Subfunction A: And this is my second input: $2"

}

#############
# MAIN CODE #
#############

SubFunctionA BLAH1 BLAH2

# Now we can use the inputs to run recon-all for example:

echo "recon-all -i First_subject_dicom.dcm -s MySubjectName -sd $SUBJECTS_DIR $FREESURFER_CMDS"

# Using example code from Day1:

# This could be the $DICOM_DIR variable:

cd $HOME/CHPCWorkShop2018/dummyDicomFolder

MyListOfSubjects=`ls -d *`
echo $MyListOfSubjects

# This is important for scripts such as these:

for SUBJECT in $MyListOfSubjects
do

FIRST_SCAN=`ls $SUBJECT/* | head -n1` # This finds the first file
echo "Running: recon-all -i $FIRST_SCAN -s $SUBJECT -sd $SUBJECTS_DIR $FREESURFER_CMDS"

done










