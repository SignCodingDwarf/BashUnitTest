#!/bin/bash

# file :  argErrorTest.sh
# author : SignC0dingDw@rf
# version : 1.0
# date : 30 May 2019
# Unit testing of BashUnitTest framework. Test cases of wrong arguments provided.

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

### Test functions
# No need here because it will exit before entering test run

### Test error : too many arguments
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
(. ${SCRIPT_LOCATION}/../runTest.sh -v ArgErrorTest ArgCausingError  2> /tmp/testOutput) # Call in subshell for testing purport in order to avoid current script to be exited by runtest exit command : https://unix.stackexchange.com/questions/217650/call-a-script-for-another-script-but-dont-exit-the-parent-if-the-child-calls-e
# In your test you can simply call runTest.sh and let it exit your test
# We redirect output ot file to test that verbosity works. Help texts displayed on std output is not considered
RETURN=$?

### Check up test success
if [ "${RETURN}" -ne "1" ]; then
    echo "Test should return an argument error"
    ((FAILED_TEST_NB++)) ## New invalid test
fi

### Check output produced
# Fill test file
touch /tmp/testReference
echo "[Error] : Unknown argument : ArgCausingError" > /tmp/testReference

diff -q /tmp/testOutput /tmp/testReference
RETURN=$?
if [ "${RETURN}" -ne "0" ]; then
    echo "Error in output generated. Expected :"
    cat /tmp/testReference
    echo ""
    echo "But got :"
    cat /tmp/testOutput
    ((FAILED_TEST_NB++)) ## New invalid test
fi

### Test error : no test name defined
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
(. ${SCRIPT_LOCATION}/../runTest.sh -v -x 2> /tmp/testOutput) # Call in subshell for testing purport in order to avoid current script to be exited by runtest exit command : https://unix.stackexchange.com/questions/217650/call-a-script-for-another-script-but-dont-exit-the-parent-if-the-child-calls-e
# In your test you can simply call runTest.sh and let it exit your test
# We redirect output ot file to test that verbosity works. Help texts displayed on std output is not considered
RETURN=$?

### Check up test success
if [ "${RETURN}" -ne "1" ]; then
    echo "Test should return an argument error"
    ((FAILED_TEST_NB++)) ## New invalid test
fi

### Check output produced
# Fill test file
echo "[Error] : Missing test name" > /tmp/testReference

diff -q /tmp/testOutput /tmp/testReference
RETURN=$?
if [ "${RETURN}" -ne "0" ]; then
    echo "Error in output generated. Expected :"
    cat /tmp/testReference
    echo ""
    echo "But got :"
    cat /tmp/testOutput
    ((FAILED_TEST_NB++)) ## New invalid test
fi

### Clean up
rm -f /tmp/testReference
rm -f /tmp/testOutput

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
