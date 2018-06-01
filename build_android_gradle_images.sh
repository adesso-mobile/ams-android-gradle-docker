#!/bin/bash

#ARG gradle_version=4.4
#ARG android_target_sdk="android-27"
#ARG android_build_tools="27.0.3"
#ARG android_sdk_tools="3859397"
#ARG android_images="sys-img-armeabi-v7a-android-27,sys-img-armeabi-v7a-android-27"

git_branch_exist() {
    git rev-parse --verify "$1" &>/dev/null
    return $?
}

gradle_versions=(4.1 4.4) 
android_build_tools_versions=(26.0.3 27.0.3)
android_sdk_tools_versions=(3859397)

for gradle_version in ${gradle_versions[@]}; do
    for android_sdk_tools_version in ${android_sdk_tools_versions[@]}; do
        for android_build_tools_version in ${android_build_tools_versions[@]}; do
            android_major_version=${android_build_tools_version%%.*}
            android_target_sdk="android-$android_major_version"
            android_images="sys-img-armeabi-v7a-android-${android_major_version},sys-img-armeabi-v7a-android-${android_major_version}"

            version_string="$gradle_version-$android_build_tools_version-$android_sdk_tools_version"

            docker build -t "ams-android-gradle:$version_string" \
                --build-arg "gradle_version=$gradle_version" \
                --build-arg "android_target_sdk=$android_target_sdk" \
                --build-arg "android_build_tools=$android_build_tools_version" \
                --build-arg "android_sdk_tools_version=$android_sdk_tools_version" \
                --build-arg "android_images=$android_images" \
                .
            docker tag "ams-android-gradle:$version_string" "amsitoperations/ams-android-gradle:$version_string"
            docker push "amsitoperations/ams-android-gradle:$version_string"
        done
    done
done

git checkout master
