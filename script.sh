#!/usr/bin/env bash

x=`lsof -i tcp:4000 -t| awk '{print $1}'`
echo $x

if [[ -n $x ]];
then
  kill -9 $x;
  echo "OK";
fi
