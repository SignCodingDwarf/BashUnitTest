#!/bin/bash

# file :  testFunctions.sh
# author : SignC0dingDw@rf
# version : 1.1
# date : 01 September 2019
# Definition of functions used in test process

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

### Include
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_LOCATION}/BashUtils/printUtils.sh"
. "${SCRIPT_LOCATION}/BashUtils/functionUtils.sh"
. "${SCRIPT_LOCATION}/utils/clean.sh"

##!
# @brief Test setup phase
# @return 0 if setup was successful, >0 otherwise
#
##
Setup()
{
    # Declare arrays that will contain information to be restored
    # Files and directories
    DIRS_CREATED=() # Directories created for the test that will be deleted
    FILES_CREATED=() # Files created for the test that will be deleted
    DIRS_DIVERTED=() # Directories which content has to be diverted. Original can be found at <name>.utmv
    FILES_DIVERTED=() # Files which content has to be diverted. Original can be found at <name>.utmv

    # Environement
    ENV_VARS_VALUES_TO_RESTORE=() # Modified environment variables paired with the value to restore.

    # Check if user has defined specific operations
    FunctionExists TestSetup
    if [ "$?" -eq "0" ]; then
        TestSetup
    else
        PrintWarning "No User defined set up is to be performed"
        return 0
    fi
}

##!
# @brief Test execution phase
# @return 0 if setup was successful, >0 otherwise
#
##
Test()
{
    # Check if user has defined specific operations
    FunctionExists TestExec
    if [ "$?" -eq "0" ]; then
        TestExec
    else
        PrintWarning "Nothing will be done in the test"
        return 0
    fi
}

##!
# @brief Test teardown phase
# @return 0 if setup was successful, otherwise adds one of more of following values
# 1  : Directory deletion failed
# 2  : File deletion failed
# 4  : Restoring diverted directories failed
# 8  : Resoring diverted files failed
# 16 : Restoring environment variables failed
# 128 : User defined TestTeardown failed
#
##
Teardown()
{
    local EXIT_CODE=0

    # Delete directories
    DeleteDirs "${DIRS_CREATED[@]}"
    if [ $? -gt 0 ]; then
        ((EXIT_CODE+=1))
    fi

    # Delete Files
    DeleteFiles "${FILES_CREATED[@]}"
    if [ $? -gt 0 ]; then
        ((EXIT_CODE+=2))
    fi

    # Restore diverted directories
    RestoreDirs "${DIRS_DIVERTED[@]}"
    if [ $? -gt 0 ]; then
        ((EXIT_CODE+=4))
    fi

    # Restore diverted directories
    RestoreFiles "${FILES_DIVERTED[@]}"
    if [ $? -gt 0 ]; then
        ((EXIT_CODE+=8))
    fi

    # Restore environment variables
    RestoreEnvVars "${ENV_VARS_VALUES_TO_RESTORE[@]}"
    if [ $? -gt 0 ]; then
        ((EXIT_CODE+=16))
    fi

    # Check if user has defined specific operations
    FunctionExists TestTeardown
    if [ "$?" -eq "0" ]; then
        TestTeardown
        if [ $? -gt 0 ]; then
            ((EXIT_CODE+=128))
        fi
    else
        PrintWarning "No User defined tear down is to be performed"
    fi
    return ${EXIT_CODE}
}

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
