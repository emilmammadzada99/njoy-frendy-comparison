#!/bin/csh

set EXE     = /path/frendy_20241030/frendy/main/frendy.exe

set ACE_DIR = ./fr
set INP_DIR = ./inp
set OUT_DIR = ./out

mkdir -p ${INP_DIR} ${OUT_DIR}

# File name tape30 için:
set ACE = ${ACE_DIR}/tape30

set CASE_NAME = `basename ${ACE}`
echo ${CASE_NAME}

set INP = ${INP_DIR}/${CASE_NAME}.inp

echo "plot_mode //processing mode"               > ${INP}
echo "ace_file_name   ${ACE}"                   >> ${INP}
echo "output_name     ${OUT_DIR}/${CASE_NAME}"  >> ${INP}

${EXE}  ${INP} > ${OUT_DIR}/${CASE_NAME}.log


