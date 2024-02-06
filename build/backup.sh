#!/bin/bash
SOURCE_BASE_PATH="/data"
BACKUP_BASE_PATH="/backup"
BACKUP_TMP_PATH="/backup/_tmp"

function backup () {
  backup_name=$(cut -d"/" -f3- <<< "${1}")
  backup_date=$(date +'%Y%m%d')
  backup_time=$(date +'%H%M%S')

  source_path="${SOURCE_BASE_PATH}/${backup_name}"
  backup_path="${BACKUP_BASE_PATH}/${backup_name}/${backup_date}/${backup_name}_${backup_date}_${backup_time}"
  mkdir -p "${backup_path}"
  rsync --stats -a "${source_path}" "${backup_path}"
}

for dir in "${SOURCE_BASE_PATH}"/*; do
  [[ -e "${dir}" ]] || break
  echo "===== Start Backup ${dir} ====="
  backup "${dir}"
  echo "===== End Backup ${dir} ====="
done