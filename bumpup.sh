#!/usr/bin/env bash
VERSION_STRING="const version ="
VER=`grep "$VERSION_STRING" server.js | awk '{print $NF}'`
NEW_VER=$(($VER + 1))
echo "current version: $VER, new version: $NEW_VER"
sed -i "s/$VERSION_STRING $VER$/$VERSION_STRING $NEW_VER/" server.js

# git commit -am "bumpup to $NEW_VER"
# git push public
