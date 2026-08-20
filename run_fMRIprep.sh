#!/bin/bash

#Define paths
INPUT_DIR=~/Desktop/fMRI/data_bids
FS_LICENSE=~/Desktop/fMRI/license.txt
OUTPUT_DIR=~/Desktop/fMRI/data_bids/derivatives
WORK_DIR=~/Desktop/fMRI/working

SUBJECTS=("4654" "4799")

for SUBJ in "${SUBJECTS[@]}"; do

	echo "========================================================"
	echo " Starting fmriprep-docker for sub-${SUBJ}..."
	echo "============================^v^========================="


	fmriprep-docker $INPUT_DIR $OUTPUT_DIR participant \
		  --participant-label $SUBJ \
		  -w ${WORK_DIR}/sub-${SUBJ} \
		  --fs-license-file $FS_LICENSE \
		  --output-spaces MNI152NLin2009cAsym:res-2 \
		  --fs-no-reconall \
		  --stop-on-first-crash

	echo " Finished sub-${SUBJ}!"

done

echo "All subjects are complete."
