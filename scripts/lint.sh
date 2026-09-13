#!/usr/bin/env bash

cobc -I ../src/copy \
  -fsyntax-only \
  ../src/*.cbl \
  -Wall \
  -Wextra \
  -Wadditional \
  -Wno-terminator
