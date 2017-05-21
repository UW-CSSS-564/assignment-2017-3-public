RMD_FILE = index.Rmd
PDF_FILE = assignment-2017-3.pdf
HTML_FILE = ${RMD_FILE:%.Rmd=%.html}

BIBFILE = assignment3.bib

all: $(PDF_FILE) $(HTML_FILE) $(MD_FILE)

$(PDF_FILE): $(RMD_FILE) $(wildcard includes/*.tex) $(BIBFILE)
	Rscript -e 'rmarkdown::render("$<",output_format="pdf_document",output_file="$@")'

$(HTML_FILE): $(RMD_FILE) $(wildcard includes/*.html) $(BIBFILE)
	Rscript -e 'rmarkdown::render("$<",output_format="html_document")'
