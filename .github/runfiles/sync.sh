#!/bin/bash

len=$(yq "length" manifest.yml)

for ((i=0; i<${len}; i++))
do
  cd "$3"/.github/runfiles
  #Collecting Values from Yaml file
  repo=$(yq ".[$i].Repository" manifest.yml)
  name=$(yq ".[$i].Name" manifest.yml)
  branch=$(yq ".[$i].Branch" manifest.yml)
  Sync_dir=$(yq ".[$i].Sync_dir" manifest.yml)
  echo "$repo"
  cd "$3"/..
  pwd
  ls
  git clone -b $branch https://Shankarsharm:"$1"@"$repo"
  cd "$3"/../"$2"
  if [[ ! -d "$name"/"$2" ]]
  then
      mkdir "$name"/"$2"
  fi
  if [[ $Sync_dir == "all" ]]
  then
    echo "yes copy everything"
    echo "$name"
    ls 
    pwd
    rm -rf .git
    cp -R . "$name"/"$2"
    echo $?
    cd "$3"/../"$name"
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
      ls 
      pwd
      cp -R "$file" "$3"/../"$name"/"$2"
      echo $?
      echo "Copied specific Directories"
    done
      cd "$3"/../"$name"
      ls 
      pwd
      git status
      git add .
      git status
      git commit -m "Added files"
      git push https://Shankarsharm:"$1"@"$repo"
      echo "Push Successful!!"
  fi
done
