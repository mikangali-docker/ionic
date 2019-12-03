# Ionic Docker

A [ionic 3](http://ionicframework.com) image, ready for Gitlab CI android builds

[![Docker ionic](https://img.shields.io/docker/automated/mikangali/ionic.svg)](https://hub.docker.com/r/mikangali/ionic)

This images ise based on [android docker (ubuntu)](https://github.com/mikangali-docker/android) image. 

[![Docker android](https://img.shields.io/docker/automated/mikangali/android.svg)](https://hub.docker.com/r/mikangali/android)

### Features

- NodeJs v8
- Ionic 3
- Cordova 8
- Android-25

### Usage

* Run container 

```bash
# simple run
docker run -ti --rm -p 8100:8100 -p 35729:35729 mikangali/ionic

# usb support & automation
docker run -ti --rm -p 8100:8100 -p 35729:35729 --privileged -v /dev/bus/usb:/dev/bus/usb -v ~/.gradle:/root/.gradle -v \$PWD:/app:rw mikangali/ionic ionic
```

* Use in Gitlab CI 

Sample gitlab-ci config using `mikangali/ionic` image

```yml
image: mikangali/ionic

stages:
  - package

before_script:
  - npm install

cache:
  paths:
  - node_modules/

compile_android:
  stage: package
  script:
    - ionic build android
  artifacts:
    paths:
      - platforms/android/build/outputs/apk/
```
