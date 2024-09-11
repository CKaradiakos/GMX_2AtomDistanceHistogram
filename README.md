# GMX_2AtomDistanceHistogram
Example of scripts that were used to extract the distance between two atoms over the course of the simulation in order to determine whether or not bonds/contacts were present and create a graph using bash and awk scripts.
----------------------------------------------------------
DistExtraction.sh
Returns the distance between two atoms over the course of a simulation as a function of time using gromacs. Depending on the type of system the argument given for select on line 13 (-select 13) may need to be changed to the number of the new index group created by gmx make_ndx.

Run via. ./DistExtraction.sh [index1] [index2] 
(EX input: ./DistExtraction.sh 1230 2378)
(EX output: Dist_i1230_i2378.xvg)

----------------------------------------------------------
awkDistBINARY
Converts the distances in the xvg file from DistExtraction.sh into 0 or 1 depending on whether or not it's less or greater than/equal to a number given (second number in if statement on line 7). 0: unbonded/no contact. 1: bonded/contact.

Run via. awk -f awkDistBINARY [inputFile.xvg] > [outputFile.xvg]
(EX input: awk -f awkDistBINARY Dist_i1230_i2378.xvg > BINARY_i1230_i2378.xvg)

----------------------------------------------------------
awkDistSUM
Sums the binary graphs from the previous script to create a graph of the number of bonds/contacts over time.

Before running this script, run: "paste [file 1] [file2] > [file3]" to combine the xvg files into one.
Run via. awk -f awkDistSUM [file3] > [file4] and then use file4 as the new file 2 for paste until all binary graphs have been combined.

(EX input: paste BINARY_i1230_i2378.xvg BINARY_i1120_i2198.xvg > Sum1_Crude.xvg
           awk -f awkDistSUM Sum1_Crude.xvg > Sum1.xvg
           paste BINARY_i2240_i4318.xvg Sum1.xvg > Sum2_Crude.xvg 
           ...)
