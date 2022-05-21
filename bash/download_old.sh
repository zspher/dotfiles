#!/usr/bin/env bash

# Programming

# texlive-full          | for latex & tex files
# latexmk               | for more effecient compiling of latex files


latex="texlive-full latexmk"

Dev_Programs="$latex"

# Linux tools

# youtube-dl            | video download
# unzip                 | for zip files
# pdf2svg               | converts pdf to svg
# poppler-utils         | for pdftoppm pdf to image converter
# pandoc                | for universal text conversion
# imagemagick           | for image conversion
# zsh                   | for zsh shell
zsh="zsh-autosuggestions zsh-syntax-highlighting zsh"
tools="youtube-dl unzip pdf2svg poppler-utils pandoc imagemagick $zsh"

apt install $Dev_Programs $tools
