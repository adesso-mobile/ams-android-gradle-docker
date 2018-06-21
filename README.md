# ams-android-gradle - Docker-Images

The ams-android-grade docker image is a docker image with flavours for most of the combinations of up-to-date Android SDK, Build Tools, SDK-Tools and Gradle Versions, for the purpose of testing, building and assembling Apps with Gradle.

## Versioning/Flavours

The docker images are tagged in a specific way:

```
<Gradle-Version>-<Build-Tools-Version>-<SDK-Tools-Build-Number>
```

The information needed for the `target SDK` are extracted from the `Build-Tools-Version`

### Available

#### Gradle
- 3.0
- 3.5
- 4.0
- 4.1
- 4.2
- 4.3
- 4.4
- 4.5
- 4.6
- 4.7
- 4.8

#### Build Tools/Target SDK
- 20.0.0
- 21.0.2
- 22.0.1
- 23.0.3
- 24.0.3
- 25.0.3
- 26.0.3
- 27.0.3

#### SDK Tools
- 3859397

## Usage

The docker images are pushed to official dockerhub.com, so you can simply use it by `docker run`, inside your Android project. (Right now, it seems to do a good job with kotlin too.)

```bash
export GRADLE_TASKS="test assemble..."

docker run -e "GRADLE_TASKS=$GRADLE_TASKS" -e "NEW_UID=$(id -u)" \
    -v "$HOME/.gradle/:/root/.gradle/" \
    -v "$PWD:/opt/workspace" \
    --workdir=/opt/workspace \
    -t amsitoperations/ams-android-gradle:"$TAG" \
    /tmp/build.sh
```
