#!/bin/csh

# FRENDY'nin doğru yolu
set EXE       = /path/frendy_20241030/frendy/main/frendy.exe

# ACE dosyalarının bulunduğu klasörler
set ACE_DIR_F = ./fr
set ACE_DIR_N = ./nj

# Girdi ve çıktı klasörleri
set INP_DIR   = ./inp
set OUT_DIR   = ./out

# Klasörler yoksa oluştur
mkdir -p ${INP_DIR} ${OUT_DIR}

# Dosya adı: tape30
set CASE_NAME = tape30
echo ${CASE_NAME}

# ACE dosyalarının yolları
set ACE_F = ${ACE_DIR_F}/${CASE_NAME}
set ACE_N = ${ACE_DIR_N}/${CASE_NAME}
set INP   = ${INP_DIR}/${CASE_NAME}.inp

# Girdi dosyasını yaz
echo "plot_mode //processing mode"               > ${INP}
echo "ace_file_name   ( ${ACE_N}  ${ACE_F} )"   >> ${INP}
echo "  //Ref  : ${ACE_N}"                      >> ${INP}
echo "  //Comp : ${ACE_F}"                      >> ${INP}
echo "output_name     ${OUT_DIR}/comp_result_${CASE_NAME}"  >> ${INP}

# FRENDY çalıştır
${EXE}  ${INP} > ${OUT_DIR}/${CASE_NAME}.log

