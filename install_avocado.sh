#!/bin/bash

HTTP_PROXY=$http_proxy

# Install Avocado framework and Avocado-VT plugin
pip install --upgrade pip
pip install --user --upgrade avocado-framework
pip install --user --upgrade avocado-framework-plugin-vt

# export the installed binary directory path
export PATH=~/.local/bin:$PATH

avocado --version

if [[ -z $? ]]; then
    echo "Install failed!"
    exit 1
else
    echo "Install success!"
    echo "Now copy some files for running avocado tests..."
fi

# copy necessary files
cp -r ~/.local/lib/python2.7/site-packages/usr/share/avocado-plugins-vt/* \
      ~/.local/lib/python2.7/site-packages/

# copy some configurations files
sed -i 's#proxy string.*#proxy string'"$HTTP_PROXY"'#' *.preseed
cp *.preseed ~/.local/lib/python2.7/site-packages/shared/unattended/
cp *.ini ~/.local/lib/python2.7/site-packages/shared/downloads/
cp 16.04.3-server.aarch64.cfg ~/.local/lib/python2.7/site-packages/shared/cfg/guest-os/Linux/Ubuntu
cp 9.3.0.aarch64.cfg ~/.local/lib/python2.7/site-packages/shared/cfg/guest-os/Linux/Debian

# after merging, we can remove it
cp *.patch ~/.local/lib/python2.7/site-packages/
cd ~/.local/lib/python2.7/site-packages/
git apply *.patch

