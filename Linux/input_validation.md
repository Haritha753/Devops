# DevOps Roadmap – Day 03
## Bash Scripting: Input Validation, String Operations and File Tests

**Week:** 01 – Linux, Git & Bash  
**Day:** 03  
**Objective:** Learn how to validate script inputs, perform string comparisons, check files and directories, and build reliable Linux administration scripts.

---

# 1. Introduction to Input Validation

## What is input validation?

Input validation means checking whether the information provided to a script is valid before processing it.

For example, consider a script that checks the status of a Linux service.

```bash
./check_service.sh sshd
```

Here, `sshd` is the input supplied to the script.

But what happens if someone executes:

```bash
./check_service.sh
```

Or:

```bash
./check_service.sh unknown_service
```

Without input validation, the script may produce confusing errors or incorrect results.

Input validation helps us:
- Ensure required arguments are provided.
- Prevent empty inputs.
- Validate user-provided values.
- Avoid unnecessary command execution.
- Display meaningful error messages.

## 1.1 Understanding positional parameters

Positional parameters allow a Bash script to receive arguments when it is executed.

| Parameter | Meaning |
|---|---|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Total number of arguments |
| `$@` | All arguments |
| `$*` | All arguments as a combined list |
| `$?` | Exit status of the last command |

Example:

```bash
#!/bin/bash

echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Total arguments: $#"
echo "All arguments: $@"
```

Execute:

```bash
./test.sh Linux DevOps
```

Output:

```text
Script name: ./test.sh
First argument: Linux
Second argument: DevOps
Total arguments: 2
All arguments: Linux DevOps
```

---

# 2. Checking Whether an Argument Is Provided

The `$#` parameter tells us how many arguments were supplied.

Example:

```bash
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "ERROR: Service name is required"
    echo "Usage: $0 <service_name>"
    exit 1
fi

echo "Checking service: $1"
```

### Explanation

```bash
if [ $# -eq 0 ]; then
```

Checks whether the number of arguments is zero.

```bash
echo "ERROR: Service name is required"
```

Displays an error message.

```bash
exit 1
```

Terminates the script with a non-zero exit status.

### Test cases

No argument:

```bash
./check_service.sh
```

Expected output:

```text
ERROR: Service name is required
Usage: ./check_service.sh <service_name>
```

With an argument:

```bash
./check_service.sh sshd
```

Expected output:

```text
Checking service: sshd
```

---

# 3. String Validation Operators

Bash provides operators to check whether strings are empty, non-empty or equal to specific values.

| Operator | Meaning | Example |
|---|---|---|
| `-z` | String is empty | `[ -z "$NAME" ]` |
| `-n` | String is not empty | `[ -n "$NAME" ]` |
| `=` | Strings are equal | `[ "$ENV" = "prod" ]` |
| `!=` | Strings are different | `[ "$ENV" != "prod" ]` |

## 3.1 The -z operator

`-z` checks whether a string has zero length.

Example:

```bash
#!/bin/bash

NAME=""

if [ -z "$NAME" ]; then
    echo "Name is empty"
else
    echo "Name is provided"
fi
```

Output:

```text
Name is empty
```

## 3.2 The -n operator

`-n` checks whether a string is not empty.

Example:

```bash
#!/bin/bash

NAME="DevOps"

if [ -n "$NAME" ]; then
    echo "Name is provided"
else
    echo "Name is empty"
fi
```

Output:

```text
Name is provided
```

## 3.3 String comparison

We can compare two strings using `=` and `!=`.

Example:

```bash
#!/bin/bash

ENVIRONMENT="$1"

if [ "$ENVIRONMENT" = "prod" ]; then
    echo "Production environment selected"

elif [ "$ENVIRONMENT" = "test" ]; then
    echo "Testing environment selected"

else
    echo "Unknown environment"
fi
```

Execute:

```bash
./environment.sh prod
./environment.sh test
./environment.sh dev
```

Output for the first command:

```text
Production environment selected
```

**Real-world use case:** Environment validation is useful when deploying applications to development, testing and production environments.

---

# 4. File and Directory Tests

Linux automation scripts frequently need to check whether files and directories exist before performing operations.

Examples:
- Check whether a backup file exists before restoring it.
- Check whether a log directory exists before writing logs.
- Check whether a configuration file is readable.
- Check whether a script has execution permissions.

## 4.1 File test operators

| Operator | Meaning | Example |
|---|---|---|
| `-e` | Path exists | `[ -e "$FILE" ]` |
| `-f` | Regular file exists | `[ -f "$FILE" ]` |
| `-d` | Directory exists | `[ -d "$DIR" ]` |
| `-r` | File is readable | `[ -r "$FILE" ]` |
| `-w` | File is writable | `[ -w "$FILE" ]` |
| `-x` | File is executable | `[ -x "$FILE" ]` |
| `-s` | File exists and is not empty | `[ -s "$FILE" ]` |

## 4.2 Check whether a file exists

```bash
#!/bin/bash

FILE="/etc/hosts"

if [ -f "$FILE" ]; then
    echo "File exists"
else
    echo "File does not exist"
fi
```

Explanation:

- `FILE` stores the file path.
- `-f` checks whether the path is a regular file.
- `if` evaluates the result.
- The appropriate message is displayed.

## 4.3 Check whether a file is readable

```bash
#!/bin/bash

FILE="/etc/hosts"

if [ -f "$FILE" ]; then

    if [ -r "$FILE" ]; then
        echo "File is readable"
    else
        echo "File is not readable"
    fi

else
    echo "File does not exist"
fi
```

## 4.4 Check whether a directory exists

```bash
#!/bin/bash

BACKUP_DIR="/backup"

if [ -d "$BACKUP_DIR" ]; then
    echo "Backup directory exists"
else
    echo "Backup directory does not exist"
fi
```

## 4.5 Check whether a file is empty

```bash
#!/bin/bash

FILE="/var/log/messages"

if [ -s "$FILE" ]; then
    echo "File exists and contains data"
else
    echo "File is empty or does not exist"
fi
```

## 4.6 Check file permissions

```bash
#!/bin/bash

FILE="server_health_check.sh"

if [ -x "$FILE" ]; then
    echo "Script is executable"
else
    echo "Script is not executable"
fi
```

To make the script executable:

```bash
chmod +x server_health_check.sh
```

**Important:** File tests check existence and permissions at the time of the test. They do not guarantee that a subsequent read, write or execution will succeed.

---

# 5. Practical Project – Service Validation Script

**Project name:** Linux Service Validation Tool

**Filename:** `service_validation.sh`

**Objective:** Create a script that validates user input and checks the status of a Linux service.

## 5.1 Complete script

```bash
#!/bin/bash

# Check whether an argument is provided

if [ $# -eq 0 ]; then
    echo "ERROR: Please provide a service name"
    echo "Usage: $0 <service_name>"
    exit 1
fi

# Store the service name

SERVICE="$1"

# Validate input

if [ -z "$SERVICE" ]; then
    echo "ERROR: Service name cannot be empty"
    exit 1
fi

echo "Checking service: $SERVICE"

# Check service status

if systemctl is-active --quiet "$SERVICE"; then
    echo "SUCCESS: $SERVICE is running"
else
    echo "WARNING: $SERVICE is not active"
fi
```

## 5.2 Explanation

**Step 1 – Check argument count**

```bash
if [ $# -eq 0 ]; then
```

Ensures the user provides at least one argument.

**Step 2 – Store the input**

```bash
SERVICE="$1"
```

Stores the first argument in a variable.

**Step 3 – Validate the string**

```bash
if [ -z "$SERVICE" ]; then
```

Checks whether the service name is empty.

**Step 4 – Check service status**

```bash
systemctl is-active --quiet "$SERVICE"
```

Checks whether the specified service is active.

- `systemctl` manages systemd services.
- `is-active` checks whether the service is active.
- `--quiet` suppresses normal output and provides an exit status.

**Step 5 – Display the result**

```bash
if systemctl is-active --quiet "$SERVICE"; then
```

If the command succeeds, the service is active. Otherwise, the script displays a warning.

## 5.3 Execute the script

Create the file:

```bash
vi service_validation.sh
```

Make it executable:

```bash
chmod +x service_validation.sh
```

Run it:

```bash
./service_validation.sh sshd
```

## 5.4 Test scenarios

**Test 1 – No argument**

```bash
./service_validation.sh
```

Expected result:

```text
ERROR: Please provide a service name
Usage: ./service_validation.sh <service_name>
```

**Test 2 – Valid active service**

```bash
./service_validation.sh sshd
```

Expected result if SSH is active:

```text
Checking service: sshd
SUCCESS: sshd is running
```

**Test 3 – Invalid service name**

```bash
./service_validation.sh invalid_service
```

Expected result:

```text
Checking service: invalid_service
WARNING: invalid_service is not active
```

Note: An inactive service and a non-existent service both enter the `else` branch in this basic version. We will improve this distinction with additional error handling.

---

# 6. Useful Commands for Day 03

| Command | Purpose |
|---|---|
| `chmod +x script.sh` | Add execute permission |
| `./script.sh argument` | Execute script with an argument |
| `bash script.sh argument` | Execute using Bash |
| `bash -n script.sh` | Check Bash syntax without running the script |
| `bash -x script.sh` | Execute with debugging output |
| `echo $?` | Display the previous command's exit status |
| `ls -l filename` | Inspect file permissions |
| `test -f filename` | Check for a regular file |
| `test -d directory` | Check for a directory |

---

# 7. Common Mistakes and Troubleshooting

| Mistake | Reason | Solution |
|---|---|---|
| `[: missing ]` | Missing closing bracket | Check `[ condition ]` syntax |
| `unary operator expected` | Variable may be empty or unquoted | Quote variables: `"$NAME"` |
| `Permission denied` | Missing execution permission | `chmod +x script.sh` |
| Wrong service status | Incorrect service name | Verify with `systemctl list-units --type=service` |
| File not found | Incorrect file path | Verify using `ls -l` |
| Script accepts missing input | Argument validation is absent | Check `$#` before using `$1` |

### Best practices

1. Always quote variables in tests:

```bash
[ -z "$NAME" ]
```

2. Validate inputs before executing commands.

3. Use meaningful error messages.

4. Use non-zero exit statuses when a script cannot continue.

5. Check file and directory existence before processing them.

6. Test scripts with valid and invalid inputs.

7. Avoid restarting or modifying production services as part of a learning exercise without approval.

---

# 8. Interview Questions and Answers

**1. What is input validation in Bash?**

Input validation means checking whether the values supplied to a script are valid before processing them.

**2. What is the difference between `$1` and `$#`?**

`$1` represents the first argument, while `$#` represents the total number of arguments.

**3. What does `-z` do?**

It checks whether a string is empty.

**4. What does `-n` do?**

It checks whether a string is not empty.

**5. What is the difference between `-e` and `-f`?**

`-e` checks whether a path exists. `-f` checks whether it is a regular file.

**6. How do you check whether a directory exists?**

```bash
[ -d "$DIR" ]
```

**7. How do you check whether a file is executable?**

```bash
[ -x "$FILE" ]
```

**8. What is the purpose of `systemctl is-active --quiet`?**

It checks whether a systemd service is active without printing normal output. Its exit status can be used in an `if` condition.

**9. Why should variables be quoted in Bash?**

Quoting protects values containing spaces or special characters from being split or expanded unexpectedly.

**10. Why do we use `exit 1`?**

It terminates a script with a non-zero exit status, generally indicating failure.

---

# 9. Day 03 Revision Checklist

- [ ] Understand positional parameters.
- [ ] Understand `$#`, `$1` and `$0`.
- [ ] Check whether arguments are provided.
- [ ] Validate empty and non-empty strings.
- [ ] Compare strings using `=` and `!=`.
- [ ] Check whether files exist.
- [ ] Check whether directories exist.
- [ ] Check file readability and writability.
- [ ] Check executable permissions.
- [ ] Understand `systemctl is-active --quiet`.
- [ ] Build the service validation script.
- [ ] Test valid and invalid inputs.
- [ ] Practise Bash syntax checking and debugging.

---

# 10. Real-World DevOps Applications

| Day 03 concept | Real-world application |
|---|---|
| Input validation | Validate server names and service names |
| String comparison | Select development, testing or production environments |
| File existence checks | Verify backup files before restoration |
| Directory checks | Verify backup and log directories |
| Read permission checks | Validate configuration files |
| Execute permission checks | Validate automation scripts |
| Exit statuses | Detect failed commands in automation |
| Service checks | Monitor PostgreSQL, SSH and application services |

**Day 03 learning outcome:** Build scripts that validate input, check filesystem conditions and perform basic service checks safely.

**Next topics:** Exit codes, command failure handling, structured logging, Bash debugging and production-grade script reliability.
