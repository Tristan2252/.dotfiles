#!/bin/bash

mkdir /Volumes/FileDrive

mount_smbfs //server@192.168.1.1/FileDrive /Volumes/FileDrive

exit 0
