#!/usr/bin/env bash

for i in $(seq 2 9);
do
	echo "./loadSolutionForChapter.sh $i"
	./loadSolutionForChapter.sh $i
done
