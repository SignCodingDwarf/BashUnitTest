#!/bin/bash

# file :  declareDeletionTest.sh
# author : SignC0dingDw@rf
# version : 1.0
# date : 31 May 2019
# Unit testing of declareDeletion.sh file.

### Exit Code
#
# 0 : Execution succeeded
# Number of failed tests otherwise
#

###
# MIT License
#
# Copyright (c) 2019 SignC0dingDw@rf
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
###

###
# Copywrong (w) 2019 SignC0dingDw@rf. All profits reserved.
#
# This program is dwarven software: you can redistribute it and/or modify
# it provided that the following conditions are met:
#
#    * Redistributions of source code must retain the above copywrong 
#      notice and this list of conditions and the following disclaimer 
#      or you will be chopped to pieces AND eaten alive by a Bolrag.
#
#    * Redistributions in binary form must reproduce the above copywrong
#      notice, this list of conditions and the following disclaimer in 
#      the documentation and other materials provided with it or they
#      will be axe-printed on your stupid-looking face.
# 
#    * Any commercial use of this program is allowed provided you offer
#      99% of all your benefits to the Dwarven Tax Collection Guild. 
# 
#    * This software is provided "as is" without any warranty and especially
#      the implied warranty of merchantability or fitness to purport. 
#      In the event of any direct, indirect, incidental, special, examplary 
#      or consequential damages (including, but not limited to, loss of use;
#      loss of data; beer-drowning; business interruption; goblin invasion;
#      procurement of substitute goods or services; beheading; or loss of profits),   
#      the author and all dwarves are not liable of such damages even 
#      the ones they inflicted you on purpose.
# 
#    * If this program "does not work", that means you are an elf 
#      and are therefore too stupid to use this program.
# 
#    * If you try to copy this program without respecting the 
#      aforementionned conditions, then you're wrong.
# 
# You should have received a good beat down along with this program.  
# If not, see <http://www.dwarfvesaregonnabeatyoutodeath.com>.
###

### Behavior Variables
FAILED_TEST_NB=0
VERBOSE=true

### Test inclusion state before inclusion
if [ ! -z ${DECLAREDELETION_SH} ]; then 
    echo "DECLAREDELETION_SH already has value ${DECLAREDELETION_SH}"
    ((FAILED_TEST_NB++))
    exit ${FAILED_TEST_NB}
fi

### Include
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_LOCATION}/../utils/declareDeletion.sh"

if [ ! "${DECLAREDELETION_SH}" = "DECLAREDELETION_SH" ]; then 
    echo "Loading of declareDeletion.sh failed"
    ((FAILED_TEST_NB++))
    exit ${FAILED_TEST_NB}
fi

##!
# @brief Check that DIRS_CREATED variable has the expected content
# @param @ : Expected elements array
# @return 0 if content is correct, 1 otherwise
#
# Also increments FAILED_TEST_NB to ligthen test functions.
#
##
CheckDirsCreated()
{
    local expectedArray=("${@}")

    # Compute differences as an array
    local differences=(`echo ${expectedArray[@]} ${DIRS_CREATED[@]} | tr ' ' '\n' | sort | uniq -u`) # https://stackoverflow.com/questions/2312762/compare-difference-of-two-arrays-in-bash

    # Compute result
    if [ ${#differences[@]} -eq 0 ]; then
        return 0
    else
        echo "Expecting to get the content : ${expectedArray[@]}"
        echo ""
        echo "But got content : ${DIRS_CREATED[@]}"
        echo ""
        echo "Difference : ${differences[@]}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
}

##!
# @brief Check that FILES_CREATED variable has the expected content
# @param @ : Expected elements array
# @return 0 if content is correct, 1 otherwise
#
# Also increments FAILED_TEST_NB to ligthen test functions.
#
##
CheckFilesCreated()
{
    local expectedArray=("${@}")

    # Compute differences as an array
    local differences=(`echo ${expectedArray[@]} ${FILES_CREATED[@]} | tr ' ' '\n' | sort | uniq -u`) # https://stackoverflow.com/questions/2312762/compare-difference-of-two-arrays-in-bash

    # Compute result
    if [ ${#differences[@]} -eq 0 ]; then
        return 0
    else
        echo "Expecting to get the content : ${expectedArray[@]}"
        echo ""
        echo "But got content : ${FILES_CREATED[@]}"
        echo ""
        echo "Difference : ${differences[@]}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
}

##!
# @brief Check that directory content corresponds to expected elements according to filter
# @param 1 : Folder
# @param 2 : Filter of folder lists
# @param 3-@ : Expected elements array
# @return 0 if content is correct, 1 otherwise
#
# Also increments FAILED_TEST_NB to ligthen test functions.
#
##
CheckDirContent()
{
    local content=$(ls $1 | grep $2)
    local expectedArray=("${@:3}")

    # Compute differences as an array
    local differences=(`echo ${expectedArray[@]} ${content[@]} | tr ' ' '\n' | sort | uniq -u`) # https://stackoverflow.com/questions/2312762/compare-difference-of-two-arrays-in-bash

    # Compute result
    if [ ${#differences[@]} -eq 0 ]; then
        return 0
    else
        echo "Expecting to get the content : ${expectedArray[@]}"
        echo ""
        echo "But got content : ${content[@]}"
        echo ""
        echo "Difference : ${differences[@]}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
}

### Initialize lists
DIRS_CREATED=()
FILES_CREATED=()

### Declare folders to delete
DeclFoldersToDel /tmp/foo1 /tmp/foo2 /tmp/foo3
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Declaring folders to delete should work fine but exited with code ${RETURN}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_DIRS_CREATED=(/tmp/foo1 /tmp/foo2 /tmp/foo3)
CheckDirsCreated ${REFERENCE_DIRS_CREATED[@]} # Check list of folders to delete
CheckDirContent /tmp/ "foo" # Check folders have not been created

### Add additional folders to existing list and check no element gets lost
DeclFoldersToDel /tmp/foo4 /tmp/foo5
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Declaring folders to delete should work fine but exited with code ${RETURN}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_DIRS_CREATED=(/tmp/foo1 /tmp/foo2 /tmp/foo3 /tmp/foo4 /tmp/foo5)
CheckDirsCreated ${REFERENCE_DIRS_CREATED[@]}
CheckDirContent /tmp/ "foo" # Still nothing created

### Add additional folders to create, check they are added to the list and created
DeclMkFoldersToDel /tmp/foo6 /tmp/foo7
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Declaring folders to delete should work fine but exited with code ${RETURN}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_DIRS_CREATED=(/tmp/foo1 /tmp/foo2 /tmp/foo3 /tmp/foo4 /tmp/foo5 /tmp/foo6 /tmp/foo7)
CheckDirsCreated ${REFERENCE_DIRS_CREATED[@]}
CheckDirContent /tmp/ "foo" "foo6" "foo7"

### Add additional folders to create, check that errors are generated and detected
DeclMkFoldersToDel /tmp/foo6 /tmp/foo3/bar /tmp/foo8 # foo6 exists so error, foo3 does not exist so error, only foo8 will be created
RESULT=$?
if [ ${RESULT} -ne 2 ]; then
    echo "Declaring folders to delete should have detected two errors but exited with code ${RESULT}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_DIRS_CREATED=(/tmp/foo1 /tmp/foo2 /tmp/foo3 /tmp/foo4 /tmp/foo5 /tmp/foo6 /tmp/foo7 /tmp/foo8)
CheckDirsCreated ${REFERENCE_DIRS_CREATED[@]}
CheckDirContent /tmp/ "foo" "foo6" "foo7" "foo8"

### Declare files to delete
DeclFilesToDel /tmp/foo6/bar1 /tmp/foo6/bar2 /tmp/foo6/bar3
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Declaring files to delete should work fine but exited with code ${RETURN}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_FILES_CREATED=(/tmp/foo6/bar1 /tmp/foo6/bar2 /tmp/foo6/bar3)
CheckFilesCreated ${REFERENCE_FILES_CREATED[@]} # Check list of folders to delete
CheckDirContent /tmp/foo6/ "bar" # Check files have not been created

### Add additional files to existing list and check no element gets lost
DeclFilesToDel /tmp/foo6/bar4 /tmp/foo6/bar5 
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Declaring files to delete should work fine but exited with code ${RETURN}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_FILES_CREATED+=(/tmp/foo6/bar4 /tmp/foo6/bar5)
CheckFilesCreated ${REFERENCE_FILES_CREATED[@]} # Check list of folders to delete
CheckDirContent /tmp/foo6/ "bar" # Check files have not been created

### Add additional files to create, check they are added to the list and created
DeclMkFilesToDel /tmp/foo6/barA /tmp/foo6/barC
RESULT=$?
if [ ${RESULT} -ne 0 ]; then
    echo "Declaring files to delete should work fine but exited with code ${RETURN}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_FILES_CREATED+=(/tmp/foo6/barA /tmp/foo6/barC)
CheckFilesCreated ${REFERENCE_FILES_CREATED[@]} # Check list of folders to delete
CheckDirContent /tmp/foo6/ "bar" "barA" "barC" # Check files have not been created

### Add additional files to create, check that errors are generated and detected
DeclMkFilesToDel /tmp/foo4/barW /tmp/foo6/barZ /tmp/foo6/barC
RESULT=$?
if [ ${RESULT} -ne 2 ]; then
    echo "Declaring files to delete should have detected 2 errors but exited with code ${RETURN}"
    ((FAILED_TEST_NB++)) ## New invalid test
fi
REFERENCE_FILES_CREATED+=(/tmp/foo6/barZ)
CheckFilesCreated ${REFERENCE_FILES_CREATED[@]} # Check list of folders to delete
CheckDirContent /tmp/foo6/ "bar" "barA" "barC" "barZ" # Check files have not been created

### Clean up
rm -rf /tmp/foo*

### Test result
if [ ${FAILED_TEST_NB} -eq 0 ]; then
    echo -e "\033[1;32mTest OK\033[0m"
else
    echo -e "\033[1;31mTest KO\033[0m"
fi

exit ${FAILED_TEST_NB}

#  ______________________________ 
# |                              |
# |    ______________________    |
# |   |                      |   |
# |   |         Sign         |   |
# |   |        C0ding        |   |
# |   |        Dw@rf         |   |
# |   |         1.0          |   |
# |   |______________________|   |
# |                              |
# |______________________________|
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |  |
#               |__|
