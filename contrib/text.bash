#!/usr/bin/env bash

# Text Manipulation
function capitalize() { sed -e 's/^\(.\{1\}\)/\U\1/gi'; }
function upper()      { awk '{print toupper($0)}'; }
function lower()      { awk '{print tolower($0)}'; }

# Color Effects
function color()  { IFS= read -r text <&0; echo -e $2 "\e[$1m$text\e[0m"; }
function black()  { color "0;30" $1; }
function red()    { color "0;31" $1; }
function green()  { color "0;32" $1; }
function yellow() { color "0;33" $1; }
function blue()   { color "0;34" $1; }
function purple() { color "0;35" $1; }
function cyan()   { color "0;36" $1; }
function white()  { color "0;37" $1; }
