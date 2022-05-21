#! /usr/bin/env bash

base=( base base-devel )

# dev stuff

### ------------------------------ c/c++ ---------------------------------------- ###
# cmake                         | cross-platform buildsystem generator
# ninja                         | small build system closest in spirit to Make
# gcc                           | gnu c/c++ compiler
# gdb                           | c/c++ debugger
# mingw-w64-gcc                 | c/c++ compiler for windows
cpp=( cmake ninja gcc mingw-w64-gcc gdb )


### ------------------------------ python --------------------------------------- ###
# python                        | python cmd interpreter
# python-pip                    | python package manager
# python-virtualenv             | virtual python environment builder
# pyenv                         | Easily switch between multiple versions of Python
python=( python python-pip python-virtualenv pyenv )

### ------------------------------ tex ------------------------------------------ ###
# texlive-most                  | latex texlive packages
# texlive-most-doc              | aur texlive documentation
# tllocalmgr-git                | aur texlive package manager
# biber                         | bibtex engine replacement
# aur=( texlive-most-doc tllocalmgr-git)
tex=( texlive-most biber )


### ------------------------------ javascript ----------------------------------- ###
# nodejs                        | javascript interpreter
# npm                           | nodejs package manager
javascript=( nodejs npm )


### ------------------------------ java ----------------------------------------- ###
# jdk-openjdk                   | java development kit
java=( jdk-openjdk )


### ------------------------------ rust ----------------------------------------- ###
# rustup                        | Rust toolchain installer
rust=( rustup )


### ------------------------------ tools ---------------------------------------- ###
# wget                          | file web retrival
# curl                          | URL retrieval utility and library
# git                           | version control system
# zsh                           | zsh shell
# vim                           | improved version of the vi text editor
# reflector                     | retrieve and filter the latest Pacman mirror list
# openssh                       | communication with ssh protocol
# zip                           | compress to zip archive
# unzip                         | extract zip archive
# fzf                           | command-line fuzzy finder
# tldr                          | small summary of program functions
# man-db                        | arch manuals 
# man-pages                     | unix and linux manuals
tools=( git vim wget curl reflector zsh openssh zip unzip fzf tldr man-db man-pages )


### ------------------------------ gui tools ------------------------------------ ###
# dbeaver                       | Free universal SQL Client
# perl-tk                      | gui for perl 
gui=( dbeaver perl-tk )

sudo pacman -S --needed "${base[@]}" "${cpp[@]}" "${python[@]}" "${javascript[@]}" "${java[@]}" "${rust[@]}" "${tools[@]}" "${gui[@]}" "${tex[@]}"


### ------------------------------ extern ----------------------------------------###
# dotnet-host-bin               | .NET drivers
# dotnet-runtime-bin            | .NET Core runtime
# dotnet-sdk-bin                | .NET Core SDK
# daemonize                     | Run a program as a Unix daemon
# downgrade                     | downgrade packages to a version in your cache
# powershell                    | powershell shell
# zinit-git                     | fast Zsh plugin manager
# aur=( dotnet-host-bin dotnet-runtime-bin dotnet-sdk-bin daemonize downgrade powershell zinit-git )

# sudo yay -S --needed "${aur[@]}"
