#!/bin/bash

git_branch_exist() {
    git rev-parse --verify "$1" &>/dev/null
    return $?
}

gradle_versions=(3.0 3.5 4.0 4.1 4.2 4.4 4.5 4.6 4.7 4.8) 
android_build_tools_versions=(20.0.0 21.0.2 22.0.1 23.0.3 24.0.3 25.0.3 26.0.3 27.0.3)
android_sdk_tools_versions=(3859397 4333796)

for gradle_version in ${gradle_versions[@]}; do
    for android_sdk_tools_version in ${android_sdk_tools_versions[@]}; do
        for android_build_tools_version in ${android_build_tools_versions[@]}; do
            android_major_version=${android_build_tools_version%%.*}
            android_target_sdk="android-$android_major_version"
            android_images="system-images;android-$android_major_version;google_apis;x86"

            version_string="$gradle_version-$android_build_tools_version-$android_sdk_tools_version"

            docker build -t "ams-android-gradle:$version_string" \
                --build-arg "gradle_version=$gradle_version" \
                --build-arg "android_target_sdk=$android_target_sdk" \
                --build-arg "android_build_tools=$android_build_tools_version" \
                --build-arg "android_sdk_tools=$android_sdk_tools_version" \
                --build-arg "android_images=$android_images" \
                . \
            && docker tag "ams-android-gradle:$version_string" "amsitoperations/ams-android-gradle:$version_string" \
            && docker push "amsitoperations/ams-android-gradle:$version_string"
        done
    done
done

git checkout master
