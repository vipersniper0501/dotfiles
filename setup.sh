#!/bin/bash

home_dir="$HOME"

files=$(find . -type f \( ! -name "Readme.adoc" -a ! -name "setup.sh" -a ! -path "./.git/*" -a ! -name ".gitignore" \)  | sed 's|^\./||')

mkdir $HOME/.config
mkdir $HOME/.config/nvim
mkdir $HOME/.config/nvim/lua
mkdir $HOME/.config/nvim/lua/plugins
mkdir $HOME/.config/foot

for file in $files; do

    target_path="$home_dir/$file"

    ln -P -f "$PWD/$file" "$target_path"

    echo "Created hard symlink '$target_path' pointing to '$PWD/$file'"
done

# Now do for root
sudo mkdir /root/.config
sudo mkdir /root/.config/nvim
sudo mkdir /root/.config/nvim/lua
sudo mkdir /root/.config/nvim/lua/plugins
sudo mkdir /root/.config/foot

for file in $files; do

    target_path="/root/$file"

    sudo ln -P -f "$PWD/$file" "$target_path"

    echo "Created hard symlink '$target_path' pointing to '$PWD/$file'"
done
echo "Dotfile setup complete."
