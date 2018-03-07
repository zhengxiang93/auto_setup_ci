#!/bin/bash

# Install Avocado framework and Avocado-VT plugin
pip install --user avocado-framework
pip install --user avocado-framework-plugin-vt

# export the installed binary directory path
export PATH=~/.local/bin:$PATH

avocado --version

if [[ -z $? ]]; then
    echo "install failed!"
    exit 1
else
    echo "install success!"
    echo "now copy some files for running avocado tests..."
fi

# copy necessary files
cp -r ~/.local/lib/python2.7/site-packages/usr/share/avocado-plugins-vt/* \
      ~/.local/lib/python2.7/site-packages/

# copy some configurations files
cp Ubuntu-16-04-3.preseed ~/.local/lib/python2.7/site-packages/shared/unattended/
cp ubuntu-16.04.3-server-aarch64.ini ~/.local/lib/python2.7/site-packages/shared/downloads/
cp 16.04.3-server.aarch64.cfg ~/.local/lib/python2.7/site-packages/shared/cfg/guest-os/Linux/Ubuntu

# after upstream, remove it
cp tmp.patch change_tp_qemu.patch ~/.local/lib/python2.7/site-packages/
cd ~/.local/lib/python2.7/site-packages/
git apply tmp.patch change_tp_qemu.patch


