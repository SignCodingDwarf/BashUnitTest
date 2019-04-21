#!/bin/bash

# file :  runTest.sh
# author : SignC0dingDw@rf
# version : 0.1
# date : 16 April 2019
# Main script allowing to run a Bash Unit Test

### command line arguments
#
# $1 : Test name
#
### Exit Code
#
# 0 : Execution succeeded
# 1 : Invalid parameters
# Otherwise : See Setup, Test and Teardown for possible error codes
#

###
# Copyright (c) 2019 SignC0dingDw@rf. All rights reserved
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
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

### Include
. "testFunctions.sh"

### Version STR
VERSION_STR="0.1"

### Behavior variables
VERBOSE=false
DETAILED_EXECUTION=false
TEST_NAME=""

# Functions
##!
# @brief Display Usage Information
##
Usage()
{
    echo -e "Usage \n"
    echo -e "${usageColor} ./${0##*/} [options] <test_name>${NC}\n"
    echo -e "${descriptionColor}Main script allowing to run a Bash Unit Test${NC}\n"
    echo -e "Options:"
    echo -e "${helpCategoryColor}----- General Options -----${NC}"
    echo -e "${helpOptionsColor}-h${NC} or ${helpOptionsColor}--help${NC}\t\t show this help message and exit"
    echo -e "${helpOptionsColor}--version${NC}\t\t show program's version number and exit"
    echo -e ""
    echo -e "${helpCategoryColor}----- Execution Details -----${NC}"
    echo -e "${helpOptionsColor}-v${NC}\t\t make test execution verbose"
    echo -e "${helpOptionsColor}-x${NC}\t\t detailed execution information"
    echo -e ""
}

### Parse command line arguments
for i in "$@" # for every input argument
do
    case $i in
        -h|--help) # if asked to render help
            Usage # Print help and exit
            exit 0
        ;;
        --version) # if asked to display version
            echo -e "${0##*/} V${VERSION_STR}" # Print version and exit
            exit 0		
        ;;
        -v)
            VERBOSE=true
        ;;
        -x)
            DETAILED_EXECUTION=true
        ;;
        *) # Default Unknown argument
            if [ -z "${TEST_NAME}" ]; then
                TEST_NAME="${i}"
            else
                PrintError "Unknown argument : $i"
                Usage
                exit 1
            fi
        ;;
    esac
done

### Process arguments
if [ -z "${TEST_NAME}" ]; then
    PrintError "Missing test name"
    Usage
    exit 1
fi

[ "${DETAILED_EXECUTION}" = true ] && set -x

### Setup test environment and track state changes that should be restored
PrintInfo "Setting up Environment"
Setup
SETUP_STATUS=$?
if [ "${SETUP_STATUS}" -gt 0 ]; then
    PrintError "Failed to set up test environment with code ${SETUP_STATUS}"
    exit ${SETUP_STATUS}
fi 

### Test core
PrintInfo "Executing Test : ${testNameColor}${TEST_NAME}"
Test
TEST_STATUS=$?
if [ "${TEST_STATUS}" -gt 0 ]; then
    PrintError "Test ${TEST_NAME} failed with code ${TEST_STATUS}"
fi # We do not exit on test error because we must run teardown anyway

### Restore system original state by restoring any change made specifically for the test
PrintInfo "Cleaning up Environment"
Teardown
TEARDOWN_STATUS=$?
if [ "${TEARDOWN_STATUS}" -gt 0 ]; then
    PrintError "Failed to clean up test environment with code ${TEARDOWN_STATUS}"
    exit ${TEARDOWN_STATUS}
fi 

exit ${TEST_STATUS}

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