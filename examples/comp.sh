#!/bin/bash
gcc -fPIC -g -c -Wall sample.c
gcc -shared -Wl,-soname,libsample.so.1 \
    -o libsample.so.1.0.1 sample.o 
