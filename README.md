# DevOps Projects (roadmap.sh)


https://roadmap.sh/projects/server-stats

https://roadmap.sh/projects/log-archive-tool


This repository contains my hands-on DevOps projects based on the **roadmap.sh DevOps projects** track. Each project is stored in its own folder with scripts and a dedicated README.

> Goal: practice real DevOps fundamentals (Linux, scripting, automation, monitoring) by building small, usable tools.

---

## Repository Structure

```
.
├── 01-server-performance-stats/
│   ├── server-stats.sh
│   └── README.md
│
├── 02-log-archive-tool/
│   ├── log-archive.sh
│   └── README.md
│
├── 03-simple-monitoring-dashboard-netdata/
│   ├── setup.sh
│   ├── test_dashboard.sh
│   ├── cleanup.sh
│   └── README.md
│
└── README.md
```

---

## Projects

### 01) Server Performance Stats

**Goal:** Write a Bash script to display basic server performance statistics.

**What it includes:**

* CPU usage
* Memory usage (Total/Used/Free/Available + %)
* Disk usage for `/`
* Top 5 processes by CPU and memory
* Extra system information (OS, uptime, load average, users, failed logins)

**Folder:** `01-server-performance-stats/`

---

### 02) Log Archive Tool

**Goal:** Build a CLI tool to compress logs into a timestamped archive and keep a history.

**What it includes:**

* Archive logs into `tar.gz` with date/time in filename
* Store archives under `./log_archives/`
* Append entries to `archive.log`
* Optional: schedule runs using `cron`

**Folder:** `02-log-archive-tool/`

---

### 03) Simple Monitoring Dashboard (Netdata)

**Goal:** Install Netdata and validate monitoring with automated scripts.

**What it includes:**

* Install Netdata (`setup.sh`)
* Generate CPU + disk I/O load for testing (`test_dashboard.sh`)
* Remove Netdata and clean leftovers (`cleanup.sh`)

**Folder:** `03-simple-monitoring-dashboard-netdata/`

---

## Upcoming Projects

This section will grow as new projects are added.

* 4. (Coming soon)
* 5. (Coming soon)

---

## How to Run a Project

1. Go into the project folder.
2. Read the project README.
3. Make scripts executable:

```bash
chmod +x *.sh
```

4. Run the scripts as described.

---

## Notes

* Some scripts require `sudo` to access system logs or install packages.
* Tested on Linux environments (Ubuntu/Debian preferred, but scripts aim to stay portable).

---

## License

This repository is provided for learning purposes.

