#!/bin/bash

VERSION=$1
BRANCH=$(git rev-parse --abbrev-ref HEAD | sed 's/_/-/g' | sed 's/\//-/g')
HASH=$(git rev-parse --short HEAD)
BUNDLE_CONFIG_DIR="./bundle-config"

FINAL_VERSION="${VERSION}-${BRANCH}-${HASH}"

# bundle main files
npx urscript-bundler --config $BUNDLE_CONFIG_DIR/bundle.config.json

# # bundle actions and wrap with a main function
# for f in "$BUNDLE_CONFIG_DIR/actions"/*
# do
#   npx urscript-bundler --config $f

#   # wrap each action with main function so we can send directly to 
#   # controller

#   BUNDLE_FILE=$(jq -r ".options.bundleOutputFile" $f)
#   FUNCTION_DEF="def $BUNDLE_FILE""_action(): \\
#   "
#   echo "wrapping $BUNDLE_FILE action with main function"

#   find dist -type f -name "$BUNDLE_FILE.script" -print0 | 
#   while IFS= read -r -d '' script; do
#     sed -i -e 's/^/  /' $script
#     sed -i -e "1s/^/$FUNCTION_DEF/" $script
#     sed -i -e '2s/  //' $script
#     echo "end" >> $script
#   done
# done

# append version to all bundles
for dir in "dist"/*/
do
  SCRIPT=$dir/beaconRecipes.script
  echo -e "global BEACON_RECIPES_VERSION = \"${FINAL_VERSION}\"\n\n$(cat $SCRIPT)" > $SCRIPT
  echo -e "# ${FINAL_VERSION}\n\n$(cat $SCRIPT)" > $SCRIPT
done