#!/bin/bash 

var=$(git log --stat | grep "|" | awk '{print $3}')
#echo $var
arr=($var)
stuff=($1) 
#echo $commit_changes
len=${#stuff[@]} 
#echo $len
zero=0
val=$1
if [ $len -eq $zero ]
then
    val=10
    echo Default
fi

echo Commit with less than $val line changes.
echo "**************"

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
            #echo ${commit_changes[i]}
            #echo "error: Not a number" >&2;
            continue
        fi
        temp=$(($temp + ${commit_changes[v]}))
    done
    #echo $temp
    commit_changes=$temp
    zero=0  
    if [ $commit_changes -eq $zero ]
    then
      continue  
    fi

    commit_final+=(${commit[i]})
    change_final+=($commit_changes) 
    #echo -----------------
    #echo ${commit[i]}    
    #echo $commit_changes
done

for i in "${!commit_final[@]}"; do
    echo ${commit_final[i]}
    echo ${change_final[i]}
    continue

done


for i in "${!change_final[@]}"; do
    #printf '${arr[%s]}=%s\n' "$i" "${arr[i]}"
    if [ ${change_final[i]} -lt $val ]
        then
            index+=($i)
            #echo ${arr[i]}
    fi    
done


for i in "${!index[@]}"; do
    #printf '${arr[%s]}=%s\n' "$i" "${arr[i]}"
    ind=${index[i]} 
    #echo Iter: $i
    #echo Index: $ind
    #echo ${!commit_final[@]}
    #echo ${!change_final[@]}
    echo commit hash_val :${commit_final[ind]}
    echo Lines changed  :${change_final[ind]} 
    echo "**************"
    
done