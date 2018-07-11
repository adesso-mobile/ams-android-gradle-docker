#!/bin/bash
test -n "$NEW_UID" || { echo "NEW_UID Environment Variable not set. Exiting." && exit 1; }
echo "Creating new User with ID $NEW_UID"
useradd -d /teamcity -u "$NEW_UID" teamcity
mkdir -p /teamcity && chown "$NEW_UID:$NEW_UID" /teamcity -R

echo "Setting Owner of /opt/workspace to Teamcity-User"
chown "$NEW_UID:$NEW_UID" /opt/workspace -R

if [ -n "$USE_EMULATOR" ]; then
    echo "Setting Owner of /dev/kvm to Teamcity-User"
    chown "$NEW_UID:$NEW_UID" /dev/kvm
fi

echo "Changing to Teamcity-User"
su teamcity -c "/teamcity/gradle_invocation.sh"
