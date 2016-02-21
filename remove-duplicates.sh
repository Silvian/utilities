#!/bin/bash
# takes directory path of the cleaning entry point as param

cd $1
find . -type f -exec gawk '
  {
    cmd="md5sum " q FILENAME q
    cmd | getline cksm
    close(cmd)
    sub(/ .*$/,"",cksm)
    if(a[cksm]++) {
      if(!test -d FILENAME) {
        cmd="rm " q FILENAME q
        system(cmd)
        close(cmd)
      }
    }
    nextfile
  }' q='"' {} +
