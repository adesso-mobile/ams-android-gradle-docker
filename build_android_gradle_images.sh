#!/bin/bash
set -x

git_branch_exist() {
    git rev-parse --verify "$1" &>/dev/null
    return $?
}

gradle_versions=(4.4 5.6.3 6.5)  
android_build_tools_versions=(28.0.3 29.0.2)
android_sdk_tools_versions=(4333796)

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
                . \
            && docker tag "ams-android-gradle:$version_string" "amsitoperations/ams-android-gradle:$version_string" \
            && docker push "amsitoperations/ams-android-gradle:$version_string"
        done
    done
done

git checkout master
