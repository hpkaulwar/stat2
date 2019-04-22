#!/bin/bash 

var=$(git log --stat | grep "|" | awk '{print $3}')
#echo $var
arr=($var)
val=10
index=()

for i in "${!arr[@]}"; do
    printf '${arr[%s]}=%s\n' "$i" "${arr[i]}"
    if [ ${arr[i]} -lt $val ]
        then
            index+=($i)
            echo ${arr[i]}
    fi    
done
commit=($(git log --stat | grep "commit" | awk '{print $2}'))
for i in "${!index[@]}"; do
    #printf '${arr[%s]}=%s\n' "$i" "${arr[i]}"
    ind=${index[i]} 
    #echo $ind
    echo ${commit[ind]}
    echo ${arr[i]}
    echo "**************"
    
done