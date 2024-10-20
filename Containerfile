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
    sdkmanager jdk17-openjdk \
    android-tools \
    clang cmake gtk3

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
RUN sdkmanager \
        "tools" \
        "platforms;android-34" \
        "build-tools;34.0.0" \
        "cmdline-tools;latest" \
        "platform-tools"

# Fix permission issues
RUN mkdir -m 777 /opt/android-sdk/licenses

# Copy configuration files
COPY ./skel/* /etc/skel/
