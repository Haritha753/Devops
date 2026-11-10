# DevOps Roadmap – Day 02
## Git Branching, Remote Operations & Bash Scripting

**Week:** 01 – Linux, Git & Bash  
**Day:** 02  
**Objective:** Learn how to manage Git branches, work with remote repositories, handle merge conflicts and build interactive Bash automation scripts.

---

# 1. Git Branching

## 1.1 What is a Git branch?

A Git branch is an independent line of development within a repository.

Imagine you have a monitoring script that is already working. You want to add new functionality without directly modifying the stable version.

Instead of changing the `main` branch, create a separate branch, develop and test your changes there, and merge them into `main` when ready.

### Why do we use branches?

- Develop new features independently.
- Fix bugs without disturbing stable code.
- Test changes before merging.
- Allow multiple developers to work simultaneously.
- Maintain a clean development workflow.

### Example

```text
                 main
                  |
             Initial Commit
                  |
             Linux Script
                  |
             /         \
          main       feature/day02
                       |
                  Add Bash Menu
                       |
                  Add Functions
```

The feature branch contains the new development work. The main branch remains unchanged until the changes are merged.

## 1.2 Git branch commands

| Command | Purpose |
|---|---|
| `git branch` | List local branches |
| `git branch feature-name` | Create a branch |
| `git switch feature-name` | Switch branches |
| `git switch -c feature-name` | Create and switch to a branch |
| `git branch -d feature-name` | Delete a merged branch |
| `git branch -D feature-name` | Force-delete a branch |

### Practical example

Create a new feature branch:

```bash
git branch feature/day02-bash
```

List branches:

```bash
git branch
```

Switch to the feature branch:

```bash
git switch feature/day02-bash
```

Alternatively, create and switch in one command:

```bash
git switch -c feature/day02-bash
```

Check the current branch:

```bash
git branch
```

The current branch is marked with `*`.

**Important:** Before switching branches, check `git status`. Uncommitted changes can affect your ability to switch safely.

---

# 2. Git Merge

## 2.1 What is Git merge?

Git merge combines changes from one branch into another.

Example:

You have developed a new Linux monitoring menu in `feature/day02-bash`. Once it is ready, you want to bring the changes into `main`.

### Merge workflow

```bash
git switch main
git merge feature/day02-bash
```

### Important commands

```bash
git status
git branch
git log --oneline
git log --oneline --graph --all
```

### Understanding the workflow

1. Develop your changes in a feature branch.
2. Test the changes.
3. Commit your changes.
4. Switch to `main`.
5. Merge the feature branch.
6. Push the updated `main` branch to GitHub.

---

# 3. Git Remote Repository Operations

## 3.1 What is a remote repository?

A remote repository is a copy of your Git repository hosted on another system, such as GitHub.

Your local repository is on your Linux machine. Your remote repository is hosted on GitHub.

```text
       Local Linux Machine
       -------------------
       Working Directory
              |
         Staging Area
              |
          Local Git
         Repository
              |
           Push/Pull
              |
              v
       GitHub Repository
```

## 3.2 Check remote configuration

```bash
git remote -v
```

Displays the remote repository URLs configured for your project.

Example:

```text
origin  https://github.com/username/project.git (fetch)
origin  https://github.com/username/project.git (push)
```

`origin` is the conventional name given to the default remote repository.

## 3.3 Git fetch

```bash
git fetch origin
```

Downloads new commits and remote branch information without merging those changes into your current branch.

Example:

```bash
git fetch origin
git branch -r
```

Use fetch when you want to inspect remote changes before integrating them.

## 3.4 Git pull

```bash
git pull origin main
```

Fetches changes from the remote repository and integrates them into the current branch.

Use it to update your local branch with remote changes.

## 3.5 Git push

```bash
git push origin main
```

Uploads your local commits to the remote repository.

### Difference between fetch, pull and push

| Command | What it does |
|---|---|
| `git fetch` | Downloads remote changes but does not integrate them into your current branch |
| `git pull` | Fetches and integrates remote changes |
| `git push` | Uploads local commits to the remote repository |

### Real-world example

Suppose another developer updates the README file on GitHub.

You want to retrieve their changes:

```bash
git fetch origin
```

Inspect the changes:

```bash
git log --oneline --graph --all
```

Integrate the remote changes:

```bash
git pull origin main
```

---

# 4. Git Merge Conflicts

## 4.1 What is a merge conflict?

A merge conflict occurs when Git cannot automatically combine changes from different branches.

For example:

- The `main` branch changes line 10 of `README.md`.
- The feature branch also changes line 10.
- Git cannot decide which version should be retained.

You must resolve the conflict manually.

## 4.2 Understanding conflict markers

Git displays conflicting sections like this:

```text
<<<<<<< HEAD
This is the content from the current branch.
=======
This is the content from the incoming branch.
>>>>>>> feature/day02-bash
```

Meaning:

- `<<<<<<< HEAD`: Beginning of the current branch's content.
- `=======`: Separates the two versions.
- `>>>>>>> feature/day02-bash`: End of the incoming branch's content.

## 4.3 Steps to resolve a merge conflict

1. Run `git status` to identify conflicting files.
2. Open the affected file.
3. Decide which changes should be retained.
4. Remove the conflict markers.
5. Save the corrected file.
6. Stage the resolved file.
7. Complete the merge.

Commands:

```bash
git status
vi README.md
git add README.md
git commit
```

To cancel an unfinished merge:

```bash
git merge --abort
```

**Important:** Always inspect the resulting file after resolving conflicts. Do not blindly accept one side without checking the changes.

---

# 5. Bash Functions

## 5.1 What is a function?

A function is a reusable block of commands that performs a specific task.

Instead of repeatedly writing the same commands, define them once and call the function whenever required.

### Syntax

```bash
function_name() {
    commands
}
```

### Example

```bash
#!/bin/bash

check_disk() {
    echo "Checking disk usage..."
    df -h
}

check_disk
```

Output:

```text
Checking disk usage...
Filesystem      Size  Used Avail Use%
...
```

## 5.2 Functions with arguments

Functions can receive values through positional parameters.

Example:

```bash
#!/bin/bash

greet() {
    echo "Hello $1"
    echo "Your role is $2"
}

greet Haritha DevOps
```

Output:

```text
Hello Haritha
Your role is DevOps
```

Here:

- `$1` = Haritha
- `$2` = DevOps

## 5.3 Local variables inside functions

Use `local` to declare variables that are limited to the function.

```bash
check_service() {
    local SERVICE_NAME="$1"

    systemctl status "$SERVICE_NAME"
}

check_service sshd
```

This helps avoid unintentionally modifying variables outside the function.

## 5.4 Return versus echo

There is an important difference between `return` and `echo`.

**Return:** Sets the function's exit status.

**Echo:** Prints output that can be captured or displayed.

Example using return:

```bash
check_number() {
    if [ "$1" -gt 10 ]; then
        return 0
    else
        return 1
    fi
}

check_number 15

if [ "$?" -eq 0 ]; then
    echo "Number is greater than 10"
else
    echo "Number is not greater than 10"
fi
```

Example using echo:

```bash
get_hostname() {
    hostname
}

SERVER=$(get_hostname)

echo "Server: $SERVER"
```

**Remember:** A Bash function's `return` is for status codes, not for returning arbitrary text.

---

# 6. Positional Parameters in Bash

Positional parameters allow a script to accept input arguments when it is executed.

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

### Important positional parameters

| Parameter | Meaning |
|---|---|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Number of arguments |
| `$@` | All arguments as separate words |
| `$*` | All arguments as a combined list |
| `$?` | Exit status of the last command |

### Difference between `$@` and `$*`

When quoted:

```bash
"$@"
```

Each argument remains a separate word.

```bash
"$*"
```

All arguments are combined into one word, separated by the first character of `IFS` (normally a space).

For scripts that need to process arguments individually, prefer:

```bash
for ARG in "$@"
do
    echo "$ARG"
done
```

---

# 7. Loops in Bash

Loops allow us to execute commands repeatedly.

They are particularly useful in DevOps automation when checking multiple servers, services, directories or files.

## 7.1 For loop

A `for` loop iterates over a list of values.

Syntax:

```bash
for VARIABLE in LIST
do
    commands
done
```

Example:

```bash
#!/bin/bash

for SERVER in server1 server2 server3
do
    echo "Checking $SERVER"
done
```

Output:

```text
Checking server1
Checking server2
Checking server3
```

### Real-time example: Check multiple services

```bash
#!/bin/bash

SERVICES=("sshd" "crond")

for SERVICE in "${SERVICES[@]}"
do
    if systemctl is-active --quiet "$SERVICE"; then
        echo "$SERVICE is running"
    else
        echo "$SERVICE is not running"
    fi
done
```

## 7.2 While loop

A `while` loop executes as long as its condition is true.

Syntax:

```bash
while [ condition ]
do
    commands
done
```

Example:

```bash
#!/bin/bash

COUNT=1

while [ "$COUNT" -le 5 ]
do
    echo "Count: $COUNT"

    COUNT=$((COUNT + 1))
done
```

Output:

```text
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
```

### Understanding arithmetic expansion

```bash
COUNT=$((COUNT + 1))
```

This increases the value of `COUNT` by one.

**Important:** If the loop condition never becomes false, the loop can run indefinitely.

## 7.3 Until loop

An `until` loop executes until the condition becomes true.

Example:

```bash
#!/bin/bash

COUNT=1

until [ "$COUNT" -gt 5 ]
do
    echo "Count: $COUNT"

    COUNT=$((COUNT + 1))
done
```

### Difference between while and until

| Loop | Behaviour |
|---|---|
| `while` | Runs while the condition is true |
| `until` | Runs until the condition becomes true |

---

# 8. Case Statements

A `case` statement is useful when a script needs to handle multiple choices.

It is commonly used to build interactive menus.

### Syntax

```bash
case "$VARIABLE" in
    option1)
        commands
        ;;
    option2)
        commands
        ;;
    *)
        echo "Invalid option"
        ;;
esac
```

### Example

```bash
#!/bin/bash

read -p "Enter environment (dev/test/prod): " ENV

case "$ENV" in
    dev)
        echo "Development environment selected"
        ;;
    test)
        echo "Testing environment selected"
        ;;
    prod)
        echo "Production environment selected"
        ;;
    *)
        echo "Invalid environment"
        ;;
esac
```

### Important keywords

- `case`: Starts the selection block.
- `in`: Begins the list of patterns.
- `)`: Separates a pattern from its commands.
- `;;`: Ends a pattern's commands.
- `*)`: Default pattern.
- `esac`: Ends the case statement.

---

# 9. Bash Arrays

An array stores multiple values in one variable.

### Creating an array

```bash
SERVERS=("server1" "server2" "server3")
```

### Accessing array elements

```bash
echo "${SERVERS[0]}"
echo "${SERVERS[1]}"
echo "${SERVERS[2]}"
```

Bash arrays use zero-based indexing.

### Display all elements

```bash
echo "${SERVERS[@]}"
```

### Count array elements

```bash
echo "${#SERVERS[@]}"
```

### Loop through an array

```bash
for SERVER in "${SERVERS[@]}"
do
    echo "Checking $SERVER"
done
```

### Real-time DevOps use case

Suppose you maintain a list of application services:

```bash
SERVICES=("sshd" "crond" "postgresql")
```

You can loop through the array and check each service's status.

This avoids writing separate service-check commands for every service.

---

# 10. break, continue, exit and return

These keywords control script execution.

| Keyword | Purpose |
|---|---|
| `break` | Exit the current loop |
| `continue` | Skip the current iteration and move to the next |
| `exit` | Exit the script |
| `return` | Exit a function and set its status |

### break example

```bash
for NUMBER in {1..5}
do
    if [ "$NUMBER" -eq 3 ]; then
        break
    fi

    echo "$NUMBER"
done
```

Output:

```text
1
2
```

### continue example

```bash
for NUMBER in {1..5}
do
    if [ "$NUMBER" -eq 3 ]; then
        continue
    fi

    echo "$NUMBER"
done
```

Output:

```text
1
2
4
5
```

### exit example

```bash
echo "Starting script"

exit 0

echo "This line will not execute"
```

`exit 0` indicates successful script termination.

---

# 11. Practical Project – Interactive Linux Server Monitoring Menu

**Script:** `server_monitor_menu.sh`

**Objective:** Build a menu-driven Linux monitoring tool that allows an administrator to perform common health checks.

### Features

1. CPU usage
2. Memory usage
3. Disk usage
4. Top CPU-consuming processes
5. Service status
6. Exit

### Complete script

```bash
#!/bin/bash

check_cpu() {
    echo
    echo "----- CPU INFORMATION -----"
    uptime
    echo "CPU Cores: $(nproc)"
}

check_memory() {
    echo
    echo "----- MEMORY INFORMATION -----"
    free -h
}

check_disk() {
    echo
    echo "----- DISK USAGE -----"
    df -h
}

check_processes() {
    echo
    echo "----- TOP CPU PROCESSES -----"
    ps aux --sort=-%cpu | head -10
}

check_service() {
    echo
    read -p "Enter service name: " SERVICE

    if systemctl is-active --quiet "$SERVICE"; then
        echo "$SERVICE is running"
    else
        echo "$SERVICE is not active"
    fi
}

while true
do
    echo
    echo "================================"
    echo "     LINUX SERVER MONITOR"
    echo "================================"
    echo "1. CPU Usage"
    echo "2. Memory Usage"
    echo "3. Disk Usage"
    echo "4. Top CPU Processes"
    echo "5. Check Service"
    echo "6. Exit"

    read -p "Enter your choice: " CHOICE

    case "$CHOICE" in
        1)
            check_cpu
            ;;
        2)
            check_memory
            ;;
        3)
            check_disk
            ;;
        4)
            check_processes
            ;;
        5)
            check_service
            ;;
        6)
            echo "Exiting monitoring tool"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
```

## 11.1 How the project works

**Step 1 – Functions**

Each monitoring activity is defined as a separate function:

- `check_cpu`
- `check_memory`
- `check_disk`
- `check_processes`
- `check_service`

**Step 2 – Infinite menu loop**

```bash
while true
```

Keeps displaying the menu until the user selects Exit.

**Step 3 – User input**

```bash
read -p "Enter your choice: " CHOICE
```

Reads the option entered by the administrator.

**Step 4 – Case statement**

```bash
case "$CHOICE" in
```

Executes the function corresponding to the selected option.

**Step 5 – Exit**

```bash
exit 0
```

Terminates the script when the user selects option 6.

## 11.2 Create and execute the project

Navigate to your repository:

```bash
cd ~/devops-projects/Devops
```

Create the script:

```bash
vi Week-01-Linux/scripts/server_monitor_menu.sh
```

Make it executable:

```bash
chmod +x Week-01-Linux/scripts/server_monitor_menu.sh
```

Execute:

```bash
./Week-01-Linux/scripts/server_monitor_menu.sh
```

---

# 12. GitHub – Publish Day 02 Project

Recommended repository structure:

```text
Devops/
│
├── README.md
│
└── Week-01-Linux/
    ├── Day-02-Consolidated-Notes.md
    │
    └── scripts/
        └── server_monitor_menu.sh
```

### Step 1 – Navigate to repository

```bash
cd ~/devops-projects/Devops
```

### Step 2 – Create feature branch

```bash
git switch -c feature/day02-bash
```

### Step 3 – Check changes

```bash
git status
```

### Step 4 – Stage files

```bash
git add Week-01-Linux/
```

### Step 5 – Commit changes

```bash
git commit -m "Day 02: Add Bash automation and Git notes"
```

### Step 6 – Push feature branch

```bash
git push -u origin feature/day02-bash
```

### Step 7 – Merge into main

```bash
git switch main
git merge feature/day02-bash
```

### Step 8 – Push main

```bash
git push origin main
```

If you have already created and merged the feature branch, do not recreate it unnecessarily. Check your current branch and Git status first.

---

# 13. Common Troubleshooting

| Problem | Possible reason | What to check |
|---|---|---|
| `Permission denied` | Script is not executable | `chmod +x script.sh` |
| `command not found` | Typo or missing command | `command -v command_name` |
| Script runs indefinitely | Loop condition is not changing | Check counter and condition |
| Service check fails | Wrong service name or inactive service | `systemctl status service_name` |
| Git push rejected | Remote has commits you do not have locally | Fetch and integrate remote changes |
| Merge conflict | Competing changes in the same area | Resolve conflict markers |
| Wrong branch | Commands executed on an unintended branch | `git branch` |
| Variable is empty | Incorrect assignment or variable reference | Inspect variable names and quoting |

### Useful debugging commands

Check Bash syntax without executing the script:

```bash
bash -n script.sh
```

Execute with debugging enabled:

```bash
bash -x script.sh
```

Check script permissions:

```bash
ls -l script.sh
```

---

# 14. Important Interview Questions

### Git

**1. What is a Git branch?**

A branch is an independent line of development used to make changes without directly modifying the main codebase.

**2. What is the difference between `git branch` and `git switch`?**

`git branch` manages branches, while `git switch` changes the currently checked-out branch.

**3. What is Git merge?**

Git merge combines changes from one branch into another.

**4. What is the difference between fetch and pull?**

Fetch downloads remote changes without integrating them. Pull fetches and integrates them.

**5. What is a merge conflict?**

A merge conflict occurs when Git cannot automatically combine competing changes.

### Bash scripting

**6. Why do we use functions in Bash?**

To organise reusable commands and reduce code duplication.

**7. What is the difference between `$1` and `$#`?**

`$1` is the first argument. `$#` is the total number of arguments.

**8. What is the difference between a `for` loop and a `while` loop?**

A `for` loop commonly iterates through a list. A `while` loop runs while a condition remains true.

**9. What is the purpose of a case statement?**

It selects and executes commands based on matching patterns.

**10. What is a Bash array?**

An array stores multiple values in a single variable.

**11. What is the difference between `break` and `continue`?**

`break` exits a loop. `continue` skips the current iteration.

**12. What is the difference between `return` and `exit`?**

`return` exits a function or sourced script context. `exit` terminates the shell or script.

---

# 15. Day 02 Revision Checklist

- [ ] Understand Git branching.
- [ ] Create and switch branches.
- [ ] Merge feature branches into main.
- [ ] Understand local and remote repositories.
- [ ] Practise `git fetch`, `git pull` and `git push`.
- [ ] Understand and resolve merge conflicts.
- [ ] Create Bash functions.
- [ ] Pass arguments to functions.
- [ ] Understand local variables.
- [ ] Use positional parameters.
- [ ] Practise `for`, `while` and `until` loops.
- [ ] Write `case` statements.
- [ ] Create and iterate through arrays.
- [ ] Use `break`, `continue`, `exit` and `return`.
- [ ] Build the interactive server monitoring menu.
- [ ] Check Bash syntax and debug scripts.
- [ ] Publish notes and scripts to GitHub.

---

# 16. Real-World DevOps Connection

| Day 02 concept | Real-world application |
|---|---|
| Git branching | Develop new automation without modifying stable code |
| Git merge | Integrate tested changes |
| Git fetch and pull | Synchronise local repositories |
| Merge conflict resolution | Collaborate safely with other engineers |
| Bash functions | Build reusable automation components |
| Positional parameters | Pass server names, paths and service names to scripts |
| Loops | Monitor multiple servers and services |
| Case statements | Build operational command-line menus |
| Arrays | Maintain lists of servers, services and files |
| Debugging | Troubleshoot automation failures |

**Day 02 outcome:** You should be able to build a reusable, menu-driven Linux monitoring script and manage its development using Git branches and GitHub.

**Next topic:** Day 03 – Bash scripting in more depth: input validation, string and file tests, exit codes, error handling, logging, debugging and automation best practices.

