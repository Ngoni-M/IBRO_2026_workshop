#!/bin/bash

# This is a line-by-line workshop worksheet, not a script to run from top to bottom. 
# Read instructions carefully, and try out the commands in your terminal. 
# You will learn much more by doing it yourself, than by just reading it.

###############
# Lets begin! #
###############

# Step 1: Focus on what you need to get done, and write it done in a script using comments
# Step 2: Try and find somebody else's code and adapt it.
# Step 3: Try using as simple/few steps that you need, but keep in mind you can always simplify later.

# Tip 1: Stay organized
# Tip 2: Use source control. Its easier than you think.
# Tip 3: If you arent havening fun, you are doing it wrong.

# What is a Shell? What is a Shell script?

# What is a process?

# The general syntax of the command-line:

# COMMAND <INPUT1> <INPUT2> <INPUT3> ... <INPUTn>

# Notice the spaces!!

# COMMAND[-space-]<INPUT1>[ ]<INPUT2>[ ]<INPUT3> ...[]<INPUTn>

# The flag: see it as the knobs and dials of the command-line

# Example command: change directory -> cd <INPUT>
# Note: I will explain a bit later what the "$HOME" is...

cd $HOME
cd ~ # This does the same as $HOME. It is like a shortcut.

pwd # This prints out the directory. This will be your "home directory" Write it down, especially the windows users.

# Example command: file listing -> ls[space!]-<TheFlags!>[space!]<INPUT>

ls
ls -l # Here the flag "-l" tells list to make a "long" list.

# Example command: make a directory -> mkdir <INPUT>

mkdir IBRO_2026_Workshop
ls # you will see your diretory you created...
ls -l # you will see it was made today!
ls -lt # Will organize according to time!!
ls -ltr # Will organize in reverse

# Note you cant do this:
mkdir IBRO_2026_Workshop/bin

# But we can do this: We can use a "-p" to create nested directories:

mkdir -p IBRO_2026_Workshop/bin
cd IBRO_2026_Workshop/bin

# Where are we now?
pwd

# How do I reverse out of this directory?
cd ..

# Multiple reverses...

cd ../..

# How do I get back??!!

cd $HOME/IBRO_2026_Workshop/bin

# Notice how the directory structure works...
# Where are you when you do this:

cd /

# This is called the "root directory"

# Some more important information before we can proceed...
# In case you are wondering:

whoami

# ...

whatisthemeaningoflife

#just kiddin ;P

# But have a look at what the output is:
#  > whatisthemeaningoflife
#  -bash: whatisthemeaningoflife: command not found
# "bash", your commandline is telling you a) this command does not exist, or b) it cant find it.
# More on this later.

whoami # Write this down!! This is your <username>. Its not obvious on a PC.
# ** Sideline:
who # Tells you who else is logged in on the computer you are using. Useful when you are running a server.

#####################
# Basic permissions #
#####################

cd $HOME/IBRO_2026_Workshop/bin

# Just for practice, reverse out:

cd ..
pwd

# Now we create dummy files with the "touch" command...

touch dummyFile01
touch dummyFile02
touch dummyFile03
touch dummyFile04
touch dummyFile05
touch dummyFile06
touch dummyFile07
touch dummyFile08
touch dummyFile09
touch dummyFile10

# ** Sideline:
# How would you write a script to create 10 dummy files? Watch out for creating 10 :)

# Now:

ls -l

# The "d" here says it is a directory
# drwxr-xr-x  2 stefan  staff  68 Nov 12 14:41 bin
# ^

# These are the owner's permissions:
# drwxr-xr-x  2 stefan  staff  68 Nov 12 14:41 bin
#  ^^^         ^OWNER^

# The owner should be your since, you created it!

# These are the group's permissions:
# drwxr-xr-x  2 stefan  staff  68 Nov 12 14:41 bin
#     ^^^              ^GROUP^

# This is everyone else...
# drwxr-xr-x  2 stefan  staff  68 Nov 12 14:41 bin
#        ^^^

# r : read!
# w : write
# X : execute > This means it is a program. Or a "script",

# This is how you change permissions:

chmod +x dummyFile01
ls -l

# You can also:

chmod +x dummyFile01
ls -l
chmod +r dummyFile01
ls -l
chmod +w dummyFile01
ls -l
chmod -x dummyFile01
ls -l
chmod 111 dummyFile01
ls -l
chmod 222 dummyFile01
ls -l
chmod 777 dummyFile01
ls -l
chmod 667 dummyFile01
ls -l

#Experiment!

# Now dummyFile01 is a program! With nothing in it...
# Lets do something about our computer's ignorance...
# First we change the name of the script to something useful

mv dummyFile01 whatisthemeaningoflife

# The meaning of life is obviously...

echo "42"

# ...

echo "What does echo do?"

echo "It repeats what you give it."
echo "It can reveal whats hidden in containters i.e. variables"
echo "Like whats in HOME: $HOME"

# More on this later...
# But first we are going to create a small program that will tell the user what the meaning of life is.

# Firtsly, we tell bash this is a bash script:


echo "#! /bin/bash" > whatisthemeaningoflife
#                ^ This creates/erases the textfile, and puts the output of echo (standard out) on the first line

# Now open whatisthemeaningoflife with your favourite editor, and write this down in it (Without the comment!)

#echo "It is 42 of course"

# Now exit, and run it like so:

. whatisthemeaningoflife

# Congrats, you wrote your first script!

# Lets do some more things with echo and cat, which are always useful:

echo "Log star date `date`" > myFirstLogFile.log
cat myFirstLogFile.log
echo "So today I it some stuff..." >> myFirstLogFile.log
cat myFirstLogFile.log
echo "And some more stuff..." >> myFirstLogFile.log
echo "And even more stuff..." >> myFirstLogFile.log
cat myFirstLogFile.log
echo "Oops " > myFirstLogFile.log
cat myFirstLogFile.log

# Notice how we can print the standard out of "date"
date

# Date is very useful, you must google it...

date "+%d/%m/%Y"
date "+%d%m%Y"
date --date="2 year ago"

echo "Today it is `date +%d/%m/%Y`"

#############
# WILDCARDS #
#############

# Another essential concept to use the command-line to its full potential, is wildcards.

# Create Dummy Data: Copy paste the following code snip into your terminal and press enter:

###

cd $HOME/IBRO_2026_Workshop/
mkdir dummyDicomFolder
cd dummyDicomFolder

declare -a MY_ARRAY=("PIET" "KOOS" "SANNIE" "HILDA" "YODA")

for SUBJECT in "${MY_ARRAY[@]}"
do

RANDOM_DATE="$((RANDOM%10+2010))$((RANDOM%12+1))$((RANDOM%28+1))"
RANDOM_TIME=`printf "%.4d" "$((RANDOM%23+1))$((RANDOM%59+1))"`

mkdir $RANDOM_DATE"_"$RANDOM_TIME"_"$SUBJECT"_SE_BREIN"
cd $RANDOM_DATE"_"$RANDOM_TIME"_"$SUBJECT"_SE_BREIN"

for MRI_NUMBER in {1..10}
do

touch "FAKE_"$SUBJECT"_MRI_NR_"$MRI_NUMBER".dcm"
touch "FAKE_"$SUBJECT"_MRI_NR_"$MRI_NUMBER".nii"

done

cd $HOME/IBRO_2026_Workshop/
cd dummyDicomFolder

done

###

# Now that we have random data, we can test out wildcards:

cd $HOME/IBRO_2026_Workshop/dummyDicomFolder

ls

ls *

ls */*.dcm
ls */*.dcm
ls 20*

ls *KOOS*
ls *YODA*

ls *YODA*/*.nii
ls -l *YODA*/*.nii
ls -lt *YODA*/*.nii
ls -ltr *YODA*/*.nii

ls [1-9]*
ls [3-5]*

ls -d [1-9]*

##########################################
# PIPING AND REDIRECTING STANDARD OUTPUT #
##########################################

# This part is where you can get very creative. The standard output from one script can be sent to another.

cd $HOME/IBRO_2026_Workshop/dummyDicomFolder

# ls produces a text list, and we use the programs heads and tail to give the first 5 lines and last 2 lines respectively.

ls -l *YODA*/*.nii | head -n5
ls -l *YODA*/*.nii | tail -n2

##################
# COPYING THINGS #
##################

# Say we want to copy a whole folder with everything in it.

mkdir -p $HOME/IBRO_2026_Workshop/
cd $HOME/IBRO_2026_Workshop/
mkdir newLocation
ls

# You can use its absolute path ...

#Example:

cp /Users/stefan/IBRO_2026_Workshop/dummyDicomFolder/201172_0347_HILDA_SE_BREIN/FAKE_HILDA_MRI_NR_1.dcm /Users/stefan/IBRO_2026_Workshop/newLocation/

# If it doesnt work for you, read it again. Carefully... :)

# Or the relative path. That's relative, to where you are, so "pwd" helps:

cd $HOME/IBRO_2026_Workshop/
pwd
ls

# Copy works like this:
# copy <FLAGS> <SOURCE> <DESTINATION>
#              ^INPUT1^   ^INPUT2^

# Example: Copy Hilda's first file. And because we used random filenames, you need to TAB complete to get what Hilda's first scan is on your side.

cp dummyDicomFolder/201172_0347_HILDA_SE_BREIN/FAKE_HILDA_MRI_NR_1.dcm newLocation/

# Say you want to copy copy all Hilda's files into this folder:

cp dummyDicomFolder/201172_0347_HILDA_SE_BREIN/* newLocation/
                                           # Notice the /:  ^

# Maybe you want to only copy the dcm's?

cp dummyDicomFolder/201172_0347_HILDA_SE_BREIN/*.dcm newLocation/

# Now copy only the Nifti's ...

# Next, what if you want to copy all the folders?

cp dummyDicomFolder/ newLocation/

# This doesnt work. You need to use a flag, to tell the commandline that you want to copy all the folders with all their contents.

cp -r dummyDicomFolder/ newLocation/

# See if you were successful:

ls newLocation/*

# Next time do this, so that you can see everything you copied.

cp -vr dummyDicomFolder/ newLocation/

# Lets erase those files. We need to use "-r" again to say we want to remove everything. With an -f, so say that we are serious about it.

rm -fr newLocation/

# A better command to use is rsync. (I would use rsync to transport myself to mars, if that was an option). It is very good at checking for file corruption.

rsync -rtuv dummyDicomFolder/ newLocation/

# Figure the -rtuv flag out, by looking at the manual for rsync:

man rsync

# Try this again.

rsync -rtuv dummyDicomFolder/ newLocation/

# It's lazy. That is what makes it awesom.
# rsync and cp work exactly the same way, but you can copy across from one server to another with rsync.
# That is:
# rsync <FLAGS> <SOURCE> <DESTINATION>
#              ^INPUT1^    ^INPUT2^

# rsync <FLAGS> <LOCAL> <CHPC>
# Say we want to copy files to CHPC? We can do this:

#rsync -rtuv dummyDicomFolder/ splessis@lengau.chpc.ac.za:/home/splessis/newLocationOnCHPC/
#             ^local folder^ ^YourUsername^^CHPC address^           ^folder on CHPC^

# So to do the above, you need to:

# 1. ssh <yourusername>@lengau.chpc.ac.za
# Note: substitute your username into <yourusername> :)

# 2. mkdir newLocationOnCHPC/
# 3. cd newLocationOnCHPC
# 4. pwd
# 5. exit
# 5. <Go back to where dummyDicomFolder/ is located.>
# 6. rsync -rtuv dummyDicomFolder/ <yourusername>@lengau.chpc.ac.za:<pwd output for nr 4.>/

# Write the code here which you used, so that you dont forget. #
# Repeat this a few times to figure out how things work!


#######################
# What are variables? #
#######################

MyNewVariable="Stuff Inside the variable"
echo $MyNewVariable

# This is how you append stuff to a variable:

MyNewVariable=$MyNewVariable":More stuff"

# You can do it over and over again.

MyNewVariable=$MyNewVariable":More stuff"
MyNewVariable=$MyNewVariable":More stuff"
MyNewVariable=$MyNewVariable":More stuff"
MyNewVariable=$MyNewVariable":BlahBlahBlahETC"
echo $MyNewVariable

# Crucially, you can store the OUTPUT of other commands into the variable like this. Notice the "`" apostrophes.

cd $HOME/IBRO_2026_Workshop/dummyDicomFolder
ls -d *

MyListOfSubjects=`ls -d *`
echo $MyListOfSubjects

# This is important for scripts such as these:

for SUBJECT in $MyListOfSubjects
do

echo "I can now do things with the folder: $SUBJECT"

done

# Play around with the above script. This is the basis for almost every pipeline we make in neuroimaging!

# Notice the following distinctions:

let myNumbers=3 * (2 + 1)
echo $myNumbers
let myNumbers="$myNumbers * 2"

# Now make your own variables, and play around with them! I insist :)

# Now you know enough to do the basic setup of your PATH. Without this, nothing will work properly.

########################
# Setting up your PATH #
########################

# You have to find your BASH profile script. This is a script that launches everytime your terminal launches.
# Soooo...

cd $HOME
ls -a # This will list all the hidden files.

# It can have the following names:

#.bash_profile
#.profile
#.bashrc

# Go to the example scripts folder. You will find a file called ".example_bash_profile". Copy, paste the relevant information over. Make sure you understand what you are doing. You should have enough scripting background now to understand the hard parts.:)

########################################################
# Untar-ring: Often used to compress software packages #
########################################################

# A Tar ball is a collection of files...

cd $HOME/IBRO_2026_Workshop/dummyDicomFolder

tar -cvzf MyAmazingTarBall.tar.gz 20*
mkdir untarPlace
cd untarPlace

# How to untar them again:

tar -xvf MyAmazingTarBall.tar.gz
ls

################################################
# NEXT: CHPC_WORKSHOP_DAY1_FreesurferBasics.sh #
################################################





















