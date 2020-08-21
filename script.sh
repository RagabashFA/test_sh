#!/bin/bash
clear

folder="/var/test/git"
dirname="/var/test/log"
repo_url="https://github.com/kontur-exploitation/testcase-pybash.git"

exec &> >(col -bp | tee -a "$(dirname ${0})/add.log")

if [ -d ${folder} ]
then
  cd ${folder}
#  git remote update
  git status
#  cd ${folder}
#  count=$(git rev-list HEAD...origin/master --count)
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


  cd -
else
  git clone $repo_url

fi
