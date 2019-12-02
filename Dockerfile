FROM mikangali/android

LABEL authors="Michael <mike@mikangali.com>"

SHELL ["/bin/bash", "-c"]

ENV NODEJS_VERSION=10.15.1 \
    PATH=$PATH:/opt/node/bin

### Install nodejs & requirements

WORKDIR /opt/node

RUN apt-get update && apt-get install -y curl ca-certificates libfontconfig bzip2 --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1

### Instal Ionic + Cordova

ENV IONIC_VERSION=4.5.0 \
    CORDOVA_VERSION=8.0.0 

RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION}

### Install ruby the fastlane

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable

ENV RUBY_VERSION=2.5.1 \
    FASTLANE_VERSION=2.137.0 

RUN source /usr/local/rvm/scripts/rvm && \
    echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc  && \
    rvm install ${RUBY_VERSION} && \
    rvm use ${RUBY_VERSION}

ENV PATH=$PATH:/usr/local/rvm/rubies/ruby-2.5.1/bin

RUN gem install fastlane -NV -v ${FASTLANE_VERSION}

# Fix android build : "No installed build tools found"
# https://stackoverflow.com/questions/31190355/ionic-build-android-error-no-installed-build-tools-found-please-install-the
RUN mkdir ~/.android/ && touch ~/.android/repositories.cfg
RUN yes | sdkmanager --licenses
RUN sdkmanager "build-tools;27.0.3"

RUN rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /app
