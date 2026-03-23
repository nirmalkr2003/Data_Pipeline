#!/bin/bash

LOG_FILE="../logs/pipeline.log"
DATA_FILE="../data/data.csv"
OUTPUT_FILE="../outputs/filtered.csv"
SUMMARY_FILE="../outputs/summary.json"

URL="https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv"

echo "Pipeline started at $(date)" >> $LOG_FILE

# Create folders
mkdir -p ../data ../logs ../outputs

# Setup virtual environment
if [ ! -d "../venv" ]; then
    python3 -m venv ../venv
fi

source ../venv/bin/activate

pip install pandas >> $LOG_FILE 2>&1

# Download data
if ! curl -o $DATA_FILE $URL; then
    echo "Download failed!" >> $LOG_FILE
    exit 1
fi

# Run Python script
python3 process.py $DATA_FILE $OUTPUT_FILE $SUMMARY_FILE >> $LOG_FILE 2>&1

echo "Pipeline finished at $(date)" >> $LOG_FILE
