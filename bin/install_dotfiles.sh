#!/bin/bash

curl -Lso - https://github.com/cloudartisan/dotfiles/tarball/master \
    | tar --strip-components 1 -C $HOME -zvxf -
