FROM ghcr.io/ublue-os/arch-distrobox:latest AS flutterbox

# Create the build user
RUN useradd -m --shell=/bin/bash build && usermod -L build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install required packages
USER build
WORKDIR /home/build
RUN paru -Syu --noconfirm flutter sdkmanager jdk-openjdk

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

COPY install-android-sdk.sh /etc/profile.d/99-install-android-sdk.sh
COPY gitconfig /etc/skel/.gitconfig
