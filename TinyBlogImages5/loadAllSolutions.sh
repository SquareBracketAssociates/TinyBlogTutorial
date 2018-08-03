#!/usr/bin/env bash

for F in loadSolutionForWeek[0-9]\.sh; do 
	echo "$F"
	./$F
done