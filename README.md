![Tug](images/tug.png)


# Shell Commands For The [Kakoune](https://kakoune.org) Editor

#### :mv
    Move the current file and rename the buffer.

       mv [flags] target_file
       mv [flags] target_directory

    All flags are forwarded to `mv`.
    Synchronizes buffers with file system changes.


#### :cp
    Copy the current file.

       cp [flags] target_file
       cp [flags] target_directory

    All flags are forwarded to `cp`.

#### :mkdir
    Make directories.

       mkdir [flags]
       mkdir [flags] directory_name ...

    With no arguments, create directories for the current buffer.
    All arguments are forwarded to `mkdir`.

#### :chmod
    Change file modes or Access Control Lists.

       chmod [flags] mode
       chmod [flags] mode file ...

    If no file is provided, modifies the current file.
    All arguments are forwarded to `chmod`.

#### :rm
  Remove directory entries.

     rm [flags]
     rm [flags] file ...

    If no file is provided, removes the current file and buffer.
    All arguments are forwarded to `chmod`.


## [Connect.kak](https://github.com/alexherbo2/connect.kak) Integration

- `bin/tmv`: Move files, renaming associated buffers in the connected editor

(To install, add `tmv` to your PATH.)


## Installation

    plug "matthias-margush/tug"

([people-clipart png from pngtree.com](https://pngtree.com/so/people-clipart))

