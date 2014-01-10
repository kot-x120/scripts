#!/bin/bash

#mkdir 01-1920x1080
#find -name '*1920x1080*' | while read picname
#do
#	mv $picname ./01-1920x1080;
#done

#mkdir 02-other-res
#find -name '*[0-9]x[0-9]*' | grep -v '*1920x1080*' | while read picname 
#do
#	mv $picname ./02-other-res
#done

#mkdir 03-to-sort
find -name 'wall*' | grep '*png' | while read picname
do
	mv $picname ./03-to-sort
done

#mkdir 04-to-deep-sort
#find . -type f -name '*.jpg' | grep -v *1920x1080* | grep -v wall* | grep -v './02-other-res' | while read picname 
#do
#	mv $picname ./04-to-deep-sort
#done

find . -type f -name '*.png' | while read picname 
do
	mv $picname ./04-to-deep-sort
done