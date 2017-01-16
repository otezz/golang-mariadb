FROM golang
ADD setup-mariadb.sh /setup-mariadb.sh

ENV MARIADB_VERSION 10.1
ENV MYSQL_ROOT_PASSWORD root

# Update and Fix Language
RUN \
 apt-get update && apt-get -y upgrade &&\
 apt-get install -y --no-install-recommends locales &&\
 echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen &&\
 locale-gen en_US.UTF-8 &&\
 /usr/sbin/update-locale LANG=en_US.UTF-8

# Install mariadb
RUN ["/bin/bash", "-c", "bash /setup-mariadb.sh"]

# Install Goose
RUN go get bitbucket.org/liamstask/goose/cmd/goose

# Clean up
RUN \
 apt-get autoclean && apt-get clean && apt-get autoremove
