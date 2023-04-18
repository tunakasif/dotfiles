#!/bin/bash

# download latest eisvogel template release
gh release download -R Wandmalfarbe/pandoc-latex-template -p 'Eisvogel-*.zip'

# find first zip file containing pandoc in its name and unzip it
zipname=$(find . -name "Eisvogel-*.zip" | head -n 1)
basename=$(basename $zipname .zip)

# extract the latest `eisvogel.tex` from zip file
# and copy it to the current directory
unzip -qq -j -o $zipname eisvogel.latex
rm $zipname
