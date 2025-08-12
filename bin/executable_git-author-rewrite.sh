#!/bin/sh


if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
  echo "Usage: $(basename $0) <old e-mail> <new e-mail> <new name>" >/dev/stderr
  exit 2
fi

git filter-branch --env-filter '
OLD_EMAIL="$1"
CORRECT_EMAIL="$2"
CORRECT_NAME="$3"
if [ "$GIT_COMMITTER_EMAIL" != "$CORRECT_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" != "$CORRECT_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
