#!/bin/csh

set GNU_INP = ./gnuplot.inp

mkdir -p ${PWD}/ace_plot
mkdir -p ${PWD}/ace_plot_only

foreach FILE ( out/*.dat )
  set NU_NAME = `basename ${FILE} .dat`
  echo ${FILE}

  set XMIN     = 1.0e-5
  set XMAX     = 2.0e+7

  if( -f ${FILE} ) then
    set ENE     = 1
    set XS_REF  = 2
    set XS_COMP = 3
    set XS_DIF  = 4

    echo 'set xr ['${XMIN}':'${XMAX}']'                                              > ${GNU_INP}
    echo 'set logscale y'                                                           >> ${GNU_INP}
    echo 'set logscale x'                                                           >> ${GNU_INP}
    echo 'set y2tics'                                                               >> ${GNU_INP}
    echo 'set y2range [-1.00:1.00]'                                                 >> ${GNU_INP}
    echo 'set format x  "%2.1e"'                                                    >> ${GNU_INP}
    echo 'set format y  "%2.1e"'                                                    >> ${GNU_INP}
    echo 'set format y2 "%+2.1f"'                                                   >> ${GNU_INP}
    echo 'set xlabel  "Neutron Energy [eV]"'                                        >> ${GNU_INP}
    echo 'set ylabel  "Cross Section [barn]"'                                       >> ${GNU_INP}
    echo 'set y2label "(FRENDY - NJOY) / NJOY [%]"'                                 >> ${GNU_INP}
    echo 'set border lw 6'                                                          >> ${GNU_INP}
    echo 'set title "'${NU_NAME}'"'                                                 >> ${GNU_INP}
    echo 'set key left bottom'                                                      >> ${GNU_INP} 
    echo 'set key box lw 6'                                                         >> ${GNU_INP}
    echo 'set size ratio 0.46 1.0'                                                  >> ${GNU_INP}
    echo 'set terminal png size 3840, 2880'                                         >> ${GNU_INP}
    echo 'set terminal png font "/usr/share/fonts/liberation/LiberationSerif-Regular.ttf, 66"' >> ${GNU_INP}
    echo 'set out "'${NU_NAME}'_xs_only.png"'                                       >> ${GNU_INP}
    echo 'plot   "'${FILE}'" using '${ENE}':'${XS_REF}'  w l lw 6 title "   NJOY"'  >> ${GNU_INP}
    echo 'set out "'${NU_NAME}'_xs_only.png"'                                       >> ${GNU_INP}
    echo 'replot "'${FILE}'" using '${ENE}':'${XS_COMP}' w l lw 6 title "   FRENDY"'>> ${GNU_INP}
    echo 'set out "'${NU_NAME}'_xs.png"'                                            >> ${GNU_INP}
    echo 'replot "'${FILE}'" using '${ENE}':($'${XS_DIF}'*100.0) w l lw 6 axes x1y2 title "   Dif."' >> ${GNU_INP}

    gnuplot < ${GNU_INP}

    if( -s ${NU_NAME}_xs_only.png ) then
      mv ${NU_NAME}_xs_only.png ${PWD}/ace_plot_only/
      mv ${NU_NAME}_xs.png      ${PWD}/ace_plot/
    else
      rm -rf ${NU_NAME}_xs_only.png
      rm -rf ${NU_NAME}_xs.png
    endif

    rm -rf ${GNU_INP}
  endif
end

