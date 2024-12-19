#!/usr/bin/env bash

# inputs
DATE=$(date --iso-8601=seconds -u)

echo -n "Github username: " 
read -r GITHUB_USERNAME

echo -n "Github token: " 
read -r CR_PAT

echo -n "Release: " 
read -r RELEASE

# update
sed -i "s/          version = \".*\";/          version = \"$RELEASE\";/g" flake.nix
sed -i "s/          created = \".*\";/          created = \"$DATE\";/g" flake.nix

# commit
git add -A
git commit -m "release: $RELEASE"
git push

# tag
git tag -m "" "$RELEASE"
git push origin "$RELEASE"

# build
nix build .
docker load < ./result

# publish
docker image tag "onix:$RELEASE" "ghcr.io/onix-sec/onix:$RELEASE"
echo "$CR_PAT" | docker login ghcr.io -u "$GITHUB_USERNAME" --password-stdin
docker push "ghcr.io/onix-sec/onix:$RELEASE"
