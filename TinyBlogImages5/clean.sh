#!/usr/bin/env bash 

for F in *; do 
	if [[ ! $F =~ \.*\.s[ht] ]]; then
		rm -fr $F
	fi
done