#!/bin/bash

len=$(yq "length" manifest.yml)

for ((i=0; i<${len}; i++))
do
  #Collecting Values from Yaml file
  repo=$(yq ".[$i].Repository" manifest.yml)
  name=$(yq ".[$i].Name" manifest.yml)
  branch=$(yq ".[$i].Branch" manifest.yml)
  Sync_dir=$(yq ".[$i].Sync_dir" manifest.yml)
  echo "$repo"
  git clone -b "$branch" "https://Shankarsharm:$1@$repo"
  if [[ $Sync_dir == "all" ]]
  then
    echo "yes copy everything"
    echo "$name"
    cd "$2"
    ls 
    pwd
    rm -rf .git
    cp -R . "$name"/"$2"
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
      cd "$2"
      ls 
      pwd
      cp "$file" "$name"/"$2"
    done
      git add .
      git commit -m "Added files"
      git push https://Shankarsharm:"$1"@"$repo"
  fi
done
