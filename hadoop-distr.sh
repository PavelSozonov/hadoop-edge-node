#!/bin/bash

# Variables
HADOOP_DIR="hadoop"
ARCHIVE_NAME="hadoop.tar.gz"
NEXUS_URL="https://example.com/nexus-hosted-raw-repository"
NEXUS_LOGIN=${NEXUS_LOGIN}
NEXUS_PASSWORD=${NEXUS_PASSWORD}

# Pack the hadoop directory into a tar.gz archive
tar -czvf $ARCHIVE_NAME $HADOOP_DIR

# Push the archive to Nexus repository
curl -u $NEXUS_LOGIN:$NEXUS_PASSWORD --upload-file $ARCHIVE_NAME $NEXUS_URL/$ARCHIVE_NAME

# Cleanup
rm $ARCHIVE_NAME
