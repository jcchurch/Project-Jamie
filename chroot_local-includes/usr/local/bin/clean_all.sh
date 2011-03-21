#!/bin/sh

rm -f core.*
rm -f john_rec.*
rm -f john_log.*

cat john.pot.*|sort|uniq > john_pot_tmp
rm -f john.pot.*
for id in 0 1 2 3 4 5 6 7; do
	cp john_pot_tmp john.pot.$id
done
rm -f john_pot_tmp
