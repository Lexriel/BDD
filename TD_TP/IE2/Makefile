NAME1=IE2_correction

all: IE2_correction

IE2_correction:
	pdflatex $(NAME1).tex
	pdflatex $(NAME1).tex
	pdflatex $(NAME1).tex
	make clean

clean:
	rm -rf *.ps *.dvi *.log *.bak *.blg *.bbl *.aux *.fot *.out *.toc *~

realclean: clean
	rm -rf $(NAME1).pdf
