FROM shippableimages/ubuntu1404_base:latest

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl;

# Install a default nodejs for the system
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

# Force NVM_DIR so the installations go to the right place
ENV NVM_DIR /root/.nvm

# Install nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.17.2/install.sh | bash

# Preinstall common node versions
RUN . /root/.nvm/nvm.sh && nvm install 4.2.3;
RUN . /root/.nvm/nvm.sh && nvm alias default 4.2.3;

RUN wget -q https://www.arangodb.com/repositories/arangodb2/xUbuntu_14.04/Release.key -O- | apt-key add -
RUN echo 'deb https://www.arangodb.com/repositories/arangodb2/xUbuntu_14.04/ /' | tee /etc/apt/sources.list.d/arangodb.list
RUN apt-get install apt-transport-https -y
RUN apt-get update
RUN apt-get install arangodb=2.7.3 -y

CMD [ "node" ]
