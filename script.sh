#!/bin/bash
clear

folder="/var/test/git"
dirname="/var/test/log"
env_file="/var/test/env.list"
repo_url="https://github.com/kontur-exploitation/testcase-pybash.git"
status_git=` git status | grep "On branch"`
hash=`git rev-parse $3`
date=`date +%F--%H-%M`

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
    (($(date +%H) >= 17))  &&  ((($(date +%H)) <= 20))
   then
    if [ -d ${folder} ]
     then
       cd ${folder}
       git status
       if [ grep -q "Changes to be committed" ]
       then
           cd ${folder}
           git fetch --all
           set -- $status_git
           echo ""branch="$3">$env_file
           echo ""hash="$hash">>$env_file
           docker image build -t test_repo/test_image:$date --env-file $env_file
           docker container stop
           docker container run test_image:$date
       elif [ grep -q "fatal: not a git repository" ]
         then
           cd ${folder}
           git clone ${repo_url}
       fi
    fi
  fi
done
