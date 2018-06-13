#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
file=mysqldata/reduced.sql.gz
if [ ! -f $file ]; then
    echo "File $file not found! We will download it."
    wget https://www.statistik.tu-dortmund.de/~richter/reduced.sql.gz -O $file
fi
if command -v pv >/dev/null; then
  zcat $file | pv --progress --size `gzip -l $file | sed -n 2p | awk '{print $2}'` --name 'Importing...' | ./import-data.sh
else
  zcat $file | ./import-data.sh
fi
