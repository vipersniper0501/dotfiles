#!/bin/bash

home_dir="$HOME"

files=$(find . -type f \( ! -name "Readme.adoc" -a ! -name "setup.sh" -a ! -path "./.git/*" -a ! -name ".gitignore" \)  | sed 's|^\./||')

mkdir $HOME/.config
mkdir $HOME/.config/nvim

for file in $files; do

    target_path="$home_dir/$file"

    ln -f "$PWD/$file" "$target_path"

    echo "Created hard symlink '$target_path' pointing to '$PWD/$file'"
done

echo "Dotfile setup complete."
