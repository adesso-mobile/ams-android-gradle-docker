FROM ubuntu 
FROM openjdk:8-jdk
MAINTAINER adesso mobile solutions GmbH <it-operations@adesso-mobile.de>

ENV SDK_HOME /usr/local

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 git --no-install-recommends

ARG gradle_version=4.4
ARG android_target_sdk="android-27"
ARG android_build_tools="27.0.3"
ARG android_sdk_tools="3859397"
ARG android_images="sys-img-armeabi-v7a-android-27,sys-img-armeabi-v7a-android-27"

# Gradle
ENV GRADLE_VERSION ${gradle_version}
ENV GRADLE_SDK_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
RUN curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  \
&& unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME}  \
&& rm -rf gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME ${SDK_HOME}/gradle-${GRADLE_VERSION}
ENV PATH ${GRADLE_HOME}/bin:$PATH

# android sdk|build-tools|image
ENV ANDROID_TARGET_SDK="${android_target_sdk}" \
ANDROID_BUILD_TOOLS="${android_build_tools}" \
ANDROID_SDK_TOOLS="${android_sdk_tools}" \
ANDROID_IMAGES=""   
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN curl -sSL "${ANDROID_SDK_URL}" -o android-sdk-linux.zip \
&& unzip android-sdk-linux.zip -d android-sdk-linux \
&& rm -rf android-sdk-linux.zip

# Set ANDROID_HOME
ENV ANDROID_HOME $PWD/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH

# licenses
RUN mkdir $ANDROID_HOME/licenses

# Update and install using sdkmanager 
RUN echo yes | $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools"
RUN echo yes | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
RUN echo yes | $ANDROID_HOME/tools/bin/sdkmanager "platforms;${ANDROID_TARGET_SDK}"
RUN echo yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
