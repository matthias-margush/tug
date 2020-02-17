define-command mv -override -params 1.. -file-completion -docstring %{
  Move the current file
} %{
  evaluate-commands %sh{
    # Get the last arg
    for target; do :; done

    # Remove last arg from $@
    i=1; while [ $i -lt $# ]; do
      set -- "$@" "$1"
      shift
      i=$(($i+1))
    done
    shift

    if ! mv "$@" "$kak_buffile" "$target"
    then
      printf "fail Failed to move file (see *debug*)"
      exit 1
    fi

    printf '%s\n' delete-buffer
    [ -d "$target" ] && target="${target}/${kak_buffile##*/}"
    printf 'edit %s\n' "${target}"
  }
}

define-command cp -override -params 1.. -file-completion -docstring %{
  Copy the current file
} %{
  evaluate-commands %sh{
    # Get the last arg
    for target; do :; done

    # Remove last arg from $@
    i=1; while [ $i -lt $# ]; do 
      set -- "$@" "$1"
      shift
      i=$(($i+1))
    done
    shift

    if ! cp "$@" "$kak_buffile" "$target"
    then
      printf "fail Failed to copy file (see *debug*)"
    fi
  }
}

define-command mkdir -override -params .. -file-completion -docstring %{
  Make directories
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
  Change file modes or Access Control Lists
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
  Remove directory entries
} %{
  evaluate-commands %sh{
    # Get the last arg
    for target; do :; done

    if [ -e "$target" ]
    then
      rm "$@"
    else
      rm "$@" "$kak_buffile"
    fi
  }
}
