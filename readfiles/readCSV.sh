#!/bin/bash

INPUT=csvValue.csv
OLDIFS=$IFS

[ ! -f $INPUT ] &while IFS=, read -r col1
do
	echo "${col1}"
done < $INPUT
IFS=$OLDIFS

