To install:

    curl -Lso - https://github.com/cloudartisan/dotfiles/tarball/master | \
    tar --strip-components 1 --exclude LICENSE --exclude README.md \
        -C $HOME -zvxf -
