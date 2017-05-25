#!/bin/bash
#
  project=${PWD##*/}
##
  if [[ $1 = "build" ]]; then
    docker build -t ${project} .
  elif [[ $1 = "push" ]]; then
    dex push ${project}
    exit
  fi
  docker run -it --rm --label type=open \
    ${project} /bin/bash
##

