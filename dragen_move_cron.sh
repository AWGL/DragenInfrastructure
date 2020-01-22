#!/bin/sh
set -euo pipefail

#Description: move novaseq data from raw to appropiate folder
#Author: Joseph Halstead
#Date: 20/01/20
version="1.0.0"

for path in $(find /data/raw/novaseq -maxdepth 2 -mindepth 2 -type f -name "RTAComplete.txt" -exec dirname '{}' \;); do


  if [ -f "$path"/dragen-complete ]; then

  runid=$(basename "$path")
  machine=$(echo $runid | awk -F"_" '{print $2}')
  echo $machine
  echo $runid


  if [[ $machine =~ "D" ]]
    then

    echo "It's Hiseq!"
    mv $path /data/archive/hiseq  
    chown -R transfer /data/archive/hiseq/"$runid"
    chgrp -R transfer /data/archive/hiseq/"$runid"
    chmod -R 755 /data/archive/hiseq/"$runid"

  elif [[ $machine =~ "M" ]]
    then

    echo "It's Miseq!"
    mv $path /data/archive/miseq
    chown -R transfer /data/archive/miseq/"$runid"
    chgrp -R transfer /data/archive/miseq/"$runid"
    chmod -R 755 /data/archive/miseq/"$runid"

  elif [[ $machine =~ "A" ]]
    then

    echo "It's Novaseq!"
    mv $path /data/archive/novaseq/BCL   
    chown -R transfer /data/archive/novaseq/BCL/"$runid"
    chgrp -R transfer /data/archive/novaseq/BCL/"$runid"
    chmod -R 755 /data/archive/novaseq/BCL/"$runid"


  elif [[ $machine =~ "NB" ]]
   then

   echo "It's Nextseq!"
   mv $path /data/archive/nextseq/
   chown -R transfer /data/archive/nextseq/"$runid"
   chgrp -R transfer /data/archive/nextseq/"$runid"
   chmod -R 755 /data/archive/nextseq/"$runid"
  

  fi

  fi

done

