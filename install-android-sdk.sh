#!/bin/sh

# Set ANDROID_HOME
if [ -z "$ANDROID_HOME" ]; then
    export ANDROID_HOME="$HOME/.local/share/android"
fi

# Install Android SDK
if [ ! -d "$ANDROID_HOME/tools" ]; then
    echo Android SDK Tools not found, installing...
    sdkmanager "tools"
fi

if [ ! -d "$ANDROID_HOME/platforms" ]; then
    echo Android SDK Platform not found, installing...
    sdkmanager "platforms;android-34"
fi

if [ ! -d "$ANDROID_HOME/build-tools" ]; then
    echo Android SDK Build Tools not found, installing...
    sdkmanager "build-tools;34.0.0"
fi

if [ ! -d "$ANDROID_HOME/cmdline-tools" ]; then
    echo Android SDK Command Line Tools not found, installing...
    sdkmanager "cmdline-tools;latest"
fi

if [ ! -d "$ANDROID_HOME/platform-tools" ]; then
    echo Android SDK Platform Tools not found, installing...
    sdkmanager "platform-tools"
fi
