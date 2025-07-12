#!/bin/csh

set GNU_INP = ./gnuplot.inp

mkdir -p ${PWD}/plot

foreach GNU_FILE ( out/*.dat )
  set NU_NAME = `basename ${GNU_FILE} .xs`
  echo ${GNU_FILE}

  set XMIN     = 1.0e-5
  set XMAX     = 2.0e+7

  if( -f ${GNU_FILE} ) then
    echo 'set xr ['${XMIN}':'${XMAX}']'                                              > ${GNU_INP}
    echo 'set logscale y'                                                           >> ${GNU_INP}
    echo 'set logscale x'                                                           >> ${GNU_INP}
    echo 'set format x  "%2.1e"'                                                    >> ${GNU_INP}
    echo 'set format y  "%2.1e"'                                                    >> ${GNU_INP}
    echo 'set xlabel  "Neutron Energy [eV]"'                                        >> ${GNU_INP}
    echo 'set ylabel  "Cross Section [barn]"'                                       >> ${GNU_INP}
    echo 'set border lw 6'                                                          >> ${GNU_INP}
    echo 'set title "'${NU_NAME}'"'                                                 >> ${GNU_INP}
    echo 'set key left bottom'                                                      >> ${GNU_INP}
    echo 'set key box lw 6'                                                         >> ${GNU_INP}
    echo 'set size ratio 0.46 1.0'                                                  >> ${GNU_INP}
    echo 'set terminal png size 3840, 2880'                                         >> ${GNU_INP}
    echo 'set terminal png font "/usr/share/fonts/liberation/LiberationSerif-Regular.ttf, 66"' >> ${GNU_INP}
    echo 'set out "'${NU_NAME}'_xs.png"'                                            >> ${GNU_INP}
    echo 'plot   "'${GNU_FILE}'" using 1:2 w l lw 6 title "XS"'                     >> ${GNU_INP}
    gnuplot < ${GNU_INP}

    if( -s ${NU_NAME}_xs.png ) then
      mv ${NU_NAME}_xs.png ${PWD}/plot/
    else
      rm -rf ${NU_NAME}_xs.png
    endif
  endif
end

rm -rf ${GNU_INP}
