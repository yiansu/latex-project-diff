#!/bin/bash

# check inputs
if [ $# -ne 4 ] ; then
  echo "USAGE: OLD_PROJECT_DIR NEW_PROJECT_DIR DIFF_PROJECT_DIR [entry_document_name]"
fi

OLD_PROJECT_DIR=${1}
NEW_PROJECT_DIR=${2}
DIFF_PROJECT_DIR=${3}
ENTRY_DOCUMENT=${4}

# clone the diff project from the new project
rm -rf ${DIFF_PROJECT_DIR} ;
cp -r ${NEW_PROJECT_DIR} ${DIFF_PROJECT_DIR} ;
rm -rf ${DIFF_PROJECT_DIR}/${ENTRY_DOCUMENT}.tex ;

# generate .bbl files for both old and new projects
# reference: https://tex.stackexchange.com/questions/625608/how-to-use-latexdiff-to-compare-changes-in-bib-files
pushd . &> /dev/null ;
cd ${OLD_PROJECT_DIR} ;
pdflatex -interaction=nonstopmode ${ENTRY_DOCUMENT}.tex &> /dev/null ;
bibtex ${ENTRY_DOCUMENT}.aux &> /dev/null ;
popd &> /dev/null ;

pushd . &> /dev/null ;
cd ${NEW_PROJECT_DIR} ;
pdflatex -interaction=nonstopmode ${ENTRY_DOCUMENT}.tex &> /dev/null ;
bibtex ${ENTRY_DOCUMENT}.aux &> /dev/null ;
popd &> /dev/null ;

# run latexdiff on entry document and bbl files
# reference: https://tex.stackexchange.com/questions/167064/latexdiff-changes-in-bibliography-with-biblatex-and-biber
latexdiff --flatten ${OLD_PROJECT_DIR}/${ENTRY_DOCUMENT}.tex ${NEW_PROJECT_DIR}/${ENTRY_DOCUMENT}.tex > ${DIFF_PROJECT_DIR}/${ENTRY_DOCUMENT}-diff.tex ;
latexdiff ${OLD_PROJECT_DIR}/${ENTRY_DOCUMENT}.bbl ${NEW_PROJECT_DIR}/${ENTRY_DOCUMENT}.bbl > ${DIFF_PROJECT_DIR}/${ENTRY_DOCUMENT}-diff.bbl ;

# generate the final diff pdf
pdflatex -output-directory=${DIFF_PROJECT_DIR} -interaction=nonstopmode ${DIFF_PROJECT_DIR}/${ENTRY_DOCUMENT}-diff.tex &> /dev/null ;
pdflatex -output-directory=${DIFF_PROJECT_DIR} -interaction=nonstopmode ${DIFF_PROJECT_DIR}/${ENTRY_DOCUMENT}-diff.tex &> /dev/null ;

# open the final diff pdf
# open ${DIFF_PROJECT_DIR}/${ENTRY_DOCUMENT}-diff.pdf ;
