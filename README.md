# System Health Monitoring Script

This Bash script monitors system health by checking CPU usage, memory usage, disk space, and the number of running processes. If any of these metrics exceed predefined thresholds, an alert is generated in the logs.

## Features

- **CPU Usage Monitoring**: Checks if CPU usage exceeds a specified threshold percentage.
- **Memory Usage Monitoring**: Monitors memory usage and alerts if it exceeds a defined threshold percentage.
- **Disk Space Monitoring**: Alerts if disk space usage exceeds a specified threshold percentage.
- **Process Count Monitoring**: Alerts if the number of running processes exceeds a specified threshold count.

## Configuration

Adjust the following thresholds in the script (`systemMonitoring.sh`) as per your requirements:

- **CPU_THRESHOLD**: Threshold for CPU usage in percent.
- **MEMORY_THRESHOLD**: Threshold for memory usage in percent.
- **DISK_THRESHOLD**: Threshold for disk space usage in percent.
- **PROCESS_THRESHOLD**: Threshold for the number of running processes.

## Usage

1. **Clone the Repository**: Clone or download this repository to your local machine.

2. **Modify Thresholds**: Open the script (`systemMonitoring.sh`) and adjust the threshold variables (`CPU_THRESHOLD`, `MEMORY_THRESHOLD`, `DISK_THRESHOLD`, `PROCESS_THRESHOLD`) according to your monitoring requirements.

3. **Run the Script Manually**:
   ```bash
   bash systemMonitoring.sh
   ```
   The script will perform checks based on the defined thresholds and print alerts to the console if thresholds are exceeded.

4. **Configure Cron Job**:
   To run the script periodically, configure a cron job as follows:

   ```
   # Cron job for system health monitoring script
   * * * * * /home/madhosh-yagnik/systemMonitoring.sh > /home/madhosh-yagnik/system-monitoring.log 2>&1
   ```
   This cron job runs the `systemMonitoring.sh` script every minute and logs the output to `system-monitoring.log`.

5. **Review Logs**:
   Check the log file (`system-monitoring.log`) to monitor the script's output and any alerts generated based on threshold breaches.

## Notes

- Ensure the script (`systemMonitoring.sh`) has execute permissions set (`chmod +x systemMonitoring.sh`).
- Regularly monitor the script's output and adjust thresholds as needed based on system performance and resource usage patterns.

## Example Output

Example output in `system-monitoring.log`:

```
ALERT: CPU usage is high: 6.3%
ALERT: Memory usage is high: 15.00%
ALERT: Disk usage is high: 7%
ALERT: Number of running processes is high: 424
ALERT: CPU usage is high: 4.4%
ALERT: Memory usage is high: 15.00%
ALERT: Disk usage is high: 7%
ALERT: Number of running processes is high: 419
...
```

# Bash Backup to S3 Script

Please find the two attached .png files for proof of concept. backup script s3 poc.png and backup script s3 poc 2.png  
This Bash script automates the process of backing up files from a local directory to an Amazon S3 bucket.

## Features

- Copies files from a specified local directory to a temporary backup directory.
- Syncs the backup directory contents to an S3 bucket using AWS CLI.
- Logs backup operations, including success or failure, to a daily report file.

## Requirements

- **AWS CLI**: Ensure AWS Command Line Interface is installed and configured with appropriate permissions and credentials for S3 access.

## Configuration

- **Local Directory**: `/home/madhosh-yagnik/Downloads/`
  - Update `backup_dir` variable in the script (`backup_to_s3.sh`) to specify your local directory.

- **S3 Bucket**: `localbackupscript`
  - Update `bucket_name` variable in the script (`backup_to_s3.sh`) to specify your S3 bucket name.

- **Report File**: `/home/madhosh-yagnik/backup_report_<date>.log`
  - The script generates a daily report file with backup operation details.
  - Ensure the path is writable and accessible.

## Usage

1. **Clone the Repository**: Clone or download this repository to your local machine.

2. **Configure AWS CLI**: Ensure AWS CLI is configured with credentials that have access to your S3 bucket.

3. **Modify Script Variables**: Open the script (`backup_to_s3.sh`) and update the `backup_dir` and `bucket_name` variables according to your setup.

4. **Run the Script**:
   ```bash
   bash backup_to_s3.sh
   ```
   The script will start backing up files from the specified local directory to your S3 bucket. Check the logs for progress and completion messages.

5. **Review Backup Report**:
   The backup report file (`backup_report_<date>.log`) is updated with each backup in the specified directory. The report includes timestamps and success/failure status of backup operations.

## Cron Job Setup

To schedule daily backups at 12:00 PM noon using cron:

```
0 12 * * * /path/to/backup_to_s3.sh >> /path/to/backup_log.log 2>&1
```

This cron job runs the `backup_to_s3.sh` script daily at 12:00 PM and appends output to `backup_log.log`. Adjust paths (`/path/to/...`) in the cron job command to match your environment.

## Notes

- Ensure the script (`backup_to_s3.sh`) has execute permissions set (`chmod +x backup_to_s3.sh`).
- Regularly monitor S3 usage and adjust retention policies and storage tiers as needed.
