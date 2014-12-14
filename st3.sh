#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Sublime Text 3 bash settings
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# Environment
#------------------------------------------------------------------------------

export ST3_PROJECTS="${HOME}/sublime_projects"

[[ ! -d $ST3_PROJECTS ]] && mkdir -p $ST3_PROJECTS


#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
    if [ $# -eq 0 ]; then
        subl .;
    else
        subl "$@";
    fi;
}

# open project
function sublp () {
    subl --project "${ST3_PROJECTS}/${@}.sublime-project";
}

# make package
# Usage: makest3pkg {package_name} [path_to_source]
function makest3pkg() {
    usage="Usage: makest3pkg {package_name} [path_to_source]";
    if [ $# -eq 0 ]; then
        echo $usage;
        return 1;
    fi

    pkgname=$1;
    srcdir=".";
    if [ $# -gt 1 ]; then
        srcdir=$2;
        if [[ ! -d $srcdir ]]; then
            echo "ERROR: The source directory does not exist: ${srcdir}"
            echo $usage;
            return 1;
        fi
    fi

    if [ $srcdir != "." ]; then
        cd $srcdir;
    fi
    zip -r ${pkgname}.sublime-package . -x *.git*
}


#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------

# list projects
alias subls="find ${ST3_PROJECTS} -name \*.sublime-project -type f | sed 's|'\"${ST3_PROJECTS}\"'/\(.*\).sublime-project|\1|' | column -c 80"

# Opens any file in sublime editor
alias edit='subl'
