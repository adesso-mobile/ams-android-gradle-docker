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
ENV ANDROID_HOME $PWD/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH

RUN apt-get --quiet update --yes && \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 git --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME} && \
    rm -rf gradle-${GRADLE_VERSION}-bin.zip && \
    curl -sSL "${ANDROID_SDK_URL}" -o android-sdk-linux.zip && \
    unzip android-sdk-linux.zip -d android-sdk-linux  &&\
    rm -rf android-sdk-linux.zip && \
    mkdir $ANDROID_HOME/licenses && \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools"; \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"; \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "platforms;${ANDROID_TARGET_SDK}"; \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
