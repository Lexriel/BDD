NAME1=TD1_TP1_correction
NAME2=TD1_TP1_bis_correction
# BIB=bibliographie
# FR_NAME=Thèse_Alexandre_Temperville

all: TD1 TD1bis TD1a TD1bisa

TD1:
	pdflatex $(NAME1).tex
	pdflatex $(NAME1).tex
	pdflatex $(NAME1).tex
	make clean

TD1bis:
	pdflatex $(NAME2).tex
	pdflatex $(NAME2).tex
	pdflatex $(NAME2).tex
	make clean

clean:
	rm -rf *.ps *.dvi *.log *.bak *.blg *.bbl *.aux *.fot *.out *.toc *~

realclean: clean
	rm -rf $(NAME1).pdf $(NAME2).pdf
