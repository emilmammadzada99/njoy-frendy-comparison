#!/bin/csh

# FRENDY'exe path
set EXE       = /path/frendy_20241030/frendy/main/frendy.exe

# ACE path directory 
set ACE_DIR_F = ./fr
set ACE_DIR_N = ./nj

# Inputs and Outputs directory
set INP_DIR   = ./inp
set OUT_DIR   = ./out

# 
mkdir -p ${INP_DIR} ${OUT_DIR}

# File Name: tape30
set CASE_NAME = tape30
echo ${CASE_NAME}

# ACE cases
set ACE_F = ${ACE_DIR_F}/${CASE_NAME}
set ACE_N = ${ACE_DIR_N}/${CASE_NAME}
set INP   = ${INP_DIR}/${CASE_NAME}.inp

# Input 
echo "plot_mode //processing mode"               > ${INP}
echo "ace_file_name   ( ${ACE_N}  ${ACE_F} )"   >> ${INP}
echo "  //Ref  : ${ACE_N}"                      >> ${INP}
echo "  //Comp : ${ACE_F}"                      >> ${INP}
echo "output_name     ${OUT_DIR}/comp_result_${CASE_NAME}"  >> ${INP}

# FRENDY running
${EXE}  ${INP} > ${OUT_DIR}/${CASE_NAME}.log

