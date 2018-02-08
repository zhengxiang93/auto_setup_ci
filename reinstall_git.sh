#!/bin/sh

apt-get install -y build-essential libcurl4-openssl-dev \
                   libexpat1-dev gettext libz-dev libssl-dev \
                   autoconf

wget --no-check-certificate \
     https://github.com/git/git/archive/v2.11.0.tar.gz \
     -O git.tar.gz

tar -zxf git.tar.gz
cd git-*
make configure
./configure --prefix=/usr
make -j `nproc`
make install
