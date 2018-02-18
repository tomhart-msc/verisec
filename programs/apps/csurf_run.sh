#!/bin/bash

LOG=run.log
ERR=run.err

trap exit INT
trap -p

rm -f $LOG
rm -f $ERR

for f in *_ok*.prj *_bad*.prj
do
  echo "=== $f ===" | tee -a $LOG | tee -a $ERR
  time csurf -nogui -l /home/kelvin/cs/thesis/csurf/hello.stk $f >>$LOG 2>>$ERR
done
