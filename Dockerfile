FROM shippableimages/ubuntu1404_base:latest

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl software-properties-common;

# Install a default nodejs for the system
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-add-repository ppa:ansible/ansible

# Install and configure ArangoDB 2.2
RUN DEBIAN_FRONTEND=noninteractive && \
    cd /tmp && \
    curl -sL https://www.arangodb.org/repositories/arangodb2/xUbuntu_14.04/Release.key | apt-key add - && \
    echo 'deb https://www.arangodb.org/repositories/arangodb2/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/arangodb.list

RUN apt-get update

RUN apt-get install ansible -y
RUN apt-get install apt-transport-https -y
RUN apt-get install --yes nodejs
RUN apt-get install arangodb=2.7.3 -y

RUN ln -s /bin/bash /bin/sh

# retain the database directory and the Foxx Application directory
VOLUME ["/var/lib/arangodb", "/var/lib/arangodb-apps"]

# standard port
EXPOSE 8529
