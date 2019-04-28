#!/bin/bash 

var=$(git log --stat | grep "|" | awk '{print $3}')

arr=($var)
stuff=($1) 

len=${#stuff[@]} 

zero=0
val=$1
if [ $len -eq $zero ]
then
    val=10
    echo Default
fi

re='^[0-9]+$'

if ! [[ $val =~ $re ]] ; then
            echo "Please enter as command line argument an integer greater than 0."
            exit
fi
echo Commit with less than $val line changes.
echo   "**************"

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
    re='^[0-9]+$'
    temp=0
    commit_changes=($(git log --stat --max-count=1 ${commit[i]} | grep "|" | awk '{print $3}'))
    for v in "${!commit_changes[@]}"; do
        if ! [[ ${commit_changes[v]} =~ $re ]] ; then
            continue
        fi
        temp=$(($temp + ${commit_changes[v]}))
    done
    commit_changes=$temp
    zero=0  
    if [ $commit_changes -eq $zero ]
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
    if [ ${change_final[i]} -lt $val ]
        then
            index+=($i)
    fi    
done


for i in "${!index[@]}"; do
    ind=${index[i]} 
    echo commit hash_val :${commit_final[ind]}
    echo Lines changed  :${change_final[ind]} 
    echo "**************"
    
done