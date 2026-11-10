# Day 01 — Linux Commands and Bash Scripting

## 1. Navigating the Linux filesystem

| Command | Purpose | Example |
|---|---|---|
| `pwd` | Display current directory | `pwd` |
| `ls` | List files and directories | `ls` |
| `ls -l` | Detailed file listing | `ls -l` |
| `ls -lh` | Human-readable file sizes | `ls -lh` |
| `ls -a` | Show hidden files | `ls -a` |
| `cd` | Change directory | `cd /var/log` |
| `cd ..` | Move one directory up | `cd ..` |
| `cd ~` | Move to home directory | `cd ~` |
| `mkdir` | Create directory | `mkdir scripts` |
| `mkdir -p` | Create nested directories | `mkdir -p project/scripts/logs` |
| `tree` | Display directory structure | `tree -L 2` |

### Practical example

```bash
mkdir -p ~/devops-projects/linux-monitoring
cd ~/devops-projects/linux-monitoring
pwd
mkdir scripts logs
ls -l
```

---

## 2. File creation and reading

| Command | Purpose | Example |
|---|---|---|
| `touch` | Create an empty file | `touch notes.txt` |
| `vi` | Open editor | `vi notes.txt` |
| `cat` | Display file contents | `cat notes.txt` |
| `less` | Read a file page by page | `less /var/log/messages` |
| `head` | Display first lines | `head -10 file.txt` |
| `tail` | Display last lines | `tail -20 file.txt` |
| `tail -f` | Monitor file continuously | `tail -f application.log` |
| `cp` | Copy files | `cp source.txt backup.txt` |
| `cp -p` | Copy while preserving attributes | `cp -p source.txt backup.txt` |
| `mv` | Move or rename files | `mv old.txt new.txt` |

### Important vi editor commands

| Key/command | Purpose |
|---|---|
| `i` | Enter insert mode |
| `Esc` | Return to command mode |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |

### Practical example

```bash
touch notes.txt
vi notes.txt
cat notes.txt
```

---

## 3. Linux process management

A process is an executing instance of a program.

| Command | Purpose |
|---|---|
| `ps -ef` | Display all processes in full format |
| `ps aux` | Display detailed process information |
| `ps aux --sort=-%cpu` | Sort processes by CPU usage |
| `ps aux --sort=-%mem` | Sort processes by memory usage |
| `top` | Monitor processes in real time |
| `pgrep process_name` | Find process IDs by name |
| `pidstat` | Monitor process statistics (requires sysstat) |

### Practical commands

```bash
ps -ef

ps aux --sort=-%cpu | head

ps aux --sort=-%mem | head

pgrep sshd

top
```

### Important process concepts

- PID: Process ID.
- PPID: Parent Process ID.
- Zombie process: A process that has finished but whose parent has not collected its exit status.
- CPU utilization: Amount of CPU currently being used.
- Load average: Average system load over 1, 5 and 15 minutes.

### Real-world troubleshooting

If a server reports high CPU:

```bash
uptime
top
ps aux --sort=-%cpu | head -10
```

Identify the process consuming the most CPU, then investigate its logs and behaviour before taking action.

---

## 4. CPU monitoring

| Command | Purpose |
|---|---|
| `uptime` | Shows uptime and load averages |
| `nproc` | Shows available processing units |
| `lscpu` | Displays CPU architecture and details |
| `top` | Shows real-time CPU usage |
| `pidstat` | Displays process-level statistics |

### Practical commands

```bash
uptime

nproc

lscpu

top

pidstat 1 5
```

### Important distinction

CPU utilization and load average are different.

- CPU utilization measures how busy CPUs are.
- Load average measures the average number of tasks waiting for or using CPU, including tasks in certain uninterruptible states.

A high load average does not automatically mean CPU utilization is high.

---

## 5. Memory monitoring

| Command | Purpose |
|---|---|
| `free -h` | Display memory usage |
| `vmstat 1 5` | Display system memory and process statistics every second for five reports |
| `swapon --show` | Display configured swap devices |
| `ps aux --sort=-%mem` | Identify memory-consuming processes |

### Practical commands

```bash
free -h

vmstat 1 5

swapon --show

ps aux --sort=-%mem | head -10
```

### Important memory terms

- Total: Total available physical memory.
- Used: Memory currently used.
- Free: Completely unused memory.
- Available: Estimated memory available for new applications without swapping.
- Cache/buffers: Memory used for caching and buffering.
- Swap: Disk space used as an extension of RAM.

Important: Low free memory alone does not necessarily indicate a problem. Check available memory and swap activity.

---

## 6. Disk and filesystem monitoring

| Command | Purpose |
|---|---|
| `df -h` | Show filesystem disk usage |
| `df -i` | Show inode usage |
| `df -P /` | Show root filesystem usage in a predictable format |
| `du -sh directory` | Show total directory size |
| `du -ah directory` | Show file and directory sizes |
| `lsblk` | List block devices |
| `lsof +L1` | Find open files that have been deleted |

### Practical commands

```bash
df -h

df -i

df -P /

du -sh /var/log

du -ah /var/log | sort -rh | head -10

lsblk

lsof +L1
```

### Important distinction

**df -h vs du -sh**

- `df -h`: Reports filesystem-level usage.
- `du -sh`: Reports the disk space used by a directory.

**df -h vs df -i**

- `df -h`: Checks available disk space.
- `df -i`: Checks inode availability.

A filesystem can have free disk space but still fail to create files if all its inodes are exhausted.

---

## 7. Linux service management — systemd

A service is a background process managed by the operating system's service manager.

| Command | Purpose |
|---|---|
| `systemctl status service` | Display service status |
| `systemctl start service` | Start a service |
| `systemctl stop service` | Stop a service |
| `systemctl restart service` | Restart a service |
| `systemctl reload service` | Reload service configuration if supported |
| `systemctl enable service` | Enable service at boot |
| `systemctl disable service` | Disable automatic startup |
| `systemctl is-active service` | Check whether service is running |
| `systemctl is-enabled service` | Check whether service starts at boot |

### Practical commands

```bash
systemctl status sshd

systemctl is-active sshd

systemctl is-enabled sshd

systemctl restart sshd
```

### Important distinction

- `start`: Starts the service now.
- `enable`: Configures the service to start automatically during boot.
- `restart`: Stops and starts the service.
- `reload`: Asks the service to reload its configuration without a full restart, if supported.

Never restart a production service without understanding the impact and following the change process.

---

## 8. Log monitoring and troubleshooting

Logs help identify errors, warnings and application failures.

### Common RHEL log files

| Log file | Purpose |
|---|---|
| `/var/log/messages` | General system messages |
| `/var/log/secure` | Authentication and security messages |
| `/var/log/cron` | Cron job activity |
| `/var/log/boot.log` | Boot messages |
| `/var/log/audit/audit.log` | Audit events |

Application logs may be stored in separate application-specific directories.

### Commands

```bash
cat /var/log/messages

tail -20 /var/log/messages

tail -f /var/log/messages

grep -i error /var/log/messages

grep -Ei "error|failed|warning" /var/log/messages

grep -in "failed" /var/log/messages
```

### journalctl commands

```bash
journalctl -xe

journalctl -u sshd

journalctl --since "1 hour ago"

journalctl --since "2026-11-09 08:00:00"

journalctl -p err
```

Useful for checking service failures and system events.

---

## 9. Network and port inspection

| Command | Purpose |
|---|---|
| `ss -lntp` | Display listening TCP ports and processes |
| `ss -tulnp` | Display listening TCP and UDP sockets |
| `hostname` | Display system hostname |

### Practical commands

```bash
hostname

ss -lntp

ss -tulnp
```

For listening TCP ports:
- `l`: Listening sockets.
- `n`: Numeric addresses and ports.
- `t`: TCP sockets.
- `p`: Process information (may require root privileges).

---

## 10. Basic Bash scripting

### Shebang

```bash
#!/bin/bash
```

Specifies that the script should be executed using Bash.

### Display output

```bash
echo "Hello DevOps"
```

### Variables

```bash
NAME="Linux"
echo "$NAME"
```

### Read user input

```bash
read -p "Enter your name: " NAME
echo "Hello $NAME"
```

### Command substitution

```bash
HOSTNAME=$(hostname)
echo "$HOSTNAME"
```

Command substitution captures the output of a command.

### Conditional statements

```bash
if [ "$VALUE" -ge 80 ]; then
    echo "WARNING"
else
    echo "NORMAL"
fi
```

### Numeric comparison operators

| Operator | Meaning |
|---|---|
| `-eq` | Equal |
| `-ne` | Not equal |
| `-gt` | Greater than |
| `-lt` | Less than |
| `-ge` | Greater than or equal |
| `-le` | Less than or equal |

### Exit status

```bash
ls
echo $?
```

- `0`: Usually indicates success.
- Non-zero: Usually indicates failure or another condition.

### Redirection

| Syntax | Purpose |
|---|---|
| `>` | Redirect output, overwriting the destination |
| `>>` | Append output |
| `2>` | Redirect standard error |
| `2>&1` | Redirect standard error to standard output |

Example:

```bash
date > output.txt

date >> output.txt

ls missingfile 2> error.log

command > output.log 2>&1
```

### Pipes

```bash
ps aux | head

ps aux --sort=-%cpu | head -10
```

The pipe `|` sends the output of one command to another command.

---

## 11. Text processing commands

| Command | Purpose |
|---|---|
| `grep` | Search for matching text |
| `sort` | Sort lines |
| `head` | Display beginning of output |
| `awk` | Process structured text and columns |
| `gsub()` | Replace matching text in awk |

### Examples

```bash
grep -i error application.log

sort names.txt

sort -rh sizes.txt

head -10 application.log
```

Extract root filesystem usage:

```bash
df -P / | awk 'NR==2 {
    gsub("%","",$5);
    print $5
}'
```

Explanation:
- `NR==2`: Select the second row.
- `$5`: Select the fifth column.
- `gsub("%","",$5)`: Remove the percent sign.
- `print $5`: Display the numeric usage.

---

## 12. Permissions and script execution

### Check permissions

```bash
ls -l server_health_check.sh
```

### Make script executable

```bash
chmod +x server_health_check.sh
```

### Execute script

```bash
./server_health_check.sh
```

The `x` permission allows the file to be executed by users with the appropriate permissions.

---

# 13. Day 01 practical process — Linux troubleshooting

Use this sequence when investigating a Linux server health issue.

### Scenario A: Server is slow

Step 1 — Check uptime and load:

```bash
uptime
```

Step 2 — Check CPU:

```bash
top
```

Step 3 — Identify CPU-consuming processes:

```bash
ps aux --sort=-%cpu | head -10
```

Step 4 — Check memory:

```bash
free -h
vmstat 1 5
```

Step 5 — Check disk:

```bash
df -h
df -i
```

Step 6 — Investigate relevant logs:

```bash
journalctl -p err
tail -50 /var/log/messages
```

Step 7 — Identify the root cause before taking corrective action.

### Scenario B: Application service is down

Step 1 — Check service status:

```bash
systemctl status application.service
```

Step 2 — Check service logs:

```bash
journalctl -u application.service -n 50
```

Step 3 — Check port availability:

```bash
ss -lntp
```

Step 4 — Check disk and memory:

```bash
df -h
free -h
```

Step 5 — Investigate the failure reason.

Step 6 — Apply an approved corrective action.

Step 7 — Verify:

```bash
systemctl is-active application.service
```

---

# 14. Day 01 project — Server Health Monitoring

### Objective

Create a Bash script to automatically collect Linux server health information and save it in timestamped log files.

### Project location

```text
Week-01-Linux/
├── README.md
├── commands.md
├── scripts/
│   ├── server_health_check.sh
│   └── logs/
└── troubleshooting/
```

### Script development process

Step 1 — Create project directories:

```bash
mkdir -p Week-01-Linux/scripts
```

Step 2 — Create the script:

```bash
vi Week-01-Linux/scripts/server_health_check.sh
```

Step 3 — Add the Bash script.

Step 4 — Save and exit the editor.

Step 5 — Provide execution permission:

```bash
chmod +x Week-01-Linux/scripts/server_health_check.sh
```

Step 6 — Execute:

```bash
./Week-01-Linux/scripts/server_health_check.sh
```

Step 7 — Verify log generation:

```bash
ls -lh Week-01-Linux/scripts/logs/
```

Step 8 — Read the generated report:

```bash
cat "$(ls -t Week-01-Linux/scripts/logs/health_*.log | head -1)"
```

### Features implemented

- Hostname and kernel information.
- CPU core count and load information.
- Memory report.
- Disk utilization.
- Inode utilization.
- Top CPU-consuming processes.
- Root filesystem threshold check.
- SSH service status check.
- Timestamped logging.

---

# 15. Git and GitHub commands learned

Git helps track changes to your code. GitHub hosts your Git repository online.

| Command | Purpose |
|---|---|
| `git --version` | Check Git version |
| `git config --list` | Display Git configuration |
| `git config --global user.name` | Configure Git username |
| `git config --global user.email` | Configure Git email |
| `git clone URL` | Download a repository |
| `git remote -v` | Display remote repositories |
| `git status` | Check file changes |
| `git branch` | Display branches |
| `git add .` | Stage changes |
| `git add filename` | Stage a particular file |
| `git commit -m "message"` | Save a commit |
| `git push origin main` | Push commits to GitHub |
| `git pull origin main` | Fetch and integrate remote changes |
| `git log --oneline` | Display compact commit history |

### Git workflow

Step 1 — Check status:

```bash
git status
```

Step 2 — Stage files:

```bash
git add .
```

Step 3 — Verify staged changes:

```bash
git status
```

Step 4 — Commit:

```bash
git commit -m "Add Linux monitoring project"
```

Step 5 — Push:

```bash
git push origin main
```

Step 6 — Verify:

```bash
git status
git log --oneline
```

### Important Git concepts

- Working directory: Where you modify files.
- Staging area: Where you prepare changes.
- Commit: A saved snapshot of staged changes.
- Repository: Git's tracked project history.
- Remote: The hosted repository, such as GitHub.
- Branch: An independent line of development.

### GitHub authentication

For HTTPS authentication, use a Personal Access Token or an approved sign-in method instead of your GitHub account password.

Never store tokens in source code or commit them to GitHub.

---

# 16. Important interview revision questions

1. What is the difference between a process and a program?
2. What are PID and PPID?
3. What is a zombie process?
4. What is the difference between CPU utilization and load average?
5. What is the difference between free memory and available memory?
6. What is swap?
7. What is the difference between `df -h` and `du -sh`?
8. What is the difference between `df -h` and `df -i`?
9. What is the difference between `systemctl start` and `systemctl enable`?
10. How do you investigate a failed Linux service?
11. How do you identify the process consuming the most CPU?
12. What is the purpose of `journalctl`?
13. What is the difference between `>` and `>>`?
14. What does `$?` represent?
15. What is the purpose of `chmod +x`?
16. What is the difference between Git and GitHub?
17. What are `git add`, `git commit` and `git push`?
18. What is the purpose of a `.gitignore` file?

---

# 17. Day 01 completion summary

By completing Day 01, I practised:

- Linux filesystem navigation and file management.
- Process and CPU monitoring.
- Memory and disk troubleshooting.
- systemd service management.
- Log inspection and error identification.
- Basic Bash scripting and conditional statements.
- Linux script permissions and execution.
- Git version control and GitHub publishing.
- Building and publishing a Linux server health monitoring project.

**Next learning area:** Git fundamentals, Bash scripting improvements and Linux automation.
