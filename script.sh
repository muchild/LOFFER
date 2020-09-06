#!/usr/bin/env bash

x=$(lsof -i tcp:4000 -t | awk '{print $1}')
echo $x

if [[ -n $x ]]; then
  kill -9 $x
  echo "OK"
fi

nohup /usr/local/bin/jekyll serve --detach --trace --incremental >/Users/guoying/logs/jekll.log 2>&1 &
echo "run ok"

open http://127.0.0.1:4000/loffer/
echo "open url ok"
