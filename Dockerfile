FROM mikangali/android

MAINTAINER Michael <mike@mikangali.com>

ENV IONIC_VERSION=4.5.0 \
	NODEJS_VERSION=8.11.1 \
	CORDOVA_VERSION=8.0.0 \
	NPM_VERSION=5.6.0 \
	FASTLANE_VERSION=2.110.0 \ 
	PATH=$PATH:/opt/node/bin

# Install nodejs & requirements

WORKDIR "/opt/node"

RUN apt-get update && apt-get install -y curl ca-certificates libfontconfig bzip2 --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1

# Instal Ionic

RUN npm i -g --unsafe-perm npm@${NPM_VERSION} cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION} firebase-tools@${FIREBASE_TOOL_VERSION}

# Install fastlane

RUN apt-get install -y build-essential && \
    apt-get install -y ruby-dev && \    
    gem install fastlane -NV -v ${FASTLANE_VERSION} && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

WORKDIR "/app"
