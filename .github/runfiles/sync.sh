#!/bin/bash

git config --global user.email "Shankarsharma@gmail.com"
git config --global user.name "Shankar Sharma"
cd /actions/
ls
pwd
len=$(yq "length" /actions/manifest.yml)
#path="/github/workspace/"
#echo $path
echo $len
git clone -b Jenkins https://Shankarsharm:"$1"@github.com/Shankarsharm/FNV4_SWC_Test.git
ls 
pwd
for ((i=0; i<${len}; i++))
do
  echo "For test"
  cd /actions/
  #Collecting Values from Yaml file
  repo=$(yq ".[$i].Repository" /actions/manifest.yml)
  name=$(yq ".[$i].Name" /actions/manifest.yml)
  branch=$(yq ".[$i].Branch" /actions/manifest.yml)
  Sync_dir=$(yq ".[$i].Sync_dir" /actions/manifest.yml)
 # echo "$repo"
 # cd "$path"
  pwd
  ls
  
  git clone -b $branch https://Shankarsharm:"$1"@"$repo"
  ls 
  cd $name
  rm -rf $2
 # ls
  if [[ ! -d "$2" ]]
  then
      mkdir "$2"
  else
    echo "Directory already present"
  fi
  
  a=${Sync_dir,,}
  echo $a
  if [[ $a == "all" ]]
  then
    echo "yes copy everything"
    cd "$path"
   # ls 
   # pwd
     rm -f .lfsconfig .gitignore .gitattributes
   # ls
    cp -r `ls -A | grep -v ".git"` /actions/"$name"/"$2"/
    echo $?
    cd "$path"/"$name"/
    git add .
    git commit -m "Has added files"
    git push https://Shankarsharm:"$1"@"$repo"
  else
    echo "Need to copy specific Directories"
    dir=$(echo $Sync_dir | tr -cd , | wc -c)
    for ((j=1; j<=${dir}+1; j++))
    do
      file=$(echo $Sync_dir | cut -d "," -f"$j")
      echo "$file"
      cd "$path"
     # pwd
      cp -R "$file" /actions/"$name"/"$2"/
      echo $?
     # ls
     # pwd
     # cd "$path"/"$name"/"$2"/
     # ls
     # pwd
     # cd $file
     # cat Readme.md
     # ls
      echo "Copied specific Directories"
    done
    cd /actions/"$path"/"$name"/
     # ls 
     # pwd
    git add .
    git status
    git commit -m "Added files"
    git push https://Shankarsharm:"$1"@"$repo"
    echo "Push Successful!!"
  fi
done
