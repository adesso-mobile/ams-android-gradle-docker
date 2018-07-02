#!/bin/bash

test -n "$NEW_UID" || exit 1
useradd -d /opt/workspace -u "$NEW_UID" -g "$NEW_UID" teamcity

chown "$NEW_UID:$NEW_UID" /opt/workspace -R

su - teamcity

"$(pwd)"/gradlew $GRADLE_TASKS
