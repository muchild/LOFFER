#!/usr/bin/env bash

x=`lsof -i tcp:4000 -t| awk '{print $1}'`
echo $x

if [[ -n $x ]];
then
  kill -9 $x;
  echo "OK";
  /usr/local/bin/jekyll serve --detach --trace --incremental
  echo "RUN OK"
fi
