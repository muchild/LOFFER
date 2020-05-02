# /bin/bash
x=`lsof -i tcp:4000 -t| awk '{print $1}'| awk -F ' ' '{print $1}'`
echo $x

if [[ -n $x ]];
then
  kill -9 $x;
fi
