# Simple Cronjob Backup

This repository contains the `simplecronjobbackup.sh` script, designed to backup crontab entries of the current user into a text file within the user's directory. This script allows for configurable backup paths, filenames, and the maximum number of backups to retain, automatically deleting the oldest backup when this limit is exceeded.

## Features

- **Configurable Backup Path**: Set where the backup files should be stored.
- **Customizable Backup Filename**: Define how the backup files are named, incorporating the date and time to ensure uniqueness.
- **Backup Retention**: Specify the maximum number of backup files to keep, with the script automatically managing old backups.
- **Error Handling**: The script checks for errors during the backup process and notifies the user of success or failure.

## Installation

1. Clone this repository or download the `simplecronjobbackup.sh` script directly.
2. Make the script executable:
   ```bash
   chmod +x simplecronjobbackup.sh
   ```
3. (Optional) Edit the script to customize the backup path, file name, and maximum backups according to your preferences.

## Usage

Run the script manually from the command line:
```bash
./simplecronjobbackup.sh
```

### Automating Backups with Cron

To schedule automatic backups, add a cron job that executes the script at your desired frequency.

1. Open your crontab configuration:
   ```bash
   crontab -e
   ```
2. Add a line defining when and how often the script should run. For example, to run daily at midnight:
   ```
   0 0 * * * /path/to/simplecronjobbackup.sh
   ```
   Replace `/path/to/` with the actual path to the script.

## Configuration Options

- `BACKUP_PATH`: Directory where backup files are stored.
- `BACKUP_FILE_NAME`: Naming pattern for backup files, including the date and time.
- `MAX_BACKUPS`: Maximum number of backup files to retain.

## Quickstart Command (with all default options)

```bash 
sudo sh -c 'curl -o /usr/local/bin/simplecronjobbackup.sh https://raw.githubusercontent.com/drhdev/simplecronjobbackup/main/simplecronjobbackup.sh && chmod +x /usr/local/bin/simplecronjobbackup.sh && (crontab -l 2>/dev/null; echo "0 0 * * * /usr/local/bin/simplecronjobbackup.sh") | crontab -'
```


## License

This project is licensed under the GNU General Public License.
