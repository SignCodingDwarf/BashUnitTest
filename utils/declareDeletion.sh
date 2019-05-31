#!/bin/bash

# file :  declareDeletion.sh
# author : SignC0dingDw@rf
# version : 1.0
# date : 31 May 2019
# Definition of functions used to declare directories and files to delete

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

### Protection against multiple inclusions
if [ -z ${DECLAREDELETION_SH} ]; then

DECLAREDELETION_SH="DECLAREDELETION_SH" # Reset using DECLAREDELETION_SH=""

### Include
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_LOCATION}/../BashUtils/printUtils.sh"

##!
# @brief Declare folders to delete
# @param @ : List of folders to delete at the end of test
# @return 0 
#
##
DeclFoldersToDel()
{
    local DIRS=("$@")
    PrintInfo "Adding the following directories for deletion : "
    PrintInfo "${DIRS[@]}"
    DIRS_CREATED+=("${DIRS[@]}") # Append indexes to the array
    return 0
}

##!
# @brief Create folders then declare them as folders delete
# @param @ : List of folders to create and delete at the end of test
# @return 0 if all folders could be created, otherwise the number of folders that were not created
#
# If a folder already exists, creation is considered a failure and folder is not added to list of folders to delete.
# Considers parents of directory exist.
#
##
DeclMkFoldersToDel()
{
    local DIRS=("$@")
    local FAILED_CREATION=0
    for dir in ${DIRS[@]}; do
        PrintInfo "Creating ${dir} folder"
        mkdir ${dir}
        local RESULT=$?
        if [ ${RESULT} -eq 0 ]; then
            DeclFoldersToDel ${dir} # Declare folder to be deleted
        else
            PrintWarning "Failed to create ${dir} directory with code ${RESULT}"
            ((FAILED_CREATION++))
        fi
    done
    return ${FAILED_CREATION}
}

##!
# @brief Declare files to delete
# @param @ : List of files to delete at the end of test
# @return 0 
#
##
DeclFilesToDel()
{
    local FILES=("$@")
    PrintInfo "Adding the following files for deletion : "
    PrintInfo "${FILES[@]}"
    FILES_CREATED+=("${FILES[@]}") # Append indexes to the array
    return 0
}

##!
# @brief Create files then declare them as files delete
# @param @ : List of files to create and delete at the end of test
# @return 0 if all files could be created, otherwise the number of files that were not created
#
# If a files already exists, creation is considered a failure and file is not added to list of files to delete.
# Considers parents of directory exist.
#
##
DeclMkFilesToDel()
{
    local FILES=("$@")
    local FAILED_CREATION=0
    for f in ${FILES[@]}; do
        PrintInfo "Creating ${f} file"
        if [[ ! -e ${f} ]]; then
            touch ${f}
            local RESULT=$?
            if [ ${RESULT} -eq 0 ]; then
                DeclFilesToDel ${f} # Declare file to be deleted
            else
                PrintWarning "Failed to create ${f} file with code ${RESULT}"
                ((FAILED_CREATION++))
            fi
        else
            PrintWarning "File ${f} already exists. It should be diverted."
            ((FAILED_CREATION++))
        fi
    done
    return ${FAILED_CREATION}
}


fi # DECLAREDELETION_SH

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
