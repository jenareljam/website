#!/bin/bash

# Problem:					html can't import other html
# Specific problem: I want to reuse header/footer across pages
# Solution:					build website from pieces

# setup
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOC_ROOT=$THIS_DIR/document_root

# remove old document_root
rm -rf $DOC_ROOT
# create new plain document_root
mkdir $DOC_ROOT
echo -n "" > $DOC_ROOT/.placeholder # placeholder file for git


### CREATING WEBSITE ###

# supporting files (css, img, static content, etc.)
cp -r $THIS_DIR/img $DOC_ROOT/
cp -r $THIS_DIR/css $DOC_ROOT/
cp -r $THIS_DIR/CV.pdf $DOC_ROOT/
ln -s $THIS_DIR/files $DOC_ROOT/


# web pages
cat $THIS_DIR/header.html $THIS_DIR/index.html $THIS_DIR/footer.html > $DOC_ROOT/index.html
cat $THIS_DIR/header.html $THIS_DIR/teaching.html $THIS_DIR/footer.html > $DOC_ROOT/teaching.html
cat $THIS_DIR/header.html $THIS_DIR/projects.html $THIS_DIR/footer.html > $DOC_ROOT/projects.html
