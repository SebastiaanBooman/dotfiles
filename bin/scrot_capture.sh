#!/bin/bash

# Script to create a screenshot with variable with using scrot

# Create output dir if not exist
outputDir="$HOME/Pictures/ScrotSnippets"
dateFormatted=$(date "+%y%m%d%H%M%S").png

mkdir -p $outputDir

sleep 0.2
scrot -F "$outputDir/$dateFormatted" -s -f
