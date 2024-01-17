#!/bin/bash

# setting max parallel download to 20 to speed up dnf
sudo echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf &&

# removing default applications that are unneeded
sudo dnf remove gnome-clocks gnome-maps gnome-contacts totem gnome-boxes libreoffice-common libreoffice-core evince cheese rhythmbox firefox &&
sudo dnf autoremove &&

# setting up firewall to enhance security
sudo dnf install ufw &&
sudo ufw default deny incoming &&
sudo ufw default allow outgoing &&
sudo ufw limit ssh &&
sudo ufw allow https &&
sudo ufw enable &&

# installing free and non-free rpm fusion repositories for broader availability of software packages
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm &&

# installing full ffmpeg and additional codecs for better multimedia support
sudo dnf swap ffmpeg-free ffmpeg --allowerasing &&
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin &&
sudo dnf groupupdate sound-and-video &&

# installing preferred software for better experience
sudo dnf install vim vlc neofetch htop clamav clamtk okular p7zip p7zip-plugins chromium flatpak pcmanfm &&

# install flatpaks
flatpak install com.brave.Browser org.libreoffice.LibreOffice &&

# install updates
sudo dnf upgrade
