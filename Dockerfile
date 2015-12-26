FROM shippableimages/ubuntu1404_base:latest

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl;

# Install a default nodejs for the system
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

RUN apt-get install --yes nodejs

# Install and configure ArangoDB 2.2
RUN DEBIAN_FRONTEND=noninteractive && \
    cd /tmp && \
    curl -sL https://www.arangodb.org/repositories/arangodb2/xUbuntu_14.04/Release.key | apt-key add - && \
    echo 'deb https://www.arangodb.org/repositories/arangodb2/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/arangodb.list

RUN apt-get install apt-transport-https -y
RUN apt-get update
RUN apt-get install arangodb=2.7.3 -y

CMD [ "node" ]
