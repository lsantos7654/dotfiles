#!/bin/bash

rclone --vfs-cache-mode writes mount onedrive: ~/OneDrive/ &

echo "OneDrive Mounted"
