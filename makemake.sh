#! /bin/bash

if [ $# -ge 1 ]
then
	exec=$1
	echo -n "$exec : "> Makefile
	for file in `ls *.cpp` ; do
		echo -n "${file%*.cpp}.o " >> Makefile
	done # first line
	echo -n " " >> Makefile
	echo "" >> Makefile
	
	echo -ne "\tg++ -ansi -Wall -g -o $* " >> Makefile		
	for file in `ls *.cpp` ; do
		echo -n "${file%*.cpp}.o " >> Makefile
	done # first g++ statement
	echo -n " " >> Makefile
	echo "" >> Makefile
	echo "" >> Makefile

	shift
	for object in `ls *.cpp` ; do
		echo -n "${object%*.cpp}.o " >> Makefile
		echo -n ": $object " >> Makefile 
		awk -F'"' '/\.h"$/{ printf "%s ", $2 }' $object >> Makefile
		if [ $# -gt 1 ]
		then
			echo -e "\n\tg++ -ansi -Wall -g -c $* $object" >> Makefile
		else
			echo -e "\n\tg++ -ansi -Wall -g -c $object" >> Makefile
		fi #spacing correction


		echo "" >> Makefile
	done # compile output files	 


	echo -ne "clean : \n\trm -f $exec " >> Makefile  
	for file in `ls *.cpp` ; do
                echo -n "${file%*.cpp}.o  " >> Makefile
	done #clean
	echo -n " " >> Makefile
	echo "" >> Makefile
else
	echo -e Executable name required.
	echo usage: makemake.sh executable_name
fi # if there are arguments
