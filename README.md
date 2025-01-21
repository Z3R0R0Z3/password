
# Password Generator Script

A simple password generator script that allows you to generate secure, random passwords based on customizable options. The generated passwords are saved to a `passwords.txt` file.

## Features

- Generate passwords with custom length (default is 12, max is 64).
- Exclude character types like numbers, uppercase letters, or special characters.
- Interactive mode for easy configuration.
- Generated passwords are saved to a `passwords.txt` file (each password on a new line).

## Requirements

- Bash shell (works on Linux, macOS, and WSL on Windows)
- No additional dependencies are required, as the script uses built-in Bash commands.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Z3R0R0Z3/password.git
   cd password
   ```

2. Make the script executable:
   ```bash
   chmod +x password_generator.sh
   ```

## Usage

### 1. Interactive Mode

Run the script in interactive mode, where you can configure the password settings:

```bash
./password_generator.sh -i
```

You will be prompted to enter the following options:

- **Password length** (default: 12, max: 64)
- **Exclude numbers**? (yes/no)
- **Exclude uppercase letters**? (yes/no)
- **Exclude special characters**? (yes/no)

The script will generate a password based on your choices and save it to the `passwords.txt` file.

### 2. Command-Line Mode

You can also run the script with specific options directly from the command line:

```bash
./password_generator.sh -l 16 -n -s
```

Options:
- `-l length`: Set the length of the password (default: 12, max: 64).
- `-m max_length`: Set the maximum allowed length for the password (default: 64).
- `-n`: Exclude numbers from the password.
- `-u`: Exclude uppercase letters from the password.
- `-s`: Exclude special characters from the password.
- `-i`: Run the script in interactive mode.
- `-v`: Display version information.
- `-h`: Show the help message.

### Example

```bash
# Generate a 16-character password with numbers, uppercase letters, and special characters
./password_generator.sh -l 16

# Generate a 12-character password without special characters
./password_generator.sh -l 12 -s
```

Each time a password is generated, it will be appended to the `passwords.txt` file, with one password per line.

## Password File

The generated passwords are saved to a file called `passwords.txt`. Each password is appended to the file on a new line. Example:

```
k7J8kL1qW2oB9z3r
hLg7gF7twTbp9w4x
dog#%z34kr9w0kfh
```

You can find this file in the same directory where the script is located.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Happy password generating! 🔐
