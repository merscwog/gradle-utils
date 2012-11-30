#!/bin/bash

FOUND=0
CURR_PATH="$PWD"
REAL_GRADLEW="$CURR_PATH/gradlew"
REAL_MASTER_GRADLEW="$CURR_PATH/master/gradlew"

# Check current directory, which might be root directory for gradlew
if [ -x "$REAL_GRADLEW" ]; then
  FOUND=1
elif [ -x "$REAL_MASTER_GRADLEW" ]; then
  FOUND=2
else
  while [ "$CURR_PATH" != "/" ]; do
    CURR_PATH=$(dirname "$CURR_PATH")

    REAL_GRADLEW="$CURR_PATH/gradlew"
    if [ -x "$REAL_GRADLEW" ]; then
        FOUND=1
        break
    fi

    REAL_MASTER_GRADLEW="$CURR_PATH/master/gradlew"
    if [ -x "$REAL_MASTER_GRADLEW" ]; then
        FOUND=2
        break
    fi
  done
fi

if [ $FOUND -eq 1 ]; then
  "$REAL_GRADLEW" "$@"
elif [ $FOUND -eq 2 ]; then
  "$REAL_MASTER_GRADLEW" "$@"
else
  echo "Unable to find gradlew file upwards in filesystem"
fi

exit 0
