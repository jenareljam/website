#!/bin/bash

# Problem:					html can't import other html
# Specific problem: I want to reuse header/footer across pages
# Solution:					build website from pieces

# setup
THIS_DIR="$( cd "$( /usr/bin/dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOC_ROOT=$THIS_DIR/document_root

# remove old document_root
if [[ "$DOC_ROOT" == "" ]] ; then
	echo "WOW -- BIG PROBLEM -- YOU ALMOST rm -rf'd YOUR DRIVE"
	exit -1
fi
rm -r $DOC_ROOT/*
# create new plain document_root
echo -n "" > $DOC_ROOT/.placeholder # placeholder file for git


### CREATING WEBSITE ###

# supporting files (css, img, static content, etc.)
cp -r $THIS_DIR/img $DOC_ROOT/
cp -r $THIS_DIR/css $DOC_ROOT/
#cp -r $THIS_DIR/CV.pdf $DOC_ROOT/
ln -s $THIS_DIR/files $DOC_ROOT/
ln -s $THIS_DIR/static_docs $DOC_ROOT/


# web pages
cp $THIS_DIR/robots.txt $DOC_ROOT/robots.txt
cat $THIS_DIR/header.html $THIS_DIR/index.html $THIS_DIR/footer.html > $DOC_ROOT/index.html
cat $THIS_DIR/header.html $THIS_DIR/teaching.html $THIS_DIR/footer.html > $DOC_ROOT/teaching.html
cat $THIS_DIR/header.html $THIS_DIR/projects.html $THIS_DIR/footer.html > $DOC_ROOT/projects.html
cat $THIS_DIR/header.html $THIS_DIR/nooneinthemiddle.html $THIS_DIR/footer.html > $DOC_ROOT/nooneinthemiddle.html
# posts
mkdir -p $DOC_ROOT/posts
for post in `ls $THIS_DIR/posts/`;
do
	cat $THIS_DIR/header.html $THIS_DIR/posts/$post $THIS_DIR/footer.html > $DOC_ROOT/posts/$post
done

# replace keywords
day=`date -R|cut -d " " -f 2`
month=`date -R|cut -d " " -f 3`
year=`date -R|cut -d " " -f 4`
date="$month $day, $year"
for file in $DOC_ROOT/*.html; do
	sed -i "s/{date}/$date/" $file
done
for file in $DOC_ROOT/posts/*.html; do
	sed -i "s/{date}/$date/" $file
done
