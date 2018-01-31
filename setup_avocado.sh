#!/bin/sh
# install requirements for avocado
apt-get install -y python git gcc python-dev libvirt-dev \
        libffi-dev libssl-dev libyaml-dev xz-utils \
        liblzma-dev make \

# install newest python pip
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

# build and install avocado framework and optional plugins
git clone https://github.com/avocado-framework/avocado.git

cd avocado
make requirements
python setup.py install
make requirements-plugins
make link

# install avocado-vt plugin
cd ..
git clone https://github.com/avocado-framework/avocado-vt.git
cd avocado-vt
make requirements
python setup.py install

# install tools for avocado-vt
apt-get install -y arping tcpdump fakeroot

# init avocado-vt
avocado vt-bootstrap

