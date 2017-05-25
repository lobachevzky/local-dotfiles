#!/bin/bash -ue

cd $HOME

base_dir="$HOME/local-dotfiles"

files=$(find $base_dir -maxdepth 1 -type f -not -name '*.sh')

for file in $files
do
 ln -f -s $file $HOME/.$(basename $file)
 echo "ln -fs $file $HOME/.$(basename $file)"
done

dirs="$base_dir/git"

for dir in $dirs 
do
  ln -s -f $dir $HOME/.$(basename $dir)
  echo "ln -sf $dir $HOME/.$(basename $dir)"
done
