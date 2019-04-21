#!/bin/bash

# file :  cleanUtils.sh
# author : SignC0dingDw@rf
# version : 0.1
# date : 18 April 2019
# Definition of utility functions to clean environment after test

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

### Functions
##!
# @brief Delete all the provided directories
# @param 1 : List of dirs to delete
# @return 0 if all dirs where deleted, >0 for every dir not deleted
#
# A deletion is considered a failure if and only if the directory still exists and deletion failed.
# If the directory does not exist for whatever reason, we do not consider deletion a failure
#
##
DeleteDirs()
{
    local NB_FAILS=0 # Number of directory delete failures
    local DIRS=("$@")
    for dir in "${DIRS[@]}"; do 
        PrintInfo "Deleting ${dir}"
        rm -rf ${dir}
        if [ $? -gt 0 ]; then # Command is expected to return 0 when not failing
            ((NB_FAILS++))
        fi
    done

    return $NB_FAILS
}

##!
# @brief Delete all the provided files
# @param 1 : List of files to delete
# @return 0 if all files where deleted, >0 for every file not deleted
#
# A deletion is considered a failure if and only if the file still exists and deletion failed.
# If the file does not exist for whatever reason, we do not consider deletion a failure
#
##
DeleteFiles()
{
    local NB_FAILS=0 # Number of file delete failures
    local FILES=("$@")
    for file in "${FILES[@]}"; do 
        PrintInfo "Deleting ${file}"
        rm -f ${file}
        if [ $? -gt 0 ]; then # Command is expected to return 0 when not failing
            ((NB_FAILS++))
        fi
    done

    return $NB_FAILS
}

##!
# @brief Restore provided dirs
# @param 1 : List of dirs to restore
# @return 0 if all dirs where restored, >0 for every failure
#
# A restauration is considered a failure either if the altered dir cannot be deleted or if the diverted dir cannot be moved back (it does not exist for instance).
#
##
RestoreDirs()
{
    local NB_FAILS=0 # Number of directory delete failures
    local DIRS=("$@")
    for dir in "${DIRS[@]}"; do 
        PrintInfo "Restoring ${dir}"
        rm -rf ${dir}
        if [ $? -gt 0 ]; then # Command is expected to return 0 when not failing
            ((NB_FAILS++))
        else
           mv ${dir}.utmv ${dir} # Move back the directory
           if [ $? -gt 0 ]; then # Command is expected to return 0 when not failing
              ((NB_FAILS++))
           fi
        fi
    done
    return $NB_FAILS
}

##!
# @brief Restore provided files
# @param 1 : List of files to restore
# @return 0 if all files where restored, >0 for every failure
#
# A restauration is considered a failure either if the altered file cannot be deleted or if the diverted file cannot be moved back (it does not exist for instance).
#
##
RestoreFiles()
{
    local NB_FAILS=0 # Number of file delete failures
    local FILES=("$@")
    for file in "${FILES[@]}"; do 
        PrintInfo "Restoring ${dir}"
        rm -f ${file}
        if [ $? -gt 0 ]; then # Command is expected to return 0 when not failing
            ((NB_FAILS++))
        else
           mv ${file}.utmv ${file} # Move back the file
           if [ $? -gt 0 ]; then # Command is expected to return 0 when not failing
              ((NB_FAILS++))
           fi
        fi
    done
    return $NB_FAILS
}

##!
# @brief Restore environment variables
# @param 1 : List of variables to restore paired with the associated values
# @return 0 if all variables where restored, >0 for every failure
#
# After assigning value to restore to variable, we check it has been applied effectively. If not, it is a failure. If a value does not exist for the variable, it is a failure as well.
# Management of dynamic variables coming from
# https://stackoverflow.com/questions/16553089/dynamic-variable-names-in-bash
#
##
RestoreEnvVars()
{
    local NB_FAILS=0 # Number of file delete failures
    local ENV_VARS_VALUES=("$@")
    local ENV_VARS_INDEXES=(${!ENV_VARS_VALUES[@]}) # Get the list of indexes as an array
    local ENV_VARS_MAX_INDEX=${ENV_VARS_INDEXES[-1]} # Last element is the maximum index
    if [ $((ENV_VARS_MAX_INDEX%2)) -eq 0 ]; then # If the last index is even, we miss one value since arrays are 0-indexed
        ((NB_FAILS++)) # last value will not be set so it is an error
        ((ENV_VARS_MAX_INDEX--)) # We decrement the value to get the termination index
    fi

    local index=0
    while [ ${index} -lt ${ENV_VARS_MAX_INDEX} ]; do
        local VARIABLE=${!ENV_VARS_VALUES[${index}]}
        local VALUE=${!ENV_VARS_VALUES[${index}+1]}
        PrintInfo "Restoring variable ${VARIABLE} with value ${VALUE}"
        declare ${VARIABLE}=${VALUE} # Affect variable with value
        local VAR_NAME=${VARIABLE}
        if [ ! "${!VAR_NAME}" = "${VALUE}" ]; then
            PrintError "Failed to affect ${VARIABLE} with value ${VALUE}. Current value is ${!VAR_NAME}"
            ((NB_FAILS++))
        fi
        ((index+=2))
    done

    return $NB_FAILS
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
