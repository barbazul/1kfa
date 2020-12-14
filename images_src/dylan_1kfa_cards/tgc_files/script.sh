#! /bin/bash

for i in `ls *png`
do
  ./mask.sh $i
done
