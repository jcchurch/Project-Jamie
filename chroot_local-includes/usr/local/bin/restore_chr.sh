#!/bin/sh

for id in 0 1 2 3 4 5 6 7; do
	cp chr/all.chr all.chr.$id
	cp chr/digits.chr digits.chr.$id
	cp chr/alpha.chr alpha.chr.$id
	done
