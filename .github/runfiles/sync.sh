#!/bin/bash

git config --global user.email "Shankarsharma@gmail.com"
git config --global user.name "Shankar Sharma"
len=$(yq "length" manifest.yml)
path="/home/runner/work/"
echo $path
echo $len
for ((i=0; i<${len}; i++))
do
  echo "For test"
  cd "$3"/.github/runfiles
  #Collecting Values from Yaml file
  repo=$(yq ".[$i].Repository" manifest.yml)
  name=$(yq ".[$i].Name" manifest.yml)
  branch=$(yq ".[$i].Branch" manifest.yml)
  Sync_dir=$(yq ".[$i].Sync_dir" manifest.yml)
 # echo "$repo"
  cd "$path"
 # pwd
 # ls
  git clone -b $branch https://Shankarsharm:"$1"@"$repo"
 # ls 
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
    cd "$3"
   # ls 
   # pwd
     rm -f .lfsconfig .gitignore .gitattributes
   # ls
    cp -r `ls -A | grep -v ".git"` "$path"/"$name"/"$2"/
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
      cd "$3"
     # pwd
      cp -R "$file" "$path"/"$name"/"$2"/
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
    cd "$path"/"$name"/
     # ls 
     # pwd
    git add .
    git status
    git commit -m "Added files"
    git push https://Shankarsharm:"$1"@"$repo"
    echo "Push Successful!!"
  fi
done
cd $3
ls -a
pwd
commit_id=$(git log | head -n 1 | cut -d " " -f2)
echo commit_id
cd $3/.github/runfiles/
sed -i '/lastbuild:/c \ \ lastbuild: '$commit_id'' manifest.yml
git add manifest.yml
git commit -m "updated manifest file"
git push https://Shankarsharm:"$1"@github.com/Shankarsharm/FNV4_SWC_Test.git

