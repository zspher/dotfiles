#! /usr/bin/env bash

# * bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Functions

binary_to_octal() {
  local arr=()
  readarray -td ' ' arr < <(printf '%s ' "$1")

  local out=()
  for elem in "${arr[@]}"; do
    out+=("$(bc <<<"ibase=2; obase=8; $elem")")
  done
  echo "${out[@]}"
}

octal_to_ascii() {
  local arr=()
  readarray -td ' ' arr < <(printf '%s ' "$1")

  local out=()
  for elem in "${arr[@]}"; do
    out+=("$(printf '%b' "\\$elem")")
  done
  echo "${out[@]}"
}

hex_to_octal() {
  local arr=()
  readarray -td ' ' arr < <(printf '%s ' "$1")

  local out=()
  for elem in "${arr[@]}"; do
    out+=("$(printf '%o' "0x$elem")")
  done
  echo "${out[@]}"
}

decimal_to_ascii() {
  local arr=()
  readarray -td ' ' arr < <(printf '%s ' "$1")

  local out=()
  for elem in "${arr[@]}"; do
    out+=("$(printf '%b' "\x$(printf '%x' "$elem")" )")
  done
  echo "${out[@]}"
}

case "${1:-''}" in
'b2o')
  binary_to_octal "$2"
  ;;
'o2a')
  octal_to_ascii "$2"
  ;;
'b2a')
  octal_to_ascii "$(binary_to_octal "$2")"
  ;;
'h2o')
  hex_to_octal "$2"
  ;;
'h2a')
  octal_to_ascii "$(hex_to_octal "$2")"
  ;;
'd2a')
  decimal_to_ascii "$2"
  ;;
*)
  echo "unknown"
  ;;
esac
