FROM openjdk:8-jdk
MAINTAINER adesso mobile solutions GmbH <it-operations@adesso-mobile.de>

ARG gradle_version
ARG android_target_sdk
ARG android_build_tools
ARG android_sdk_tools

ENV SDK_HOME /usr/local
ENV GRADLE_VERSION ${gradle_version}
ENV GRADLE_SDK_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME ${SDK_HOME}/gradle-${GRADLE_VERSION}
ENV PATH ${GRADLE_HOME}/bin:$PATH
ENV ANDROID_TARGET_SDK="${android_target_sdk}"
ENV ANDROID_BUILD_TOOLS="${android_build_tools}"
ENV ANDROID_SDK_TOOLS="${android_sdk_tools}"
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
ENV ANDROID_HOME /android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH

COPY install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh && /tmp/install.sh

COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh
