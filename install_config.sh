#!/bin/bash
here=$(cd `dirname $0` && pwd)
copy_config() {
  if ! [[ "$1" =~ .*".swp"$ ]] &&
     ! [[ "$1" =~ .*"grab_config.sh"$ ]] &&
     ! [[ "$1" =~ .*"remove_config.sh"$ ]] &&
     ! [[ "$1" =~ .*"install_config.sh"$ ]]; then
    backup="$1"
    echo "$here"
    if [[ "$backup" =~ ^"$here".* ]]; then
      config="$HOME/${backup#"$here"}"
      mkdir -p "$(dirname "$here/backup/${backup#"$here"}")" &&
      mv "$config" "$here/backup/${backup#"$here"}" &&
      ln -s "$backup" "$config" &&
      echo "Succesfully copied and linked config file" ||
      (echo "Unable to copy and link file!"; exit 4)
    else
      echo "Files must be in this directory: $here, file was: $backup"
      exit 1
    fi
  fi
};
export -f copy_config;
find "$here" -type f -not -path "./.git/*" -exec bash -c 'here='$here'; copy_config "$0"' {} \;
