#!/bin/bash

# file :  functionTest.sh
# author : SignC0dingDw@rf
# version : 0.1
# date : 09 May 2019
# Unit testing of functionUtils file. Does not implement runTest framework because it tests functions this framework uses.

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

### Include functionUtils.sh
. "../utils/functionUtils.sh"

### Test before function exists
FunctionExists DummyFunction
RESULT=$?
if [ $RESULT -eq "0" ]; then
    echo "Test of non existing function should not return 0"
    ((FAILED_TEST_NB++)) ## New invalid test
fi

### Test that function does not create symbol of function
FunctionExists DummyFunction
RESULT=$?
if [ $RESULT -eq "0" ]; then
    echo "Testing function existence should not create associated symbol"
    ((FAILED_TEST_NB++)) ## New invalid test
fi

### Declare function
DummyFunction()
{
    echo "Does nothing"
}

### Test existing function
FunctionExists DummyFunction
RESULT=$?
if [ $RESULT -ne "0" ]; then
    echo "Existence test of existing function should return 0 but returned ${RESULT} instead."
    ((FAILED_TEST_NB++)) ## New invalid test
fi

### Delete Function symbol
unset -f DummyFunction

### Test function deletion
FunctionExists DummyFunction
RESULT=$?
if [ $RESULT -eq "0" ]; then
    echo "Deletion of function should remove symbol."
    ((FAILED_TEST_NB++)) ## New invalid test
fi

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
