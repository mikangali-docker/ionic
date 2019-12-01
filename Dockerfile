FROM mikangali/android

LABEL authors="Michael <mike@mikangali.com>"

SHELL ["/bin/bash", "-c"]

ENV IONIC_VERSION=4.5.0 \
    NODEJS_VERSION=10.15.1 \
    CORDOVA_VERSION=8.0.0 \
    RUBY_VERSION=2.4.1 \
    FASTLANE_VERSION=2.137.0 

# Install nodejs, rvm & requirements

WORKDIR /opt/node

RUN apt-get update && \
    apt-get install -y curl ca-certificates build-essential libfontconfig bzip2 software-properties-common --no-install-recommends && \
    apt-add-repository -y ppa:rael-gc/rvm && \
    apt-get update && \
    apt-get install -y rvm && \
    curl -sSL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1
    
ENV PATH=$PATH:/opt/node/bin:/usr/share/rvm/bin

# Instal Ionic + Cordova

RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION}

# Install fastlane and cleanup

RUN rvm install ${RUBY_VERSION} && \
    bash --login && rvm use ${RUBY_VERSION} && \
    gem install fastlane -NV -v ${FASTLANE_VERSION} && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

WORKDIR /app

# Fix android build : "No installed build tools found"
# https://stackoverflow.com/questions/31190355/ionic-build-android-error-no-installed-build-tools-found-please-install-the
RUN mkdir ~/.android/ && touch ~/.android/repositories.cfg
RUN yes | sdkmanager --licenses
RUN sdkmanager "build-tools;27.0.3"
