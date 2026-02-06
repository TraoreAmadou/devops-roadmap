# Simple Monitoring Dashboard (Netdata)

https://roadmap.sh/projects/simple-monitoring-dashboard

This project sets up a **basic monitoring dashboard** using **Netdata** to visualize real-time system metrics (CPU, memory, disk I/O) and includes simple automation scripts to install Netdata, generate load for testing, and cleanly remove it.

## What you will learn
- Installing Netdata on a Linux server
- Accessing the Netdata dashboard from a browser
- Observing core metrics: **CPU**, **RAM**, **Disk I/O**
- Generating system load to validate monitoring graphs
- Cleaning up the system and removing an installed agent

---

## Requirements
- Linux machine (VM or server)
- `sudo` privileges
- Internet access (to download Netdata installer)
- Tools used by scripts:
  - `wget` (or replace with `curl`)
  - `systemctl` (systemd-based distros recommended)

---

## Files
- **`setup.sh`**: Installs Netdata on a new system.
- **`test_dashboard.sh`**: Generates CPU + disk I/O load to test the dashboard.
- **`cleanup.sh`**: Removes Netdata and cleans related files.

---

## Quick Start

### 1) Make scripts executable
```bash
chmod +x setup.sh test_dashboard.sh cleanup.sh
```

### 2) Install Netdata
```bash
./setup.sh
```

### 3) Open the dashboard
On the same machine:
- `http://localhost:19999`

From another machine (replace with server IP):
- `http://<server-ip>:19999`

### 4) Generate load and test charts
```bash
./test_dashboard.sh
```

You should see activity in charts such as:
- CPU usage
- System load
- Disk read/write
- Memory usage

### 5) Cleanup (remove Netdata)
```bash
./cleanup.sh
```

---

## Script Details

### setup.sh
- Installs Netdata using the official installer.
- Uses non-interactive mode so it runs without prompts.
- If Netdata is already installed, it prints a message and exits.

### test_dashboard.sh
- Uses `stress` if installed (or installs it if possible).
- If `stress` is not available, falls back to:
  - CPU load via `yes`
  - Disk I/O via `dd`

### cleanup.sh
- Stops and disables the Netdata service (best effort).
- Uninstalls Netdata (best effort).
- Removes common leftover directories:
  - `/etc/netdata`
  - `/var/lib/netdata`
  - `/var/cache/netdata`
  - `/var/log/netdata`
  - `/opt/netdata`

---

## Verifying Netdata is Removed
After running `cleanup.sh`, you can check:

### Service
```bash
systemctl status netdata
systemctl list-unit-files | grep -i netdata
```

### Port 19999 is closed
```bash
sudo ss -lntp | grep ':19999'
```

### No running process
```bash
pgrep -a netdata
```

---

## Notes
- Netdata listens on port **19999** by default.
- If you run on a remote server, make sure your firewall/security group allows access to port **19999** (or use SSH port forwarding).
- If `wget` is not available, you can download with `curl` instead:
  ```bash
  curl -o /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh
  ```

---

## License
This project is provided for learning purposes.



