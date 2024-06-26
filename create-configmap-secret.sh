#!/bin/bash

# Variables
HADOOP_CONFIG_MAP_NAME="hadoop-config"
CORE_SITE_FILE="config/core-site.xml"
HDFS_SITE_FILE="config/hdfs-site.xml"

KRB5_CONFIG_MAP_NAME="hadoop-config"
KRB5_CONF_FILE="config/krb5.conf"

KEYTAB_SECRET_NAME="hadoop-keytab"
KEYTAB_FILE="secrets/user.keytab"

# Create ConfigMap
kubectl create configmap $HADOOP_CONFIG_MAP_NAME --from-file=$CORE_SITE_FILE --from-file=$HDFS_SITE_FILE
kubectl create configmap $KRB5_CONFIG_MAP_NAME  --from-file=$KRB5_CONF_FILE

# Create Sectret
kubectl create secret generic $KEYTAB_SECRET_NAME --from-file=$KEYTAB_FILE
