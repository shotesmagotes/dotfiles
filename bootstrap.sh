#!/bin/bash

# bootstraps a new system with the configurations
# this is separate from the install.sh script
# which will install applications given a new 
# machine.

read -r -n 1 -p "Proceed with bootstrap? [y|N] " response

if [[ "$response" =~ (n|N) || -z "$response" ]];
then
    exit 1
fi
echo ""

source="$PWD"
target="$(echo $HOME)"

files="$(find . -name '.*' | grep -vFxf blacklist)"
for file in $files; do
    source_file=$(basename "$file")
    target_file="$source_file"
    if [ ! -L "$target/$target_file" ]; 
    then
        echo "Linking $source/$source_file to $target/$target_file"
        ln -s "$source/$source_file" "$target/$target_file"
    else
        echo "Could not copy. $source/$source_file exists."
    fi
done

