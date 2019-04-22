#!/bin/bash 

var=$(git log --stat | grep "|" | awk '{print $3}')
#echo $var
arr=($var)
val=10
index=()
commit_final=()
change_final=()
commit=($(git log --stat | grep "commit" | awk '{print $2}'))
for i in "${!commit[@]}"; do
    commit_changes=0
    com="commit"
    if [ ${commit[i]} == $com ]
    then
      continue  
    fi
    commit_changes=$(git log --stat --max-count=1 ${commit[i]} | grep "|" | awk '{print $3}')
    stuff=($commit_changes) 
    #echo $commit_changes
    len=${#stuff[@]} 
    #echo $len
    zero=0
    
    if [ $len -eq $zero ]
    then
      continue  
    fi

    commit_final+=(${commit[i]})
    change_final+=($commit_changes)     
done

for i in "${!commit_final[@]}"; do
    #echo ${commit_final[i]}
    #echo ${change_final[i]}
    continue

done


for i in "${!change_final[@]}"; do
    #printf '${arr[%s]}=%s\n' "$i" "${arr[i]}"
    if [ ${arr[i]} -lt $val ]
        then
            index+=($i)
            #echo ${arr[i]}
    fi    
done


for i in "${!index[@]}"; do
    #printf '${arr[%s]}=%s\n' "$i" "${arr[i]}"
    ind=${index[i]} 
    echo ${commit_final[ind]}
    echo ${change_final[ind]}
    #echo "**************"
    
done