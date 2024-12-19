#!/bin/bash

# Function to check for non-free packages in Arch Linux
check_arch() {
    output_file="non_free_packages.txt"
    > "$output_file"
    installed_packages=$(pacman -Qq)

    for package in $installed_packages; do
        if pacman -Qi "$package" | grep -q "License.*:.*(custom|non-free|proprietary)"; then
            echo "$package" >> "$output_file"
        fi
    done

    if [ -s "$output_file" ]; then
        echo "Non-free software found in Arch Linux:"
        cat "$output_file"
    else
        echo "No non-free software found in Arch Linux."
    fi
}

# Function to check for non-free packages in Debian
check_debian() {
    output_file="non_free_packages.txt"
    > "$output_file"
    installed_packages=$(dpkg --get-selections | awk '{print $1}')

    for package in $installed_packages; do
        if apt-cache show "$package" | grep -q "License: .*non-free"; then
            echo "$package" >> "$output_file"
        fi
    done

    if [ -s "$output_file" ]; then
        echo "Non-free software found in Debian:"
        cat "$output_file"
    else
        echo "No non-free software found in Debian."
    fi
}

# Function to check for non-free packages in Red Hat/Fedora
check_redhat() {
    output_file="non_free_packages.txt"
    > "$output_file"
    installed_packages=$(rpm -qa)

    for package in $installed_packages; do
        if rpm -qi "$package" | grep -q "License: .*non-free"; then
            echo "$package" >> "$output_file"
        fi
    done

    if [ -s "$output_file" ]; then
        echo "Non-free software found in Red Hat/Fedora:"
        cat "$output_file"
    else
        echo "No non-free software found in Red Hat/Fedora."
    fi
}

# Function to check for non-free packages in Mandriva
check_mandriva() {
    output_file="non_free_packages.txt"
    > "$output_file"
    installed_packages=$(rpm -qa)

    for package in $installed_packages; do
        if rpm -qi "$package" | grep -q "License: .*non-free"; then
            echo "$package" >> "$output_file"
        fi
    done

    if [ -s "$output_file" ]; then
        echo "Non-free software found in Mandriva:"
        cat "$output_file"
    else
        echo "No non-free software found in Mandriva."
    fi
}

# Function to check for non-free packages in Slackware
check_slackware() {
    output_file="non_free_packages.txt"
    > "$output_file"
    installed_packages=$(ls /var/log/packages)

    for package in $installed_packages; do
        if grep -q "License: .*non-free" "/var/log/packages/$package"; then
            echo "$package" >> "$output_file"
        fi
    done

    if [ -s "$output_file" ]; then
        echo "Non-free software found in Slackware:"
        cat "$output_file"
    else
        echo "No non-free software found in Slackware."
    fi
}

# Function to check for non-free packages in Gentoo
check_gentoo() {
    output_file="non_free_packages.txt"
    > "$output_file"
    installed_packages=$(equery list '*' | awk '{print $2}')

    for package in $installed_packages; do
        if equery l -p "$package" | grep -q "non-free"; then
            echo "$package" >> "$output_file"
        fi
    done

    if [ -s "$output_file" ]; then
        echo "Non-free software found in Gentoo:"
        cat "$output_file"
    else
        echo "No non-free software found in Gentoo."
    fi
}

# Main function to select the distribution
main() {
    echo "Select your distribution:"
    echo "1) Arch Linux"
    echo "2) Debian/Ubuntu"
    echo "3) Red Hat/Fedora"
    echo "4) Mandriva"
    echo "5) Slackware"
    echo "6) Gentoo"
    read -p "Enter the number of your choice: " choice

    case $choice in
        1)
            check_arch
            ;;
        2)
            check_debian
            ;;
        3)
            check_redhat
            ;;
        4)
            check_mandriva
            ;;
        5)
            check_slackware
            ;;
        6)
            check_gentoo
            ;;
        *)
            echo "Invalid choice. Please select 1, 2, 3, 4, 5, or 6."
            ;;
    esac
}

# Run the main function
main

