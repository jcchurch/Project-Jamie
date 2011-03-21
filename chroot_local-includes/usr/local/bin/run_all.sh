#!/bin/sh

PROCS=$1

rm -f core.*
mpirun -np $PROCS ./john -incremental crack
