#!/bin/bash

# name:    reprint_all.sh
# author:  nbehrnd@yahoo.com
# license: 2020
# date:    2020-06-15 (YYYY-MM-DD)
# edit:    2020-06-15 (YYYY-MM-DD)

# Batch reprint of all .pdf in a folder.
#
# Bash script pdf_rewrite.sh moderates ghostscript well to reprint a .pdf
# in color, often retaining the searchable text layer and hyperlinks in
# this document.  But it works on one file at a time only.  For a set of
# .pdf files in a folder (e.g., to prepare these being managed by zotero
# or an other literature reference program), it were useful to expand its
# scope to work on all .pdf in this folder.
#
# As concept study, a call by
#
# ./reprint_all.sh
#
# aims to reprint the .pdf in the current working directory in color.  As
# it may overwrite overwrite the original .pdf in this folder, keep a 
# backup of them.  Provide enough (working) memory for the batch to work,
# otherwise the .pdf won't be closed correctly as intelligible files.

for file in *.pdf; do

    echo ""
    echo $file
    file="$file"
    filebase="$(basename "$file" .pdf)"
    optfile="/tmp/$$-${filebase}_opt.pdf"
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
            -dPrinted=false -sOutputFile="${optfile}" "${file}"

    if [ $? == '0' ]; then
        optsize=$(stat -c "%s" "${optfile}")
        orgsize=$(stat -c "%s" "${file}")
        if [ "${optsize}" -eq 0 ]; then
            echo "No output!  Keeping original"
            rm -f "${optfile}";
#            exit;
            continue;
        fi
        if [ ${optsize} -ge ${orgsize} ]; then
            echo "Didn't make it smaller! Keeping original"
            rm -f "${optfile}"
#            exit;
            continue;
        fi
        bytesSaved=$(expr $orgsize - $optsize)
        percent=$(expr $optsize '*' 100 / $orgsize)
        echo Saving $bytesSaved bytes \(now ${percent}% of old\)
        rm "${file}"
        mv "${optfile}" "${file}"
    fi

done
