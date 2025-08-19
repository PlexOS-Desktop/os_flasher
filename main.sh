#!/bin/bash

echo "WE ARE NOT RESPONSIBLE FOR ANY KIND OF DAMAGE TO YOUR DISK/PC."

set -e
if [ "$EUID" -ne 0 ]; then
  echo "Root access required, please run this application with root access."
  exit 1
fi

if [ $# -ne 2 ]; then
  echo "Using: $0 <ISO file> <target disk>"
  exit 1
fi

ISO="$1"
DISK="$2"

if [ ! -f "$ISO" ]; then
  echo "ISO file not found: $ISO"
  exit 1
fi

if [ ! -b "$DISK" ]; then
  echo "Disk not found: $DISK"
  exit 1
fi

echo "WARNING! $DISK deletes/erases all the data. Continue? [y/N]"
read -r CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "Cancelled."
  exit 0
fi

echo "ISO is writing... Please wait!"
dd if="$ISO" of="$DISK" bs=4M status=progress conv=fdatasync

sync

echo "$ISO successfully writed to $DISK. Goodbye, we will miss you! :C"
