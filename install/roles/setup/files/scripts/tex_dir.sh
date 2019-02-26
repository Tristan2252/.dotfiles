#! /bin/bash

[ ! -e *.tex ] && exit 0
[ ! -d tex ] && mkdir tex

latest=$(ls -t *.tex | head -1) 

for file in $(ls *.tex); do 
    
    filename=$(basename ${file} .tex)
    
    if [ ${file} != ${latest} ]; then
        mv ${filename}.tex tex/
    fi

    [ -e ${filename}.aux ] && rm ${filename}.aux
    [ -e ${filename}.log ] && rm ${filename}.log

done

# if no file in tex dir then remove
if [ ! "$(ls tex/)" ]; then
    rmdir tex/
fi
