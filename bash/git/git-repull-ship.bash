#!/bin/sh -x
# repull: Merge the latest changes from the master branch into your current branch
function repull {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || exit 0
  CURRENT="${ref#refs/heads/}"
  git checkout master
  git pull origin master
  git checkout ${CURRENT}
  git rebase master
}

# ship: Ship out current branch to master and delete local branch
function ship {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || exit 0
  CURRENT="${ref#refs/heads/}"
  git checkout master
  git merge ${CURRENT}
  git push origin master
  git branch -d ${CURRENT}
}