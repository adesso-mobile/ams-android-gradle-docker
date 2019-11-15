# ams-android-gradle - Docker-Images

The ams-android-grade docker image is a docker image with flavours for most of the combinations of up-to-date Android SDK, Build Tools, SDK-Tools and Gradle Versions, for the purpose of testing, building and assembling Apps with Gradle.

## Versioning/Flavours

The docker images are tagged in a specific way:

```
<Gradle-Version>-<Build-Tools-Version>-<SDK-Tools-Build-Number>
```

The information needed for the `target SDK` are extracted from the `Build-Tools-Version`

### Available on Dockerhub

#### Gradle
- 4.4 and 5.6.3

#### Build Tools/Target SDK
- 28.0.3 and 29.0.2

#### SDK Tools
- 4333796

## Usage

### Self-Building
If there isn't the combination you need on the dockerhub repository, feel free to build your own image:

```bash
docker build -t "ams-android-gradle:${gradle_v}-${android_build_tools_v}-${android_sdk_tools_v}" \
            --build-arg "gradle_version=${gradle_v}" \                      # e.g. 5.6.3
            --build-arg "android_build_tools=${android_build_tools_v}" \    # e.g. 29.0.2
            --build-arg "android_sdk_tools=${android_sdk_tool_v}" \         # e.g. 4333796
            .
```

### Running 

The docker images are pushed to official dockerhub.com, so you can simply use it by `docker run`, inside your Android project. (Right now, it seems to do a good job with kotlin too.)

```bash
export GRADLE_TASKS="test assemble..."
export USE_EMULATOR=1                   # Only if you need an emulator and system-image for e.g espresso tests

docker run  \
    -e "USE_EMULATOR=$USE_EMULATOR"
    -e "NEW_UID=$(id -u)" \
    -e "GRADLE_TASKS=$GRADLE_TASKS" \
    -v "$HOME/.gradle/gradle.properties:/teamcity/.gradle/gradle.properties" \
    -v "$PWD:/opt/workspace" \
    --workdir=/opt/workspace \
    --privileged \                  # Only needed if you have USE_EMULATOR defined to get access to /dev/kvm
    -t amsitoperations/ams-android-gradle:"$TAG" \
    start_build
```
