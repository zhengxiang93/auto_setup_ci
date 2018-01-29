#!/bin/sh
apt-get install -y python git gcc python-dev libvirt-dev \
        libffi-dev libssl-dev libyaml-dev xz-utils \
        liblzma-dev

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

git clone https://github.com/avocado-framework/avocado.git

cd avocado
make requirements
python setup.py install
make requirements-plugins
make link

cd ..
git clone https://github.com/avocado-framework/avocado-vt.git
cd avocado-vt
make requirements
python setup.py install

apt-get install -y arping tcpdump

avocado vt-bootstrap
