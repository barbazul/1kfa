#! /bin/bash


RESULTS=$(for i in $(ls *part)
do
  echo $i | sed 's/\(.*\)\..*\.part/\1/'
done | uniq)

for x in $RESULTS
do
  NEWFILE="$x"
  if [ -e $x ]; then
    NEWFILE="$x.new"
  fi
  echo "making $NEWFILE"
  cat $x.*.part > $NEWFILE
done
