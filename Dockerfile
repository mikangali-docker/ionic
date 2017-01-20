FROM mikangali-docker/android

MAINTAINER Michael <mike@mikangali.com>

ENV IONIC_VERSION 2.2.1 \
	NODEJS_VERSION 6.9.4 \
	CORDOVA_VERSION 6.4.0 \
	PATH $PATH:/opt/node/bin
	
# Instal nodejs	

RUN apt-get update && apt-get install -y curl ca-certificates --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 && \
    	
    # clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && apt-get clean && \

# Instal Ionic	
  
	npm i -g --unsafe-perm cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION} 
	
WORKDIR "/app"
