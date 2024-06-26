# Use Ubuntu LTS as the base image
FROM ubuntu:20.04

# Set environment variables
ENV HADOOP_VERSION=3.1.2
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin

# Install necessary dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-8-jdk wget curl vim tar sudo openssh-server rsync krb5-user libpam-krb5 libpam-ccreds libkdb5-8 netcat iputils-ping && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy the entrypoint script
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Create a non-root user and switch to that user
RUN useradd -m -s /bin/bash hadoopuser
USER hadoopuser
WORKDIR /home/hadoopuser

# Set the entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
