#!/bin/bash

# Default values
LENGTH=12
MAX_LENGTH=64
LOWERCASE=true
UPPERCASE=true
NUMERIC=true
SPECIAL=true
PASSWORD_FILE="passwords.txt"
VERSION="0.0.1"

# Function to display usage
usage() {
  cat <<EOF
Password Generator Script v$VERSION

Usage: $0 [options]
  -l length         Length of the password (default: 12)
  -m max_length     Maximum allowed length for the password (default: 64)
  -n                Exclude numbers
  -u                Exclude uppercase letters
  -s                Exclude special characters
  -i                Interactive mode (prompts user for input)
  -v                Display version information
  -h                Show this help message

Examples:
  $0 -l 16 -s          Generate a 16-character password without special characters
  $0 -i                Interactive mode
EOF
  exit 0
}

# Function to validate integer input
validate_integer() {
  [[ "$1" =~ ^[0-9]+$ ]] && return 0 || return 1
}

# Function to build the character pool
build_char_pool() {
  local pool=""

  # Include selected character sets in the pool
  [[ $LOWERCASE == true ]] && pool+="$LOWER"
  [[ $UPPERCASE == true ]] && pool+="$UPPER"
  [[ $NUMERIC == true ]] && pool+="$NUM"
  [[ $SPECIAL == true ]] && pool+="$SPECIAL_CHARS"

  # Ensure at least one character set is included
  if [[ -z "$pool" ]]; then
    echo "Error: At least one character set must be included." >&2
    exit 1
  fi

  echo "$pool"
}

# Function to generate password using random selection
generate_password() {
  local char_pool
  char_pool=$(build_char_pool)

  # Generate the password by selecting random characters from the pool
  PASSWORD=""
  for ((i = 0; i < LENGTH; i++)); do
    RANDOM_CHAR="${char_pool:RANDOM%${#char_pool}:1}"
    PASSWORD+="$RANDOM_CHAR"
  done

  # Save password to file
  echo "$PASSWORD" >> "$PASSWORD_FILE"
  echo "Generated password: $PASSWORD"
  echo "Password saved to $PASSWORD_FILE"
}

# Interactive mode
interactive_mode() {
  echo "Interactive Mode: Configure your password settings."

  # Prompt for password length with validation
  while true; do
    read -p "Enter password length (default 12): " input_length
    input_length="${input_length:-12}" # Use default if input is empty

    if ! validate_integer "$input_length"; then
      echo "Error: Password length must be a positive integer."
    elif [[ "$input_length" -gt "$MAX_LENGTH" ]]; then
      echo "Error: Password length cannot exceed the maximum of $MAX_LENGTH."
    elif [[ "$input_length" -lt 1 ]]; then
      echo "Error: Password length must be at least 1."
    else
      LENGTH="$input_length"
      break
    fi
  done

  # Other prompts
  read -p "Exclude numbers? (y/n, default n): " exclude_numbers
  [[ "$exclude_numbers" =~ ^[Yy]$ ]] && NUMERIC=false

  read -p "Exclude uppercase letters? (y/n, default n): " exclude_uppercase
  [[ "$exclude_uppercase" =~ ^[Yy]$ ]] && UPPERCASE=false

  read -p "Exclude special characters? (y/n, default n): " exclude_special
  [[ "$exclude_special" =~ ^[Yy]$ ]] && SPECIAL=false

  generate_password
  exit 0
}

# Character sets
LOWER="abcdefghijklmnopqrstuvwxyz"
UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
NUM="0123456789"
SPECIAL_CHARS="!@#$%^&*()_+-=[]{}|;:,.<>?"

# Parse command-line arguments
while getopts "l:m:nusc:ivh" opt; do
  case "$opt" in
    l)
      LENGTH="$OPTARG"
      ;;
    m)
      MAX_LENGTH="$OPTARG"
      ;;
    n)
      NUMERIC=false
      ;;
    u)
      UPPERCASE=false
      ;;
    s)
      SPECIAL=false
      ;;
    i)
      interactive_mode
      ;;
    v)
      echo "Password Generator Script version $VERSION"
      exit 0
      ;;
    h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done

# Validate password length
if ! validate_integer "$LENGTH" || [[ "$LENGTH" -lt 1 ]]; then
  echo "Error: Password length must be a positive integer." >&2
  exit 1
fi

if [[ "$LENGTH" -gt "$MAX_LENGTH" ]]; then
  echo "Error: Password length cannot exceed the maximum length of $MAX_LENGTH." >&2
  exit 1
fi

# Generate and display the password
generate_password
