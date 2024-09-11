#!/bin/bash
#Get distance between two atoms over course of a simulation

index1=$1
index2=$2

#create a file to use as input for the index file
	echo "a ${index1} | a ${index2}" >> tempIndexINPUT
	echo "q" >> tempIndexINPUT

#make new index file
	gmx make_ndx -f RNAProteinOnly.gro -o temp.ndx < tempIndexINPUT

#gromacs command for measuring dist
	 gmx distance -f fixed.xtc -s RNAProteinOnly.gro -n temp.ndx -oall Dist_i${index1}_i${index2}.xvg -tu ns -select 13


#remove temp index file
	rm temp.ndx
	rm tempIndexINPUT
