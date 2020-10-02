#!/bin/bash
clear

readonly cur_loc_script=`pwd`
fold_git="/var/test/git"
fold_repo=$folder/testcase-pybash
dir_log="/var/test/log"
repo_url="https://github.com/example/example.git"
status_git=`git status | grep "On branch"`
start_year=2020
cur_year=`date +%Y`
X=$(($cur_year - $start_year + 1))
Y=`date +%m`
Z=`date +%j`
H=`date +%H`
version=$X.$Y.$Z-$H

mkdir -p ${fold_git}
mkdir -p ${dir_log}

cd ${fold_git}
git clone ${repo_url}
cd ${fold_repo}
for remote in `git branch -r`
 do git branch --track ${remote#origin/} $remote
done
cp $cur_loc_script/.dockerignore $fold_repo
cp $cur_loc_script/dockerfile $fold_repo
cp $cur_loc_script/package.json $fold_repo

while true
 do
   if
    (($(date +%H) >= 11))  &&  ((($(date +%H)) <= 20))
    then
       cd ${fold_repo}
       git fetch --all
       for remote in `git branch -r`
        do git checkout ${remote#origin/}
           if [ git status | grep -q "can be fast-forwarded" ]
            then
            cd ${fold_repo}
            git pull
            set -- $status_git
            hash=`git rev-parse $3`
            docker image build . --build-arg branch=${3} --build-arg commit=${hash} --build-arg dir_log=${dir_log} -t test_image:$version
            docker stop $(docker ps -a -q)
            docker container run -d test_image:$version
           elif [ git status | grep -q "fatal: not a git repository" ]
            then
            cd ${fold_git}
            git clone ${repo_url}
            cp $cur_loc_script/.dockerignore $fold_repo
            cp $cur_loc_script/dockerfile $fold_repo
            cp $cur_loc_script/package.json $fold_repo
           fi
       done
    fi
  sleep 3600
done
