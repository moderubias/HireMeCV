
# MAIN CONSTANT
MAIN := 'main.tex'

# OBJECTS RELATED TO PORTFOLIO (ORTP) 
# \begin{ORTP}

CV := cv/'$(MAIN)'
WORD := projects/word2tex/'$(MAIN)'
MATH := projects/math-monograph/'$(MAIN)'

# \end{ORTP}


.PHONY: all cv word math clean
all: cv word math


cv:
	latexmk -r .latexmkrc $(CV)

word:
	latexmk -r .latexmkrc $(WORD)

math:
	latexmk -r .latexmkrc $(MATH)

clean:
	latexmk -r .latexmkrc -C $(CV)
	latexmk -r .latexmkrc -C $(WORD)
	latexmk -r .latexmkrc -C $(MATH)
