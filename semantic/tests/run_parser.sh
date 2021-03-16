#!/bin/bash

cd ../../parser
make 
cd ../semantic/tests

LIKE_LIB=../../lib/pt

PARBLK="ptc -o2 -t2 -L $LIKE_LIB block.pt"
PARVAR="ptc -o2 -t2 -L $LIKE_LIB variables.pt"
PARPKG="ptc -o2 -t2 -L $LIKE_LIB pkg.pt"

blk_trace(){ ssltrace "$PARBLK" $LIKE_LIB/parser.def -e; }
var_trace(){ ssltrace "$PARVAR" $LIKE_LIB/parser.def -e; }
pkg_trace(){ ssltrace "$PARPKG" $LIKE_LIB/parser.def -e; }

blk(){ ptc -o2 -L $LIKE_LIB block.pt; }
var(){ ptc -o2 -L $LIKE_LIB variables.pt; }
var(){ ptc -o2 -L $LIKE_LIB pkg.pt; }

if [ $# -ne 0 ]; then
    if [[ "$1" == *"b"* ]];then blk_trace; fi
    if [[ "$1" == *"v"* ]];then var_trace; fi
    if [[ "$1" == *"p"* ]];then pkg_trace; fi
else
    echo "-- parse block ---"
    blk
    echo "-- parse variables ---"
    var
    echo "-- parse pkg ---"
    pkg
fi
