
# Table of Contents

1.  [Background](#orgbb7298b)
2.  [Deployment](#orgef66eb5)
3.  [Test case](#orgd4534d4)


<a id="orgbb7298b"></a>

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


<a id="orgef66eb5"></a>

# Deployment

-   To work, provide the bash script the executable bit with `chmod.`
    To reprint the `*.pdf` while retaining the color, run
    
        ./pdf_rewrite.sh in.pdf rp
    
    &#x2013; maybe more than once.  The underlying script by Evan Langlois<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>
    states in any case if the newly written file (of same name as the
    input file) is smaller than the original one, or not.

-   To reprint the `*.pdf` just in gray-scale, run
    
        ./pdf_rewrite.sh in.pdf gray
    
    which will generate a gray-scaled file `output.pdf`; retaining the
    searchable text layer.  The credit for this belongs to user `slm`
    on the unix stackexchange.<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup>

Depending on the publisher and the amount of color figures in the
`*.pdf` contains, savings in the range of 20 to 30% may be achieved.

Enjoy &#x2013; at your own risk.


<a id="orgd4534d4"></a>

# Test case

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

The shell script is provided the executable bit.  Running

    ./pdf_rewrite.sh Kletskov2020.pdf rp

in just one cycle decreases the file size of the .pdf file to
2.3 MB, corresponding to a saving of 1.1 MB (about 32% of the
original file size).

Running

    ./pdf_rewrite.sh Kletskov2020.pdf gray

on the color-reprinted .pdf from above yields the gray-scale
`output.pdf` of 677 kB with an additional saving of 0.4 MB (about
12% of the original file size).


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> see <https://tex.stackexchange.com/questions/18987/how-to-make-the-pdfs-produced-by-pdflatex-smaller?rq=1>

<sup><a id="fn.2" href="#fnr.2">2</a></sup> see <https://unix.stackexchange.com/questions/93959/how-to-convert-a-color-pdf-to-black-white>

<sup><a id="fn.3" href="#fnr.3">3</a></sup> "Isothiazoles in the Design and Synthesis of Biologically
Active Substances and Ligands for Metal Complexes", Kletskov, A. V.;
Bumagin, N. A.; Zubkov, F. I.; Grudini, D. G.; Potkin,
V. I. *Synthesis*, **2020**, *52*, 159&#x2013;188, [doi 10.1055/s-0039-1690688](https://www.thieme-connect.de/products/ejournals/abstract/10.1055/s-0039-1690688).
