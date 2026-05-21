#!/bin/sh

#  CHPC_WORKSHOP_DAY2_ExampleShellScript.sh
#  
#
#  Created by Stéfan du Plessis on 2018/11/15.
#

# Run it like this: . CHPC_WORKSHOP_DAY2_ExampleShellScript.sh TestInput1 TestInput2

################
# SUBFUNCTIONS #
################

# We use subfunctions in a shell script when we want to do one thing repeatedly throughout a script.

SubFunctionA(){

echo "Hi, I am subfunction A!"

echo "Subfunction A: And this is my first input: $1"
echo "Subfunction A: And this is my second input: $2"

}

SubFunctionB(){

echo "Hi, I am subfunction B!"
echo "Subfunction B: And this is my first input: $1"
echo "Subfunction B: And this is my second input: $2"

}

#############
# MAIN CODE #
#############

# Note the echo's give us a clue how the script operates. When in doubt, use them liberally.

echo "Main Code Starts now!"

echo "Main: And this is my first input: $1"
echo "Main: And this is my second input: $2"

# Unlike MATLAB, Shell's internal functions precede the main code.

SubFunctionA Banana Ox
SubFunctionB White Yellow
SubFunctionA Banana NoOx

# An external function is like any other script. If it is on your PATH, then you can call it in a script. It it is not there, try adding it to the PATH like we learned on Day 1.

CHPC_WORKSHOP_DAY2_MyExternalFunctionA.sh

echo "All done!"

