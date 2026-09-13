#!/usr/bin/env bash

cobc -I ../src/copy \
  -x ../src/main.cbl \
  -o ../bin/CobCash \
  -w -q
