FROM mikangali/android

MAINTAINER Michael <mike@mikangali.com>

ENV IONIC_VERSION=3.7.0 \
	NODEJS_VERSION=6.11.0 \
	CORDOVA_VERSION=6.4.0 \
	NPM_VERSION=3.10.10 \
	PATH=$PATH:/opt/node/bin

# Instal nodejs	& requirements

WORKDIR "/opt/node"

RUN apt-get update && apt-get install -y curl ca-certificates libfontconfig bzip2 --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \

# Instal Ionic

	npm i -g --unsafe-perm npm@${NPM_VERSION} cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION}

WORKDIR "/app"
