#!/bin/bash

#Args:
#$1: Filename

if [ $# -ne 1 ]; then
    echo "Args usage:"
    echo "  1: filename"
    exit 1
fi

for (( i=12; i<=12; i++))
	do
        ./procesar informes/ic$i/$1 1 1
        echo ""
	done
