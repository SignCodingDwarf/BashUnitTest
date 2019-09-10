#!/bin/bash

# file :  declareEnvVarModifTest.sh
# author : SignC0dingDw@rf
# version : 1.0
# date : 06 September 2019
# Unit testing of declareEnvVarModif.sh file.

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
if [ ! -z ${DECLAREENVIRONMENTVARMODIF_SH} ]; then 
    echo "DECLAREENVIRONMENTVARMODIF_SH already has value ${DECLAREENVIRONMENTVARMODIF_SH}"
    ((FAILED_TEST_NB++))
    exit ${FAILED_TEST_NB}
fi

### Include
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_LOCATION}/../utils/declareEnvVarModif.sh"

if [ ! "${DECLAREENVIRONMENTVARMODIF_SH}" = "DECLAREENVIRONMENTVARMODIF_SH" ]; then 
    echo "Loading of declareEnvVarModif.sh failed"
    ((FAILED_TEST_NB++))
    exit ${FAILED_TEST_NB}
fi

### Additional needed includes
. "${SCRIPT_LOCATION}/../utils/clean.sh"

##!
# @brief Test that the environment variables have their correct initial values
# @return 0 if list is correct, 1 otherwise
#
# Also increments FAILED_TEST_NB to ligthen test "main" structure.
#
##
CheckInitialVars()
{
    if [ ! "${ENV_T1}" = "ValA" ]; then
        echo "Expected ENV_T1 to have value ValA but got ${ENV_T1}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T2}" = "ValB" ]; then
        echo "Expected ENV_T2 to have value ValB but got ${ENV_T2}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T3}" = "ValC" ]; then
        echo "Expected ENV_T3 to have value ValC but got ${ENV_T3}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T4}" = "ValD" ]; then
        echo "Expected ENV_T4 to have value ValD but got ${ENV_T4}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! -z "${ENV_T5}" ]; then
        echo "Expected ENV_T5 to have empty value but got ${ENV_T5}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T6}" = "ValF" ]; then
        echo "Expected ENV_T6 to have value ValF but got ${ENV_T6}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    return 0
}

##!
# @brief Test that the environment variables have their correct altered values
# @return 0 if list is correct, 1 otherwise
#
# Also increments FAILED_TEST_NB to ligthen test "main" structure.
#
##
CheckAlteredVars()
{
    if [ ! "${ENV_T1}" = "ValZ" ]; then
        echo "Expected ENV_T1 to have value ValZ but got ${ENV_T1}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T2}" = "ValY" ]; then
        echo "Expected ENV_T2 to have value ValY but got ${ENV_T2}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T3}" = "ValX" ]; then
        echo "Expected ENV_T3 to have value ValX but got ${ENV_T3}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T4}" = "ValD" ]; then
        echo "Expected ENV_T4 to have value ValD but got ${ENV_T4}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T5}" = "Chewbacca" ]; then
        echo "Expected ENV_T5 to have value Chewbacca but got ${ENV_T5}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    if [ ! "${ENV_T6}" = "ValU ValT" ]; then
        echo "Expected ENV_T6 to have value ValU ValT but got ${ENV_T6}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
    return 0
}

##!
# @brief Check if content of ENV_VARS_VALUES_TO_RESTORE matches expected content
# @param @ : Expected content of the list
# @return 0 if list is correct, 1 otherwise
#
# Also increments FAILED_TEST_NB to ligthen test "main" structure.
#
##
CheckRestoreList()
{
    local expectedList=("${@}")
    # Compute differences as an array
    local differences=(`echo ${expectedList[@]} ${ENV_VARS_VALUES_TO_RESTORE[@]} | tr ' ' '\n' | sort | uniq -u`) # https://stackoverflow.com/questions/2312762/compare-difference-of-two-arrays-in-bash

    # Compute result
    if [ ${#differences[@]} -eq 0 ]; then
        return 0
    else
        echo "Expecting to get the content : ${expectedList[@]}"
        echo ""
        echo "But got content : ${ENV_VARS_VALUES_TO_RESTORE[@]}"
        echo ""
        echo "Difference : ${differences[@]}"
        ((FAILED_TEST_NB++)) ## New invalid test
        return 1
    fi
}

### Initialize lists
ENV_VARS_VALUES_TO_RESTORE=()

### Create Environment variables for the test
ENV_T1="ValA"
ENV_T2="ValB"
ENV_T3="ValC"
ENV_T4="ValD"
ENV_T6="ValF"

CheckInitialVars

### Register environment vars for restauration then give them new values
DeclEnvVar "ENV_T1"
CheckRestoreList "ENV_T1" "ValA"
ENV_T1="ValZ"

DeclEnvVar "ENV_T3"
CheckRestoreList "ENV_T1" "ValA" "ENV_T3" "ValC"
ENV_T3="ValX"

DeclEnvVar "ENV_T5"
CheckRestoreList "ENV_T1" "ValA" "ENV_T3" "ValC" "ENV_T5" ""
ENV_T5="Chewbacca"

### Register and modify environment vars
DeclModEnvVar "ENV_T2" "ValY"
CheckRestoreList "ENV_T1" "ValA" "ENV_T3" "ValC" "ENV_T5" "" "ENV_T2" "ValB"
DeclModEnvVar "ENV_T6" "ValU" "ValT"
CheckRestoreList "ENV_T1" "ValA" "ENV_T3" "ValC" "ENV_T5" "" "ENV_T2" "ValB" "ENV_T6" "ValF"

### Check Alteration of environment variables
CheckAlteredVars

### Restore environment vars
RestoreEnvVars "${ENV_VARS_VALUES_TO_RESTORE[@]}"

CheckInitialVars # Are vars returned to initial values

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
