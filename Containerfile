FROM ghcr.io/ublue-os/arch-distrobox:latest AS flutterbox

# Create the build user
RUN useradd -m --shell=/bin/bash build && usermod -L build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install required packages
USER build
WORKDIR /home/build
RUN paru -Syu --noconfirm \
    flutter \
    sdkmanager jdk17-openjdk \ # Android
    clang cmake gtk3 # Linux

# Cleanup
USER root
WORKDIR /
RUN userdel -r build && \
    rm -drf /home/build && \
    sed -i '/build ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    sed -i '/root ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    rm -rf \
        /tmp/* \
        /var/cache/pacman/pkg/*

# Android SDK setup
ENV ANDROID_HOME="/opt/android-sdk"
RUN mkdir -p $ANDROID_HOME && \
    sdkmanager \
        "tools" \
        "platforms;android-34" \
        "build-tools;34.0.0" \
        "cmdline-tools;latest" \
        "platform-tools"

# Fix permission issues
RUN mkdir -m 777 $ANDROID_HOME/licenses && \
    chmod o+w /opt/flutter/packages/flutter_tools/.dart_tool

# Copy configuration files
COPY ./skel/gitconfig /etc/skel/.gitconfig
RUN mkdir -p /etc/skel/.config
COPY ./skel/flutter_settings /etc/skel/.config/settings
