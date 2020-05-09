# Linux config files

This is just a bunch of dot config files I use on my Linux boxes.
If some particular configuration grows too big I'll split it into
separate repository.

## Installation

In order to install follow these steps:

  * `git clone https://github.com/Th30n/dotfiles.git dotfiles`
  * `cd dotfiles` - change directory to repository root
  * `./link-em-up` - **delete** and replace your configuration
    with those from the repository

You will probably want to edit gitconfig and zshrc to suit your environment
but this setup **does not try** to be cross compatible for other users.

NOTE: `bin` directory is never linked.

## Updating

Just do a `git pull` inside repository. New modifications can easily
be reverted by `git checkout` on an old commit.
