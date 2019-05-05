#!/bin/bash

# file :  printTest.sh
# author : SignC0dingDw@rf
# version : 0.1
# date : 21 April 2019
# Unit testing of printUtils file. Does not implement runTest framework because it tests functions this framework implements.

### Exit Code
#
# 0 : Execution succeeded
# Number of failed tests otherwise
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

### Behavior Variables
FAILED_TEST_NB=0

### Test Functions
##!
# @brief Test that a color is the expected one
# @param 1 : Color name
# @param 2 : Expected value
# @param 3 : Current value
# @return 0 if color has expected value, 1 otherwise
#
##
TestColor()
{
    local colorName=$1
    local expectedValue=$2
    local currentValue=$3

    if [ "${currentValue}" = "${expectedValue}" ]; then
        return 0
    else
        echo "Invalid ${colorName}s"
        echo "Expected ${expectedValue}"
        echo "Got ${currentValue}"
        return 1    
    fi
}

### Test Functions
##!
# @brief Test that the result of a print method is indeed the one expected
# @param 1 : Function name
# @param 2 : Verbose enabled
# @param 3 : Message
# @return 0 if function displays message as expected, 1 if message is not printed correctly or 2 if function name is unknown
#
##
TestPrint()
{
    local functionName=$1
    local isVerbose=$2
    local message=$3

    local writtenMessage=$(${functionName} "${message}" 2>&1) # Print message on error flux and redirect it to standard output to catch it
    if [ "${functionName}" = "PrintInfo" ]; then
        if [ "${isVerbose}" = true ]; then
            local expectedMessage="\033[1;34m${message}\033[0m"
        else
            local expectedMessage=""
        fi
    elif [ "${functionName}" = "PrintWarning" ]; then
        local expectedMessage="\033[1;33m${message}\033[0m"
    elif [ "${functionName}" = "PrintError" ]; then
        local expectedMessage="\033[1;31m${message}\033[0m"
    else
        echo "Unknown function ${functionName}"
        return 2
    fi

    if [ "${writtenMessage}" = "${expectedMessage}" ]; then
        return 0
    else
        echo "Expected ${functionName} to print ${expectedMessage}"
        echo "but ${writtenMessage} was printed"
        return 1
    fi
}

### Include printUtils.sh
. "../utils/printUtils.sh"

### Test colors
TestColor "usage color" "\033[1;34m" ${usageColor}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

TestColor "description color" "\033[1;31m" ${descriptionColor}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

TestColor "help options color" "\033[1;32m" ${helpOptionsColor}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

TestColor "help category color" "\033[1;33m" ${helpCategoryColor}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

TestColor "info color" "\033[1;34m" ${infoColor}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

TestColor "warning color" "\033[1;33m" ${warningColor}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

TestColor "error color" "\033[1;31m" ${errorColor}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

TestColor "No format" "\033[0m" ${NC}
if [ $? -ne 0 ]; then
     ((FAILED_TEST_NB++)) ## New invalid test
fi

### Test print with no verbosity
TestPrint PrintInfo false "Some info message" # Should display nothing
TestPrint PrintWarning false "Some warning message"
TestPrint PrintError false "Some error message"

VERBOSE=true # Enable verbosity
TestPrint PrintInfo false "Some info message" # Still displays nothing because funtion is defined once and for all at fisrt call

if [ ${FAILED_TEST_NB} -eq 0 ]; then
    echo -e "\033[1;32mTest OK\033[0m"
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
