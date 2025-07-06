FROM ubuntu:22.04

LABEL maintainer="admin@example.com" \
      description="Apache with GlusterFS mount demo"

RUN apt-get update && \
    apt-get install -y apache2 glusterfs-client curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /mnt/glusterfs

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]

