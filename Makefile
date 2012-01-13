#
# http://www.maxwit.com
#


BOOK_TEX := $(wildcard *.tex)
ART_TEX  := $(wildcard *.art.tex)
SLI_TEX  := $(wildcard *.sli.tex)

BOOK_TEX := $(filter-out style.tex, $(BOOK_TEX))
BOOK_TEX := $(filter-out $(ART_TEX), $(BOOK_TEX))
BOOK_PDF := $(BOOK_TEX:%.tex=%.pdf)
BOOK_DVI := $(BOOK_TEX:%.tex=%.dvi)

SLI_PDF := $(SLI_TEX:%.tex=%.pdf)

all: $(BOOK_PDF)
	@echo
	@ls -lh *.pdf
	@echo

%.pdf: %.tex $(ART_TEX)
	xelatex $<
	xelatex $<
	@rm -v $(<:.tex=.aux)
	@rm -v $(<:.tex=.log)
	@rm -v $(<:.tex=.toc)
	@rm -v $(<:.tex=.out)

clean:
	@for set in $(wildcard *.tex); \
	do \
		for fn in `ls $${set%tex}*`; \
		do \
			if [ $${fn##*.} != tex ]; then rm -rvf $$fn; fi \
		done \
	done
