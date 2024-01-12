#!/bin/bash

# Prompt for the email address
read -p "Enter your email address for the SSH key: " email

# Generate the SSH key
ssh-keygen -t rsa -b 4096 -C "$email"

# Assuming the default location for the SSH key
key_path="$HOME/.ssh/id_rsa.pub"

# Copy the SSH key to clipboard
xclip -sel clip < "$key_path"

echo "Your SSH public key has been copied to your clipboard."

