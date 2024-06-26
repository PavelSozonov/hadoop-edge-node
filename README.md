# Hadoop Edge Node Docker Image

This Docker image acts as an edge node with Hadoop client version 3.1.2 on Ubuntu LTS. It supports Kerberos keytab authentication and runs under an unprivileged user.

## Files layout
```
hadoop-edge-node/
├── .gitignore
├── Dockerfile
├── hadoop-distr.sh
├── README.md
├── config/
│   ├── core-site.xml
│   ├── hdfs-site.xml
│   ├── krb5.conf
├── create-configmap-serret.sh
├── kubernetes/
│   ├── deployment.yaml
│   ├── nexus-configmap.yaml
│   ├── nexus-secret.yaml
├── scripts/
│   └── entrypoint.sh
└── secrets/
    └── user.keytab
```

## Prerequisites

### 1. Prepare `./config` dir 

Add your `core-site.xml`, `hdfs-site.xml`, `krb5.conf` configuration content here.

### 2. Build the Docker Image

```bash
docker build -t hadoop-edge-node .
```

### 3. Create configmaps
* `nexus-cofig`
* `krb5-config`
* `hadoop-config`

### 4. Create secrets
* `nexus-credentials`: `sh ./create-configmap.sh`
* `hadoop-keytab`

## Run the Docker Container

To run the Docker container, use the following command, ensuring you map the krb5.conf and keytab files correctly:

```bash
docker run -it -v /path/to/your/krb5.conf:/etc/krb5.conf -v /path/to/your.keytab:/home/hadoopuser/.keytab hadoop-edge-node
```

## Authenticate with Kerberos

In the running container, use `kinit` to authenticate with Kerberos:

```bash
kinit -kt /home/hadoopuser/.keytab your_principal_name
```

## Tips and Best Practices

1. **Kerberos Configuration**: Ensure your `krb5.conf` file is correctly configured and placed in a secure location. The file should be mapped to `/etc/krb5.conf` in the Docker container.

2. **Keytab File Management**: Store your keytab file securely and map it to `/home/hadoopuser/.keytab` in the Docker container. This allows the unprivileged user to use it for Kerberos authentication.

3. **User Permissions**: The Docker image is configured to run under an unprivileged user (`hadoopuser`). This enhances security by limiting the permissions available to the running processes.

4. **Environment Variables**: The Hadoop environment variables are set in the Dockerfile. Ensure these are correctly configured to match your Hadoop cluster settings.
