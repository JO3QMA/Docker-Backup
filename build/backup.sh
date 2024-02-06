#!/bin/bash
SOURCE_BASE_PATH="/data"
BACKUP_BASE_PATH="/backup"
BACKUP_TMP_PATH="/backup/_tmp"

function backup_tmp () {
  backup_name=$(cut -d"/" -f3- <<< "${1}")

  source_path="${SOURCE_BASE_PATH}/${backup_name}"
  backup_path="${BACKUP_TMP_PATH}/${backup_name}"
  mkdir -p "${backup_path}"
  rsync --stats -a --delete "${source_path}" "${backup_path}"
}

function compress_targz () {
  backup_name=$(cut -d"/" -f3- <<< "${1}")
  backup_date=$(date +'%Y%m%d')
  backup_time=$(date +'%H%M%S')

  source_path="${BACKUP_TMP_PATH}/${backup_name}"
  backup_dir="${BACKUP_BASE_PATH}/${backup_name}/${backup_date}"
  backup_name="${backup_name}_${backup_date}_${backup_time}.tar.gz"

  mkdir -p "${backup_dir}"
  tar -C "${backup_dir}"-zcvf "${backup_dir}/${backup_name}" "${source_path}"
}

for dir in "${SOURCE_BASE_PATH}"/*; do
  [[ -e "${dir}" ]] || break
  echo "===== Start Backup ${dir} ====="
  backup_tmp "${dir}"
  compress_targz "${dir}"
  echo "===== End Backup ${dir} ====="
done