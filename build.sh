#!/bin/bash

"$(pwd)"/gradlew $GRADLE_TASKS
chown "$NEW_UID:$NEW_UID" /opt/workspace -R
