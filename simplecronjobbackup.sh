#!/bin/bash

# simplecronjobbackup.sh
# Version: 1.0
# Author: drhdev
# Description: Backup crontab entries to a text file in the user's directory.
# License: GNU General Public License
# Usage example:
# 1. Copy to /usr/local/bin
# 2. Modify options in script as needed.
# 3. 'chmod +x /usr/local/bin/simplecronjobbackup.sh'
# 4. './simplecronjobbackup.sh'
# 5. Optional: add to crontab with 'crontab -e' and enter '0 0 * * * /usr/loacl/bin/simplecronjobbackup.sh'
# Quickstart: sudo sh -c 'curl -o /usr/local/bin/simplecronjobbackup.sh https://raw.githubusercontent.com/drhdev/simplecronjobbackup/main/simplecronjobbackup.sh && chmod +x /usr/local/bin/simplecronjobbackup.sh'; (crontab -l 2>/dev/null; echo "0 0 * * * /usr/local/bin/simplecronjobbackup.sh") | crontab -

# Configurable path for saving the backup txt file
BACKUP_PATH="${HOME}/cronjob_backups"
# Configurable backup file name. Default is 'cronjob_backup' followed by date and time
BACKUP_FILE_NAME="cronjob_backup_$(date +'%Y-%m-%d_%H-%M-%S').txt"
# Maximum number of old backups to keep
MAX_BACKUPS=10

# Create backup directory if it does not exist
mkdir -p "${BACKUP_PATH}"

# Function to manage backup retention
manage_backups() {
  # If the number of backups exceed the MAX_BACKUPS, delete the oldest
  while [ $(ls -1 ${BACKUP_PATH}/*.txt | wc -l) -gt ${MAX_BACKUPS} ]; do
    local oldest_backup=$(ls -1 ${BACKUP_PATH}/*.txt | head -n 1)
    echo "Deleting oldest backup: ${oldest_backup}"
    rm "${oldest_backup}"
  done
}

# Function to create a backup of the current crontab
create_backup() {
  {
    echo "# Server name: $(hostname)"
    echo "# Backup date and time: $(date)"
    crontab -l
  } > "${BACKUP_PATH}/${BACKUP_FILE_NAME}"
}

# Main script execution
{
  manage_backups
  create_backup
} &> /dev/null

# Check if the last command succeeded
if [ $? -eq 0 ]; then
  echo "Crontab backup was successful."
else
  echo "An error occurred during the backup process."
fi
