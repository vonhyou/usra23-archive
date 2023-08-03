#!/bin/bash

# Find all pcap files in the current directory and its subdirectories
find . -name "*.pcap" -type f | while read -r pcap_file; do
  # Get the directory, filename, and extension of the pcap file
  dir=$(dirname "$pcap_file")
  base=$(basename "$pcap_file")
  filename="${base%.*}"
  
  # Create a new directory with the same name as the pcap file
  mkdir -p "$dir/$filename"
  
  # Move the pcap file into the new directory
  mv "$pcap_file" "$dir/$filename/"
 
  # Run Tranalyzer on the pcap file to create a flow report
  tranalyzer -r "$dir/$filename/$base"
  
  # Convert the Tranalyzer flow report into a CSV file
  sed 's/\t\|;/,/g' "$dir/$filename/${filename}_flows.txt" > "$dir/$filename/${filename}_flows.csv"
done

