# ams-android-gradle - Docker-Images

The ams-android-grade docker image is a docker image with flavours for most of the combinations of up-to-date Android SDK, Build Tools, SDK-Tools and Gradle Versions, for the purpose of testing, building and assembling Apps with Gradle.

## Versioning/Flavours

The docker images are tagged in a specific way:

```
<Gradle-Version>:<Build-Tools-Version>:<SDK-Tools-Build-Number>
```

The information needed for the `target SDK` are extracted from the `Build-Tools-Version`

## Usage

The docker images are pushed to official dockerhub.com, so you can simply use it by `docker run`, inside your Android project. (Right now, it seems to do a good job with kotlin too.)

```
export GRADLE_TASKS="<Your Gradle Tasks...>"
docker run --rm --tty \
    -v "<Path to gradle.properties>:/root/.gradle" \        # Additional global gradle.properties files. This is optional
    -v "$PWD:/opt/workspace" \                              # Your workspace 
    --workdir=/opt/workspace \                              # Changing the workdir in the container
    "./gradlew $GRADLE_TASKS"                               # Executing gradlew
```
