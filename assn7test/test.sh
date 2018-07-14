#!/bin/sh

PREFIX=test
TESTS='0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19'
PROG=runme.sh
count=0

rm -rf *.class
if [ ! -f $PROG ]; then
  echo Error: $PROG is not in the current directory 
  exit 1
fi

chmod 700 $PROG

for T in $TESTS; do
  if [ -f $PREFIX.$T.in ]; then  
    echo ===========================================
    echo Test file: $PREFIX.$T.in 
    ./$PROG < $PREFIX.$T.in > $PREFIX.$T.out
    if diff -w $PREFIX.$T.out $PREFIX.$T.gold > /dev/null; then
      echo " " PASSED
      let "count = count + 1"
      rm $PREFIX.$T.out 
    else
      echo " " FAILED
    fi
  else
    echo Oops: file $PREFIX.$T.in does not exist!
  fi
done

echo =============================================
echo $count tests passed
