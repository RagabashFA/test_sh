#!/bin/bash
clear

folder="/var/test/git"
dirname="/var/test/log"
repo_url="https://github.com/kontur-exploitation/testcase-pybash.git"

mkdir -p ${folder}
mkdir -p ${dirname}

exec &> >(col -bp | tee -a "$(dirname ${0})/add.log")

while true
 do
   cd ${folder}
   for remote in `git branch -r`
    do git branch --track ${remote#origin/} $remote
   done
   if
   [[ $(date +%H) == 17 ]]
   [[ $(date +%H) == 20 ]]
   then
    if [ -d ${folder} ]
     then
       cd ${folder}
       git status
       if [ read -r -p "Changes to be committed" ]
       then
           cd ${folder}
           git fetch --all
       elif [ read -r -p "fatal: not a git repository" ]
         then
           cd ${folder}
           git clone ${repo_url}
       fi
    fi
done
