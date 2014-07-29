#!/usr/bin/bash
#

function test1() {
  T='gYw'   # The test text

  echo -e "\n                 40m     41m     42m     43m\
       44m     45m     46m     47m";

  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo
}

function test2() {
  FGNAMES=(' black ' '  red  ' ' green ' ' yellow' '  blue ' 'magenta' '  cyan ' ' white ')
  BGNAMES=('DFT' 'BLK' 'RED' 'GRN' 'YEL' 'BLU' 'MAG' 'CYN' 'WHT')

  echo "     ┌──────────────────────────────────────────────────────────────────────────┐"
  for b in {0..8}; do
    ((b>0)) && bg=$((b+39))

    echo -en "\033[0m ${BGNAMES[b]} │ "

    for f in {0..7}; do
      echo -en "\033[${bg}m\033[$((f+30))m ${FGNAMES[f]} "
    done

    echo -en "\033[0m │"
    echo -en "\033[0m\n\033[0m     │ "

    for f in {0..7}; do
      echo -en "\033[${bg}m\033[1;$((f+30))m ${FGNAMES[f]} "
    done

    echo -en "\033[0m │"
    echo -e "\033[0m"

    ((b<8)) &&
    echo "     ├──────────────────────────────────────────────────────────────────────────┤"
  done
  echo "     └──────────────────────────────────────────────────────────────────────────┘"
}

TEST=$1
if [ -z $TEST ]; then
  TEST=1;
fi

test$TEST
