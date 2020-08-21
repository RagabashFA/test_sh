#!/bin/bash
clear

folder="/home/user/git"
repo_url="https://github.com/kontur-exploitation/testcase-pybash.git"

if [ -d ${folder} ]
then
  cd ${folder}
#  git remote update
  git status
#  cd ${folder}
  count=$(git rev-list HEAD...origin/master --count)
  if [ $count -gt "0" ]
  then
    read -r -p  "Update [y/n] " answer
    if [ "$answer" = "y" ]
    then
      git fetch --all
      git reset --hard origin/master
    fi
  fi
  cd -
else
  git clone $repo_url

fi
