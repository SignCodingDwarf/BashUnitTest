#!/bin/bash

# file :  printUtils.sh
# author : SignC0dingDw@rf
# version : 0.1
# date : 16 April 2019
# Definition of utilitaries and variables used to display information

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

### Colors
# Usage
usageColor='\033[1;34m' # Help on command is printed in light blue
descriptionColor='\033[1;31m' # Help on command is printed in light red
helpOptionsColor='\033[1;32m' # Help on options is printed in light green
helpCategoryColor="\033[1;33m" # Help options categories are printed in yellow

# Messages
infoColor='\033[1;34m' # Infos are printed in light blue
warningColor='\033[1;33m' # Errors are printed in yellow
errorColor='\033[1;31m' # Errors are printed in light red

# No format
NC='\033[0m' # No Color

### Functions
##!
# @brief Print an information formatted message to the stderr
# @param * : Elements to display
# @return 0 if printing was successful, >0 otherwise
#
# From https://stackoverflow.com/questions/2990414/echo-that-outputs-to-stderr
# Uses the environment defined VERBOSE to determine whether printg should be done.
# Uses the principle of collapsing functions in bash 
# https://wiki.bash-hackers.org/howto/collapsing_functions 
#
##
PrintInfo()
{
    if [ "${VERBOSE}" = true ]; then
        PrintInfo() # Print is defined as verbose at first call
        {
            printf "${infoColor}%s${NC}\n" "$*" >&2 # Concatenate args into a string, print it and redirect to stderr 
        }
        PrintInfo "$*" # We print the first thing we wanted to print
    else
        PrintInfo() 
        {
            : # Does nothing if verbosity is disabled
        } 
    fi
}

##!
# @brief Print a warning formatted message to the stderr
# @param * : Elements to display
# @return 0 if printing was successful, >0 otherwise
#
# From https://stackoverflow.com/questions/2990414/echo-that-outputs-to-stderr
#
##
PrintWarning()
{
    printf "${warningColor}%s${NC}\n" "$*" >&2 # Concatenate args into a string, print it and redirect to stderr 
}

##!
# @brief Print an error formatted message to the stderr
# @param * : Elements to display
# @return 0 if printing was successful, >0 otherwise
#
# From https://stackoverflow.com/questions/2990414/echo-that-outputs-to-stderr
#
##
PrintError()
{
    printf "${errorColor}%s${NC}\n" "$*" >&2 # Concatenate args into a string, print it and redirect to stderr 
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
