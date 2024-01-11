# Background

Depending on the pdf creator/engine used, a `.pdf` file may include
content irrelevant for reading by a human. An example is the inclusion
of complete sets of fonts though only a few glyphs are (or only one is)
used on the "electronic paper". To print the `.pdf` with `ghostscript`
again into a `.pdf` may reduce the file size e.g., prior to organize a
publication in a reference manager.

By far, this bash script *does not* claim to be the first one collecting
bits and bolts to address the issue. It rather serves as an aide-memoire
of finds encountered earlier, and to moderate `ghostscript` in Linux
accordingly. Within reason, the snippets were joined as provided; thus,
the credit belongs to those already in the field.

# Intended Use

One use consists of 1) the provision of the executable bit (`chmod
  +x pdf_reprint.sh`), and 2) to set an alias in your `.bashrc` file.
Then, the functionality described below is available all across your
system.

- Else, to reprint the `.pdf` while retaining the color, run either one
  of the following commands

  ``` shell
  bash ./pdf_rewrite.sh --reprint input.pdf
  bash ./pdf_rewrite.sh -r input.pdf
  bash ./pdf_rewrite.sh --colour input.pdf
  bash ./pdf_rewrite.sh --color input.pdf
  bash ./pdf_rewrite.sh -c input.pdf
  ```

  *to replace* the original file `input.pdf` by a new version of smaller
  file size. There will be a short note if the attempt was successful;
  and if so, the improvement compared to the original `input.pdf` is
  reported (percentage). Though you may process the file multiple times
  with this method, savings in file size often quickly converge to be
  insignificant in comparison to the remaining file size.

  The credit for the underlying approach and implementation belongs to
  Evan Langlois.[^1]

- Often, an additional reduction of file size may be obtained by
  reprinting the `.pdf` in gray-scale only. Either one of the following
  commands to the script is equivalent

  ``` shell
  bash ./pdf_rewrite.sh --gray input.pdf
  bash ./pdf_rewrite.sh --grey input.pdf
  bash ./pdf_rewrite.sh -g input.pdf
  ```

  to replace file `input.pdf` by its rewritten form. The credit for this
  approach belongs to user `slm` on the Unix stackexchange.[^2]

- To process multiple `.pdf`, a for-loop in your shell could follow the
  pattern of

  ``` shell
  for file in *.pdf
  do
      echo "$file"
      bash ./pdf_rewrite.sh -r "$file"
  done
  ```

  This equally provides you a brief progress report, too.

Note, this script's primary aim is to obtain a file of small file size,
e.g., as an attachment of an email while retaining the text easy to read
and – if present – to retain a text layer searchable. Especially the
reprint in half-tones however may render illustrations less
intelligible. It is up to the creators of figures to use easy
discernible markers in diagrams, as well as to use color scales suitable
for the color blind, and safe for this mimicked "photocopying". For the
later, a service like <https://colorbrewer2.org/> may guide your
selection.

Keep a backup of the .pdf to be processed. Though the script may report
problems while processing the data (or even crash, which may destroy the
.pdf), it *is not* a PDF validator such as e.g., veraPDF.[^3]

# Benchmark

Initially written for Linux Xubuntu 18.04.3 LTS and ghostscript
(version 9.26), the script is known working well e.g., with
Debian 13/trixie (currently *testing*) and GPL Ghostscript
(version 10.02.1 published by 2023-11-01).

- File `link2web.pdf` was compiled with pdfLaTeX based on an example
  provided by
  [www.texample.net](http://www.texample.net/tikz/examples/lune-of-hippocrates/).
  This .pdf contains a color figure and link to an external reference.
  Note, the simplification into half-tones (option `-g`) affects the
  document printed, depending on the pdf viewer used, the box around the
  link may remain colored *for the display on screen*.

- The performance of the utility was tested on a couple of recent
  publications in chemistry. To ease a potential replication,
  publications used for the bench marke are – within reason – available
  open access/CC.

In the table below, *savings* computes the difference of the file size
prior and after the processing with either option, then reports this
change as percentage in respect to the file size of the originally
submitted file after a single run of optimization.

Typically, the simple reprint `-r` retaining the color is the fastest
approach to reduce most of the file size in one run and hence already
*good enough*. How much file size is saved seems to vary not only by the
relatice amount of special (mathematical) characters, but among journals
by the same publisher; see for instance the small savings for a reprint
for *J. Appl. Cryst.* vs. *Helv. Chim. Acta* both published by Wiley.

| source                                                              |        publisher | original | reprint `-r` | saved `%` | reprint `-g` | saved `%` |
|:--------------------------------------------------------------------|-----------------:|---------:|-------------:|----------:|-------------:|----------:|
| [2023ACR3640](https://doi.org/10.1021/acs.accounts.3c00588)         |              ACS |   7.0 MB |       4.5 MB |      35.7 |       3.2 MB |      54.3 |
| [2023ACR3654](https://doi.org/10.1021/acs.accounts.3c00595)         |              ACS |   2.4 MB |       1.6 MB |      33.3 |       1.6 MB |      33.3 |
| [2023CrystGrowthDes8469](https://doi.org/10.1021/acs.cgd.3c00985)   |              ACS |   3.7 MB |       0.9 MB |      75.7 |       0.9 MB |      75.7 |
| [2024CrystGrowthDes71](https://doi.org/10.1021/acs.cgd.3c00476)     |              ACS |  10.5 MB |       1.5 MB |      85.7 |       1.4 MB |      86.7 |
| [2023CRV12135](https://doi.org/10.1021/acs.chemrev.3c00372)         |              ACS |   9.4 MB |       6.1 MB |      35.1 |       5.3 MB |      43.6 |
| [2023CRV13291](https://doi.org/10.1021/acs.chemrev.3c00241)         |              ACS |  25.5 MB |       4.0 MB |      84.3 |       3.7 MB |      85.5 |
| [2023CRV13713](https://doi.org/10.1021/acs.chemrev.3c00489)         |              ACS |  12.0 MB |       4.5 MB |      62.5 |       4.2 MB |      65.0 |
| [2023JCE4674](https://doi.org/10.1021/acs.jchemed.3c00845)          |              ACS |   2.8 MB |       2.2 MB |      21.4 |       2.1 MB |      25.0 |
| [2023JCE4728](https://doi.org/10.1021/acs.jchemed.3c00306)          |              ACS |   2.6 MB |       1.0 MB |      61.5 |       1.0 MB |      61.5 |
| [2023JOC16679](https://doi.org/10.1021/acs.joc.3c01753)             |              ACS |   4.7 MB |       3.2 MB |      31.9 |       3.0 MB |      36.2 |
| [2023JOC16719](https://doi.org/10.1021/acs.joc.3c00815)             |              ACS |   9.9 MB |       2.4 MB |      75.8 |       2.1 MB |      78.8 |
| [2023OL9002](https://doi.org/10.1021/acs.orglett.3c03590)           |              ACS |   2.4 MB |       1.2 MB |      50.0 |       1.1 MB |      54.2 |
| [2023OL9243](https://doi.org/10.1021/acs.orglett.3c03993)           |              ACS |   2.2 MB |       1.4 MB |      36.4 |       1.4 MB |      36.4 |
| [2023Tetrahedron133750](https://doi.org/10.1016/j.tet.2023.133750)  |         Elsevier |   1.2 MB |       1.0 MB |      16.7 |       0.6 MB |      50.0 |
| [2024Tetrahedron133787](https://doi.org/10.1016/j.tet.2023.133787)  |         Elsevier |   1.9 MB |       1.8 MB |       5.3 |       1.6 MB |      15.8 |
| [2023TL154433](https://doi.org/10.1016/j.tetlet.2023.154433)        |         Elsevier |   831 kB |       721 kB |      13.2 |       497 kB |      40.2 |
| [2024TL154885](https://doi.org/10.1016/j.tetlet.2023.154885)        |         Elsevier |   1.6 MB |       0.9 MB |      43.8 |       0.9 MB |      43.8 |
| [2024PCCP713](https://doi.org/10.1039/d3cp05084j)                   |              RSC |   1.0 MB |       1.0 MB |       0.0 |       0.5 MB |      50.0 |
| [2024PCCP770](https://doi.org/10.1039/d3cp03800a)                   |              RSC |   2.3 MB |       2.1 MB |       8.7 |       0.8 MB |      65.2 |
| [2024TheorChemAcc4](https://doi.org/10.1007/s00214-023-03077-7)     |         Springer |   1.7 MB |       0.8 MB |      52.9 |       0.7 MB |      58.8 |
| [2023TheorChemAcc133](https://doi.org/10.1007/s00214-023-03069-7)   |         Springer |   1.7 MB |       1.0 MB |      41.2 |       1.0 MB |      41.2 |
| [2024JSulfurChem138](https://doi.org/10.1080/17415993.2023.2255711) | Taylor & Francis |   469 kB |       248 kB |      47.1 |       247 kB |      47.3 |
| [2023JSulfurChem269](https://doi.org/10.1080/17415993.2022.2164196) | Taylor & Francis |   5.6 MB |       2.9 MB |      48.2 |       2.0 MB |      64.3 |
| [2023Synthesis3777](https://doi.org/10.1055/a-2126-3774)            |           Thieme |   976 kB |       936 kB |       4.1 |       528 kB |      45.9 |
| [2023Synthesis3947](https://doi.org/10.1055/s-0042-1751502)         |           Thieme |   2.2 MB |       2.2 MB |       0.0 |       1.9 MB |      13.6 |
| [2024ACIEe202310983](https://doi.org/10.1002/anie.202310983)        |            Wiley |   877 kB |       800 kB |       8.8 |       507 kB |      42.2 |
| [2024ACIEe202314446](https://doi.org/10.1002/anie.202314446)        |            Wiley |   2.5 MB |       2.4 MB |       4.0 |       1.2 MB |      52.0 |
| [2023HCAe202300110](https://doi.org/10.1002/hlca.202300110)         |            Wiley |  10.4 MB |       5.5 MB |      47.1 |       2.9 MB |      72.1 |
| [2023HCAe202300154](https://doi.org/10.1002/hlca.202300154)         |            Wiley |  10.4 MB |       5.7 MB |      45.2 |       2.2 MB |      78.8 |
| [2023JApplCryst1618](https://doi.org/10.1107/S1600576723008324)     |            Wiley |   1.1 MB |       1.1 MB |       0.0 |       0.9 MB |      18.2 |
| [2023JApplCryst1639](https://doi.org/10.1107/S1600576723008439)     |            Wiley |   2.8 MB |       2.7 MB |       3.6 |       1.2 MB |      57.1 |
| link2web.pdf                                                        |         pdflatex |  38.0 kB |       9.8 kB |      74.2 |       9.8 kB |      74.2 |

# Footnotes

[^1]: <https://tex.stackexchange.com/questions/18987/how-to-make-the-pdfs-produced-by-pdflatex-smaller?rq=1>

[^2]: <https://unix.stackexchange.com/questions/93959/how-to-convert-a-color-pdf-to-black-white>

[^3]: <https://openpreservation.org/tools/verapdf/>
