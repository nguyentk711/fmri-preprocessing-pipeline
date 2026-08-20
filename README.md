# fmri-preprocessing-pipeline
A pipeline for preprocessing fMRI data using fMRIprep and other QA-QC tools


Please note the following folder tree:
```text
/Users/NGUYEN_BIBO/Desktop/fMRI
├── ADNI
├── config.json
├── data_bids
├── license.txt
├── preprocessing
├── run_dcm2bids.sh
├── run_fMRIprep.sh
└── working
```
With the following thing:
- ADNI: folder contains the raw data downloaded from ADNI IDA database.
- config.json: config file for dcm2bids package.
- data_bids: folder contains the data after dcm2bids (nifti files with BIDS directory):
  ```text
  /Users/NGUYEN_BIBO/Desktop/fMRI/data_bids
  ├── CHANGES
  ├── README
  ├── code
  ├── dataset_description.json
  ├── derivatives
  ├── participants.json
  ├── participants.tsv
  ├── sourcedata
  ├── sub-4654
  ├── sub-4799
  └── tmp_dcm2bids
  ```
- license.txt: FS license for fMRIprep.
- preprocessing: the python venv including fmriprep-docker, dcm2bids.
- run_dcm2bids.sh & run_fMRIprep.sh: bash script to run dcm2bids and fMRIprep, respectively.
- working: work directory for fMRIprep.    
