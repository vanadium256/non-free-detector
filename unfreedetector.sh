#!/bin/bash

# File to store the list of non-free software
output_file="non_free_packages.txt"

# Clear the file before running
> "$output_file"

# Get the list of installed packages
installed_packages=$(pacman -Qq)

# Check each package for non-free status
for package in $installed_packages; do
    # Check if the package is non-free
    if pacman -Qi "$package" | grep -q "License.*:.*(custom|non-free|proprietary)"; then
        echo "$package" >> "$output_file"
    fi
done

# Output the results
if [ -s "$output_file" ]; then
    echo "Non-free software found:"
    cat "$output_file"
else
    echo "No non-free software found."
fi

