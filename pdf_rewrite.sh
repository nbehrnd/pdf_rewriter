#!/bin/bash

# name:    pdf_rewrite.sh
# author:  nbehrnd@yahoo.com
# license: 2019, MIT
# date:    2019-12-17 (YYYY-MM-DD)
#

# Aiming to reduce file size of .pdf to be sent as an attachment,
# this bash script brings finds of different places together.  After
# provision of the executable bit by chmod, the call pattern is
#
# ./pdf_rewrite in_file.pdf [rp | gray]
#
# to yield the output .pdf file either as
# + reprint in either colorscale, or
# + a reprint constrained to gray scale.
#
# Often, the later still is 'good enough'  especially with modern .pdf
# by journal publications.  It requires an installation of ghostscript
# as by typical Linuxes e.g., Xubuntu 18.04.3 LTS.
#
# No warranties -- To be used on your own risk.

if [ "$2" == "rp" ]; then

    # 'reprint as such'
    #
    # Often, hyperlinks in publications are lost by this.  Color and the
    # searchable text layer however typically remain.  It either states
    # the savings obtained, or that a further shrinkage isn't obtained.
    # The output file will have the same name as the inpupt file.
    #
    # Except of the loop to direct the work into this branch, this is the
    # answer by Evan Langlois to
    #
    # https://tex.stackexchange.com/questions/18987/how-to-make-the-pdfs-produced-by-pdflatex-smaller?rq=1
    #
    # so the credit to figuring out the following belongs to him:

    file="$1"
    filebase="$(basename "$file" .pdf)"
    optfile="/tmp/$$-${filebase}_opt.pdf"
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
            -sOutputFile="${optfile}" "${file}"

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

elif [ "$2" == "gray" ]; then

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
    # modification.  Output is file output.pdf.

    gs \
     -sOutputFile=output.pdf \
     -sDEVICE=pdfwrite \
     -sColorConversionStrategy=Gray \
     -dProcessColorModel=/DeviceGray \
     -dCompatibilityLevel=1.4 \
     -dNOPAUSE \
     -dBATCH \
     $1

#  final coda:
fi
