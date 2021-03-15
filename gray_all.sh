#!/bin/bash

# name:    gray_all.sh
# author:  nbehrnd@yahoo.com
# license: 2020
# date:    2020-06-15 (YYYY-MM-DD)
# edit:

# Batch reprint of all .pdf in a folder in gray scale.
#
# Similar to sibling script reprint_all.sh, this script aims for the
# simplification of all the .pdf found in a folder.  Here, however, the
# script instructs ghostscript to substitute the color information by
# gray scale only. 
#
# As concept study, a call by
#
#./gray_all.sh

# aims to reprint the .pdf in the current working directory in gray scale.
# It will overwrite the original .pdf in this folder.

for file in *.pdf; do

    echo ""
    echo $file

    gs \
     -sOutputFile=output.pdf \
     -sDEVICE=pdfwrite \
     -sColorConversionStrategy=Gray \
     -dProcessColorModel=/DeviceGray \
     -dCompatibilityLevel=1.4 \
     -dNOPAUSE \
     -dBATCH \
     -dPrinted=false \
     $file

    # addition, name the output like the original read:
    mv output.pdf $file



done
