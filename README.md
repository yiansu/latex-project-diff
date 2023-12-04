# A tool to generate a pdf-diff file between two latex projects


## How to use it

USAGE: `./projectdiff.sh OLD_PROJECT_DIR NEW_PROJECT_DIR DIFF_PROJECT_DIR [entry_document_name]`

Example: `./projectdiff.sh Project_Old Project_New Project_Diff example`

See the example in [example-diff.pdf](./example-diff.pdf).


## Assumption

Both old and new latex projects use the same entry document.


## Dependency

You're expecting to have a [LaTeX system distribution](https://www.latex-project.org/get/) installed on your machine, which automatically installs all necessary tools for you such as `pdflatex`, `bibtex` and `latexdiff`.
