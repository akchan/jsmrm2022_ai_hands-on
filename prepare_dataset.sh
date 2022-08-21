#!/bin/bash

# Usage
# =====
# 
# '''
# . ./prepare_dataset.sh
# '''
# 


set -eu


# CHAOS train dataset
dataset_url="https://zenodo.org/record/3431873/files/CHAOS_Train_Sets.zip?download=1"
dataset_zip_name="CHAOS_Train_Sets.zip"

# Change working directory
dataset_local_dir="JSMRM2022_CHAOS_partial"
script_dir="$(cd "$(dirname "$0")"; pwd)"
base_dir="${script_dir}/dataset"
dir_tmp="$(pwd)"

mkdir -p "${base_dir}/CHAOS"
cd "${base_dir}/CHAOS"

# Prepare dataset
curl "${dataset_url}" > "${base_dir}/${dataset_zip_name}"
unzip -u "${dataset_zip_name}"

find "${base_dir}/Train_Sets/MR" -type d -depth 1 |while read -r case_dir
do
    echo "${case_dir}"
    case_num=$(basename "${case_dir}")
    mkdir -p "${dataset_local_dir}/${case_num}"
    find "${case_dir}" -type f -path "*InPhase*" -name "*.dcm" -exec cp {} "${dataset_local_dir}/${case_num}" \;
done

# Restore working directory
cd "${dir_tmp}"
