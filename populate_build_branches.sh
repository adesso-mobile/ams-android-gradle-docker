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
            git checkout master
            git status -s | grep -q . && { 
                echo "Alter, krich dein Scheiss zam!" 
                exit 1
            }
            git reset --hard

            android_major_version=${android_build_tools_version%%.*}
            android_target_sdk="android-$android_major_version"
            android_images="sys-img-armeabi-v7a-android-${android_major_version},sys-img-armeabi-v7a-android-${android_major_version}"

            version_string="$gradle_version-$android_build_tools_version-$android_sdk_tools_version"

            branch_name="build/$version_string"

            git_branch_exist "$branch_name" && { 
                git checkout "$branch_name"
                git merge master
                continue
            }

            git checkout -b "$branch_name"
            mkdir -p buildenv
            echo "$gradle_version" > buildenv/gradle_version
            echo "$android_target_sdk" > buildenv/android_target_sdk
            echo "$android_build_tools_version" > buildenv/android_build_tools_version
            echo "$android_sdk_tools_version" > buildenv/android_sdk_tools_version
            echo "$android_images" > buildenv/android_images

            git add -A && git commit -m "New Build-Branch for $version_string" . && git push
        done
    done
done

