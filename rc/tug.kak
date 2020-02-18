define-command mv -override -params 1.. -file-completion -docstring %{
  Move the current file and rename the buffer.

     mv [flags] target_file
     mv [flags] target_directory

  All flags are forwarded to `mv`.
  Synchronizes buffers with file system changes.
} %{
  write
  evaluate-commands %sh{
    # Get the last arg
    for target; do :; done

    # Remove last arg from $@
    i=1; while [ $i -lt $# ]; do
      set -- "$@" "$1"
      shift
      i=$((i+1))
    done
    shift

    if ! mv "$@" "$kak_buffile" "$target"
    then
      echo "fail Failed to move file (see *debug*)"
      exit 1
    fi

    echo delete-buffer
    [ -d "$target" ] && target="${target}/${kak_buffile##*/}"
    printf 'edit %s\n' "${target}"
  }
}

define-command cp -override -params 1.. -file-completion -docstring %{
  Copy the current file.

     cp [flags] target_file
     cp [flags] target_directory

  All flags are forwarded to `cp`.
} %{
  evaluate-commands %sh{
    # Get the last arg
    for target; do :; done

    # Remove last arg from $@
    i=1; while [ $i -lt $# ]; do 
      set -- "$@" "$1"
      shift
      i=$((i+1))
    done
    shift

    if ! cp "$@" "$kak_buffile" "$target"
    then
      echo "fail Failed to copy file (see *debug*)"
    fi
  }
}

define-command mkdir -override -params .. -file-completion -docstring %{
  Make directories.

     mkdir [flags]
     mkdir [flags] directory_name ...

  With no arguments, create directories for the current buffer.
  All arguments are forwarded to `mkdir`.
} %{
  evaluate-commands %sh{
    if [ $# -eq 0 ]
    then
      mkdir -p $(dirname "$kak_buffile")
    else
      mkdir "$@"
    fi
  }
}

define-command chmod -override -params 1.. -file-completion -docstring %{
  Change file modes or Access Control Lists.

     chmod [flags] mode
     chmod [flags] mode file ...

  If no file is provided, modifies the current file.
  All arguments are forwarded to `chmod`.
} %{
  evaluate-commands %sh{
    # Get the last arg
    for target; do :; done

    if [ -e "$target" ]
    then
      chmod "$@"
    else
      chmod "$@" "$kak_buffile"
    fi
  }
}

define-command rm -override -params .. -file-completion -docstring %{
  Remove directory entries.

     rm [flags]
     rm [flags] file ...

  If no file is provided, removes the current file and buffer.
  All arguments are forwarded to `rm`
} %{
  write
  evaluate-commands %sh{
    # Get the last arg
    for target; do :; done

    if [ -e "$target" ]
    then
      rm "$@"
    else
      echo delete-buffer
      rm "$@" "$kak_buffile"
    fi
  }
}
