#!/bin/bash

# Programming

# ----------------------------------------------------------------------
# gdb                   | c/c++ debugger
# build-essential       | essential tools for building binaries
# mingw-w64             | gcc for windows
# gcc-doc               | for gcc documentation
# libgtest-dev          | google unit test libs
# cmake                 | cmake
# ninja-build           | for cmake ninja build system
# mingw-w64-tools       | mingw tools
cpp=(gdb build-essential mingw-w64 gcc-doc cmake libgtest-dev mingw-w64-tools)

# ----------------------------------------------------------------------
# apache2               | apache
# php                   | php
# php-mysql             | php and mysql integration
# default-mysql-server  | MySQL fork
# libapache2-mod-php    | apache2 and php integration
LAMP=(apache2 php libapache2-mod-php default-mysql-server php-mysql)

# nginx                 | for the nginx server
# tor                   | for the tor browser
server=(tor nginx "${LAMP[@]}")

# ----------------------------------------------------------------------
# python3               | python
# python3-pip           | pip
# python-is-python3     | python syslink => python3
# python-dev-is-python3 | python dev stuff, includes pydoc
python=(python3 python3-pip python-is-python3 python-dev-is-python3)

# ----------------------------------------------------------------------
# nodejs                | nodejs
# npm                   | node package manager
javascript=(nodejs npm)

# ----------------------------------------------------------------------
# default-jdk           | java
java=(default-jdk default-jre)


# ----------------------------------------------------------------------
# haskell-platform      | haskell lang
haskell=(haskell-platform)

# ----------------------------------------------------------------------
# for rust-lang
if ! [ -f "$HOME"/.cargo/bin/rustc ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# ----------------------------------------------------------------------
Dev_Programs=("${cpp[@]}" "${server[@]}" "${javascript[@]}" "${python[@]}" "${java[@]}" "${racket[@]}" "${haskell[@]}")

# Linux tools

# ----------------------------------------------------------------------
# zsh                     | for zsh shell
# zsh-syntax-highlighting | for zsh syntax highlighting
# zsh-autosuggestions     | for zsh autocomplete
zsh=(zsh-autosuggestions zsh-syntax-highlighting zsh)

# locate                  | locate command (from updatedb)
# kali-tools-crypto-stego | cryptography
# ffmpeg                  | video encoding
# forensics-extra         | forensics tools
# youtube-dl              | video download
# htop                    | better than top
# gnupg                   | used to encrypt data and to create digital signatures
# poppler-utils           | for pdftoppm pdf to image converter
# pandoc                  | for universal text conversion
# kali-win-kex            | for gui applications
# qpdf                    | for pdf encryption
# ocrmypdf                | for ocr of pdf files

tools=(qpdf kali-tools-crypto-stego ffmpeg forensics-extra youtube-dl htop locate gnupg poppler-utils pandoc kali-win-kex ocrmypdf "${zsh[@]}")

# for mxe
# mxe="autopoint bison flex g++-multilib gperf intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libtool-bin lzip"

apt install "${Dev_Programs[@]}" "${tools[@]}"
