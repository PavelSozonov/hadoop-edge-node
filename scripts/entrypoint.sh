#!/bin/bash

# Set environment variables from ConfigMap and Secret
NEXUS_URL=${NEXUS_URL}
NEXUS_LOGIN=${NEXUS_LOGIN}
NEXUS_PASSWORD=${NEXUS_PASSWORD}
HADOOP_ARCHIVE_NAME="hadoop.tar.gz"
HADOOP_HOME=/opt/hadoop

# Download and extract Hadoop from Nexus repository
curl -u $NEXUS_LOGIN:$NEXUS_PASSWORD -O $NEXUS_URL/$HADOOP_ARCHIVE_NAME && \
    tar -xzvf $HADOOP_ARCHIVE_NAME -C /opt && \
    rm $HADOOP_ARCHIVE_NAME

# Set Hadoop environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
echo "export HADOOP_HOME=$HADOOP_HOME" >> ~/.bashrc && \
echo "export PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc

# Copy Hadoop configuration files from ConfigMap
cp /config/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
cp /config/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

# Copy krb5.conf from ConfigMap
cp /etc/krb5.conf /etc/krb5.conf

# Execute the command passed to the container
exec "$@"
