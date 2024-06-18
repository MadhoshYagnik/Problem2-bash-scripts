#!/bin/bash

# Configuration
backup_dir="/home/madhosh-yagnik/Downloads/"  # Directory to backup
bucket_name="localbackupscript" # S3 bucket name
report_file="/home/madhosh-yagnik/backup_report_$(date +"%Y-%m-%d").log"  # Report file with current date

# Function to perform backup
perform_backup() {
    local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    local backup_filename="backup_$timestamp"
    local backup_path="$backup_dir/$backup_filename"

    # Ensure backup directory exists
    mkdir -p "$backup_path"

    # Copy raw files from backup directory to temporary directory
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Copying raw files to temporary backup directory..."
    cp -r "$backup_dir"/* "$backup_path/"

    # Upload the backup directory to S3 (recursively)
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Uploading backup to S3..."
    aws s3 sync "$backup_path" "s3://$bucket_name/$backup_filename"

    # Check if upload was successful
    if [ $? -eq 0 ]; then
        echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup successfully uploaded to S3."
        echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup operation succeeded." >> "$report_file"
    else
        echo "[$(date +"%Y-%m-%d %H:%M:%S")] Failed to upload backup to S3."
        echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup operation failed." >> "$report_file"
    fi

    # Clean up temporary backup directory
    rm -rf "$backup_path"
}

# Main script execution
echo "===== Backup Script ====="
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Starting backup process..."

# Perform backup and capture the result
perform_backup

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup process completed."

