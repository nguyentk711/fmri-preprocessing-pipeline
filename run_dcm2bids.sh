#!/bin/bash

# Define your paths (change these if your folders have different names)
SOURCE_DIR=~/Desktop/fMRI/data_bids/sourcedata/ADNI
CONFIG_FILE=~/Desktop/fMRI/config.json
OUTPUT_DIR=~/Desktop/fMRI/data_bids

echo "Starting parallel BIDS conversion..."

# Loop through every directory inside the ADNI folder
for subj_dir in "$SOURCE_DIR"/*/; do
    
    # 1. Clean up the path and get the folder name
    subj_dir=${subj_dir%/}                 # Remove trailing slash
    subj_folder=$(basename "$subj_dir")    # Extract just "002_S_4654"
    
    # 2. Strip the underscores for BIDS compliance
    bids_id=${subj_folder##*_}             # Becomes "002S4654"
    
    echo "Launching dcm2bids for: $bids_id"
    
    # 3. Run dcm2bids in the background
    # The '&' at the end of the line tells bash to run this immediately 
    # without waiting for it to finish, allowing the loop to start the next subject.
    dcm2bids -d "$subj_dir" -p "$bids_id" -c "$CONFIG_FILE" -o "$OUTPUT_DIR" &

done

# 4. Wait for all background tasks to finish before exiting
wait

echo "All subjects have been successfully processed!"