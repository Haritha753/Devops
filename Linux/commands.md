- uptime : Display system load averages
- nproc : Display available CPU cores
- lscpu : Display CPU architecture information

## Memory Monitoring

- free -h : Display memory usage
- vmstat 1 5 : Display memory and system statistics

## Disk Monitoring

- df -h : Check filesystem disk usage
- df -i : Check inode usage
- du -sh : Check directory size

## Service Management

- systemctl status sshd
- systemctl is-active sshd
- journalctl -u sshd
