

# Background

Occasionally, `*.pdf` &#x2013; including contemporary scientific
publications &#x2013; contain more (file) content, than needed to read.
Often, the file size may be reduced without harm to the searchable
text layer, though, by passing them to ghostscript for an additional
"print to \*.pdf".

By far, the bash script *does not* claim to be the first one
collecting bits and bolts to address the issue, rather serves as an
aide-memoire of finds encountered earlier.  Within reason, the
source of the snippets joined is provided, too; so the credit
belongs to those already in the field.


# Deployment

-   To work, provide the bash script the executable bit with `chmod.`
    To reprint the `*.pdf` while retaining the color, run either one
    of the following commands:
    
        ./pdf_rewrite.sh -c in.pdf
        ./pdf_rewrite.sh --colour in.pdf
        ./pdf_rewrite.sh --color in.pdf
        ./pdf_rewrite.sh -r in.pdf
        ./pdf_rewrite.sh --reprint in.pdf
    
    &#x2013; maybe more than once.  The underlying script by Evan Langlois<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>
    states in any case if the newly written file (of same name as the
    input file) is smaller than the original one, or not.

-   To reprint the `*.pdf` just in gray-scale, run either one of the
    following, functional equivalent commands:
    
        ./pdf_rewrite.sh -g in.pdf
        ./pdf_rewrite.sh --gray in.pdf
        ./pdf_rewrite.sh --grey in.pdf
    
    which will replace the original `.pdf` by a gray-scaled one.  The
    searchable text layer is retained.  The credit for this belongs to
    user `slm` on the unix stackexchange.<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup>

Depending on the publisher and the amount of color figures in the
`*.pdf` contains, savings in the range of 20 to 30% may be achieved.
As shown with the test file `link_example.pdf`, hyperlinks within
the document (e.g., table of contents) as well as those reaching out
(e.g., hyperlinked literature references / web sites) may be
preserved.

Enjoy &#x2013; at your own risk.


# Test case A

The scripts' efficiency is tested in a Linux Xubuntu 18.04.3 LTS
installation including ghostscript (version 9.26) on a review
article by Kletskov *et al.*<sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup>  This was published by Thieme
Verlag Stuttgart, Germany, as open access article under the terms of
Creative Commons Attributions License, and is stored in its original
form as file `Kletskov2020.pdf` in the repository.

The original is worth 3.4 MB, features five color portraits of the
authors of the publication, the the sparsely colored layout of the
journal, line and gray-scale drawings.  The publication does not
contain visible hyperlinks.

The shell script is provided the executable bit.  Running the
reprint instruction once decreases the file size of the .pdf file to
2.3 MB, corresponding to a saving of 1.1 MB (about 32% of the
original file size).

Departing from the file already reprinted (retaining the color
information) yields the gray-scale `output.pdf` of 677 kB with an
additional saving of 0.4 MB (about 12% of the original file size).


# Test case B

For a local check, you may run the script on file
`link_example.pdf`.  This contains a simple color image from
<http://www.texample.net> with a hyperlink to the original `.tex`
source file slightly adapted here, `link_example.tex`, suitable for
a compilation with `pdfLaTeX`.  The frame around the url in the .pdf
is one (the default) option to indicate an URL which *some* pdf
readers display, but not necessary relay if the document is print.

For a scientific publication containing cross- and hyperlinks, see
Elgrishi *et al.* in their Open Access publication about
Cyclovoltammetry (*J. Chem. Educ.* ****2018****, *95*, 197&#x2013;206; doi
[10.1021/acs.jchemed.7b00361](https://doi.org/10.1021/acs.jchemed.7b00361)).  Starting with a .pdf of 2.2 MB, the
reprint in color yields a file of 1.7 MB, the reprint in gray scale a
file of 1.2 MB.  Both conversions retain cross- and hyperlinks.


# Batch conversion

If working with a literature reference program like [zotero](https://www.zotero.org/), it may
be useful to apply these simplifications on a batch of `.pdf` files
in one folder.  As a concept study, scripts `reprint_all.sh` and
`gray_all.sh` thus moderate `ghostscript` to reprint either all
while retaining color (if present), or all `.pdf` in gray scale
only.  This relays the same set of parameters as `pdf_rewrite.sh`.


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> <https://tex.stackexchange.com/questions/18987/how-to-make-the-pdfs-produced-by-pdflatex-smaller?rq=1>

<sup><a id="fn.2" href="#fnr.2">2</a></sup> <https://unix.stackexchange.com/questions/93959/how-to-convert-a-color-pdf-to-black-white>

<sup><a id="fn.3" href="#fnr.3">3</a></sup> "Isothiazoles in the Design and Synthesis of Biologically
Active Substances and Ligands for Metal Complexes", Kletskov, A. V.;
Bumagin, N. A.; Zubkov, F. I.; Grudini, D. G.; Potkin,
V. I. *Synthesis*, **2020**, *52*, 159&#x2013;188, [doi 10.1055/s-0039-1690688](https://www.thieme-connect.de/products/ejournals/abstract/10.1055/s-0039-1690688).
