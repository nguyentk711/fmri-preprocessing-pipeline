#!/bin/bash

# Define your paths (change these if your folders have different names)
SOURCE_DIR=~/Desktop/fMRI/data_bids/sourcedata/ADNI
CONFIG_FILE=~/Desktop/fMRI/config.json
OUTPUT_DIR=~/Desktop/fMRI/data_bids
LOG_FILE=~/Desktop/fMRI/missing_dir_sub.txt

echo "Starting BIDS conversion..."

# Loop through every directory inside the ADNI folder
for subj_dir in "$SOURCE_DIR"/*/; do
    
    # 1. Clean up the path and get the folder name (e.g. 002_S_4654)
    subj_dir=${subj_dir%/}                 # Remove trailing slash (e.g. path/to/fmri/002_S_4654/ --> path/to/fmri/002_S_4654)
    subj_folder=$(basename "$subj_dir")    # Extract just "002_S_4654" (e.g. path/to/fmri/002_S_4654 --> 002_S_4654)
    
    # 2. Strip the underscores for BIDS compliance
    bids_id=${subj_folder##*_}             # Becomes "4654" (e.g. 002_S_4654 --> 4654)
    
    echo "Launching dcm2bids for: $bids_id"
    
    # 3. Run dcm2bids in the background
    dcm2bids -d "$subj_dir" -p "$bids_id" -c "$CONFIG_FILE" -o "$OUTPUT_DIR"

    if ! ([ -d "$OUTPUT_DIR/sub-${bids_id}/anat" ] && [ -d "$OUTPUT_DIR/sub-${bids_id}/func" ]); then
        if [ -d "$OUTPUT_DIR/sub-${bids_id}/anat" ]; then
            echo "sub-${bids_id}: missing func" >> "$LOG_FILE"
        elif [ -d "$OUTPUT_DIR/sub-${bids_id}/func" ]; then
            echo "sub-${bids_id}: missing anat" >> "$LOG_FILE"
        else
            echo "sub-${bids_id}: missing both anat and func" >> "$LOG_FILE"
        fi
    fi
done

echo "All subjects have been successfully processed!"
