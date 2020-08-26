#!/bin/bash
clear

folder="/var/test/git"
fold_repo=$folder/testcase_pybash
dirname="/var/test/log"
env_file="/var/test/env.list"
repo_url="https://github.com/kontur-exploitation/testcase-pybash.git"
status_git=`git status | grep "On branch"`
hash=`git rev-parse $3`
start_year=2020
if_year=`date +%Y`
X=$(($if_year - $start_year + 1))
Y=`date +%m`
Z=`date +%j`
H=`date +%H`
version=$X.$Y.$Z-$H

mkdir -p ${folder}
mkdir -p ${dirname}

cd ${folder}
git clone ${repo_url}
cd ${fold_repo}
for remote in `git branch -r`
 do git branch --track ${remote#origin/} $remote
done

while true
 do
   if
    (($(date +%H) >= 17))  &&  ((($(date +%H)) <= 20))
    then
       cd ${fold_repo}
       git fetch --all
       for remote in `git branch -r`
        do git checkout $remote
           if [ git status | grep -q "can be fast-forwarded" ]
            then
            cd ${fold_repo}
            git pull
            set -- $status_git
            echo ""branch="$3">$env_file
            echo ""commit="$hash">>$env_file
            echo ""dir_name="$dirname">>$env_file
            docker image build . --iidfile -t test_repo/test_image:$version
            docker stop $(docker ps -a -q)
            docker container run test_image:$version -env-file $env_file --log-driver=json
           elif [ git status | grep -q "fatal: not a git repository" ]
            then
            cd ${folder}
            git clone ${repo_url}
           fi
       done
    fi
  sleep 3600
done
