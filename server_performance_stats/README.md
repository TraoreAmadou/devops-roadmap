
# Server Performance Stats

This project provides a simple **Bash script** that prints basic server performance statistics. It helps you quickly understand the health and resource usage of a Linux system.

The script reports:

* Total CPU usage
* Memory usage (Total / Used / Free / Available + percentages)
* Disk usage for `/` (Total / Used / Free + percentages)
* Top 5 processes by CPU usage
* Top 5 processes by memory usage
* Extra system info (OS, kernel, uptime, load average, logged-in users, failed login attempts)

---

## Requirements

* Linux system
* `bash`
* Commands/tools used by the script:

  * `top`, `free`, `df`, `ps`, `awk`, `cut`, `uptime`, `hostname`, `uname`, `who`
  * `lsb_release` (for OS description)
  * Access to `/var/log/auth.log` (failed login count; may require `sudo` depending on permissions)

---

## Files

* **`server-stats.sh`**: the monitoring script (Bash)

---

## Usage

### 1) Make the script executable

```bash
chmod +x server-stats.sh
```

### 2) Run it

```bash
./server-stats.sh
```

---

## Output (what you will see)

The script prints sections similar to:

* CPU usage summary
* Memory usage summary (with percentages)
* Disk usage summary for `/`
* Top processes by CPU and memory
* System details: OS, hostname, kernel, uptime, load average, logged users, failed logins

---

## How it works (high-level)

### CPU usage

* Uses `top -bn1` to extract the CPU idle percentage (`id`).
* CPU used is calculated as:

  ```
  CPU_used = 100 - CPU_idle
  ```

### Memory usage

* Uses `free -m` (MB) and extracts:

  * total
  * used
  * free
  * available
* Calculates percentages using `awk`.

### Disk usage

* Uses `df -h /` to get total/used/free on the root filesystem (`/`).

### Top processes

* Uses `ps` sorted by `%cpu` and `%mem`, then displays the top 5.

### Extra system stats

* OS name via `lsb_release -d`
* Uptime via `uptime -p`
* Load average via `/proc/loadavg`
* Logged-in users via `who | wc -l`
* Failed logins via `grep "Failed password" /var/log/auth.log | wc -l`

---

## Notes

* On some systems, `lsb_release` might not be installed. If needed:

  * Debian/Ubuntu:

    ```bash
    sudo apt-get update && sudo apt-get install -y lsb-release
    ```
* Reading `/var/log/auth.log` may require root permissions depending on your system.

---

## License

This project is provided for learning purposes.


