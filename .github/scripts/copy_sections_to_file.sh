#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <filename> <new_filename>"
  exit 1
fi

filename="$1"
section_filename="$2"
# filename="C:/Users/rute_/OneDrive/Documentos/freitas-labs/github-action-spelling-check/content/reads/how-to-do-anything-in-typescript-with-type-guards.md"
# section_filename="section_content_to_be_checked.txt"

if [ ! -f "$filename" ]; then
  echo "File not found: $filename"
  exit 1
fi

# Initialize variables to keep track of whether we're inside a section
inside_section=false
section_content=""

while IFS= read -r line; do
# Trim leading and trailing whitespace from the line
  trimmed_line=$(echo "$line" | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')

  if [ "$trimmed_line" = '---' ]; then
    if [ "$inside_section" = false ]; then
      # We've entered a new section
      inside_section=true
    else
      # We've reached the end of the section
      #inside_section=false
      echo -e "$section_content" > "$section_filename"
      echo "Saved section to $section_filename"
    fi
  elif [ "$inside_section" = true ]; then
    # Append the line to the section content
    section_content="$section_content$line\n"
  fi
done < "$filename"