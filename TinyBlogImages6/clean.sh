#!/usr/bin/env bash 

for F in *; do 
	if [[ ! $F =~ \.*\.sh ]]; then
		rm -fr $F
	fi
done