#!/bin/bash
clear

folder="c_beginning"
repo_url="https://github.com/cCppProsto/c_beginning.git"

if [ -d ${folder} ]
then
  cd ${folder}
  git remote update
  cd ${folder}
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
  echo "${folder} not exist"
  git clone $repo_url

fi
