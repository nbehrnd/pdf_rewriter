
# name:   readme_pdf_rewriter.txt
# author: nbehrnd@yahoo.com
# date:   2019-12-17 (YYYY-MM-DD)

Occasionally, .pdf -- including contempory scientific publications --
contain more (file) content, than needed to read.  Often, the file
size may be reduced without harm to the searchable text layer, though,
by passing them to ghostscript for an additional 'print to .pdf'.

By far, the bash script does not claim to be the first one collecting
bits and bolts to address the issue, rather serves as an aide-memoire
of finds encountered earlier.  Within reason, the source of the snippets
joined is provided, too; so the credit belongs to those already in the
field.

To work, provide the bash script the executable bit with chmod.  To
reprint the .pdf while retaining the color, run

./pdf_rewrite.sh in.pdf rp

-- maybe more than once.  The underlying script by Evan Langlois states
in any case if the newly written file (of same name as the input file)
is smaller than the original one, or not.

To reprint the .pdf just in gray-scale, run

./pdf_rewrite.sh in.pdf gray

which will generate a gray-scaled output.pdf; retaining the searchable
text layer.  The credit for this belongs to user slm on the unix
stackexchange.

Depending on the publisher and the amount of color figures in the .pdf
contains, savings in the range of 20 to 30% may be achieved.

Enjoy -- at your own risk.
