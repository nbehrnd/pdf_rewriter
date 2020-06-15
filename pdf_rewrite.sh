#!/bin/bash

# name:    pdf_rewrite.sh
# author:  nbehrnd@yahoo.com
# license: 2019, 2020 MIT
# date:    2019-12-17 (YYYY-MM-DD)
# edit:    2020-06-15 (YYYY-MM-DD)

# Aiming to reduce file size of a .pdf to be sent as an attachment,
# this bash script brings finds of different places together.  After
# provision of the executable bit by chmod, the call pattern is
#
# ./pdf_rewrite [-c | --colour | --color | --reprint | -g | --gray | --grey] input.pdf
#
# to yield the output .pdf file of same name as the original input, either
# + as a reprint retaining existing color scale (either -c, -r, --color,
# --colour, or --reprint)
# + as a reprint constrained to gray scale (either -g, or --gray, or --grey)
#
# Often, the later still is 'good enough'  especially with modern .pdf
# by journal publications.  It requires an installation of ghostscript
# as by typical Linuxes e.g., Xubuntu 18.04.3 LTS (which is gs 9.26).
#
# No warranties -- To be used on your own risk.

if [[ "$1" == "-c" || "--colour" || "--color" || "-r" || "--reprint" ]] ; then

    # 'reprint as such'
    #
    # Often, hyperlinks in publications are lost by this.  Color and the
    # searchable text layer however typically remain.  It either states
    # the savings obtained, or that a further shrinkage isn't obtained.
    # The output file will have the same name as the inpupt file.
    #
    # Except of the loop to direct the work into this branch, and addition
    # of the -dPrinted=false instruction to reatin hyperlinks, this is the
    # answer by Evan Langlois to
    #
    # https://tex.stackexchange.com/questions/18987/how-to-make-the-pdfs-produced-by-pdflatex-smaller?rq=1
    #
    # so the credit to figuring out the following belongs to him:

    file="$2"
    filebase="$(basename "$file" .pdf)"
    optfile="/tmp/$$-${filebase}_opt.pdf"
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
            -dPrinted=false -sOutputFile="${optfile}" "${file}"

    if [ $? == '0' ]; then
        optsize=$(stat -c "%s" "${optfile}")
        orgsize=$(stat -c "%s" "${file}")
        if [ "${optsize}" -eq 0 ]; then
            echo "No output!  Keeping original"
            rm -f "${optfile}"
            exit;
        fi
        if [ ${optsize} -ge ${orgsize} ]; then
            echo "Didn't make it smaller! Keeping original"
            rm -f "${optfile}"
            exit;
        fi
        bytesSaved=$(expr $orgsize - $optsize)
        percent=$(expr $optsize '*' 100 / $orgsize)
        echo Saving $bytesSaved bytes \(now ${percent}% of old\)
        rm "${file}"
        mv "${optfile}" "${file}"
    fi

# elif [[ "$1" == "-g" ]] || [[ "$1" == "--gray" ]] || [[ "$1" == "--grey" ]] ; then
elif [[ "$1" == "-g" || "--gray" || "--grey" ]] ; then

    # A reprint in grayscale (often sufficent for modern journal .pdf),
    # while retaining the searchable text layer.  The script was found
    # on Unix Stackexchange under
    #
    # https://unix.stackexchange.com/questions/93959/how-to-convert-a-color-pdf-to-black-white
    #
    # as answer by slm (answered Oct 7 '13 at 18:18).  Contrasting to
    # the the question, result is grayscale, rather than the bitonal
    # black-white.  If using on journal publications, meta data such as
    # 'Subject', 'Keywords', 'Author', 'Pages' are retained from the
    # original.  'Producer' (e.g., GPL Ghostscript), 'CreationDate',
    # 'ModDate' however obviously are subject to change during this
    # modification.
    # Contrasting to the original code, the output is written on expense
    # of the original file.  This prevents overwriting 'grayed .pdf'
    # while processing multiple files in one session.  By dPrinted=false,
    # hyperlinks remain.

    gs \
     -sOutputFile=output.pdf \
     -sDEVICE=pdfwrite \
     -sColorConversionStrategy=Gray \
     -dProcessColorModel=/DeviceGray \
     -dCompatibilityLevel=1.4 \
     -dNOPAUSE \
     -dBATCH \
     -dPrinted=false \
     $2

    # addition, name the output like the original read:
    mv output.pdf $2

#  final coda:
fi
