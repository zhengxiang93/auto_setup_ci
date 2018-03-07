#!/bin/bash

# Avocado Virt Test init
export PATH=~/.local/bin:$PATH
avocado vt-bootstrap --vt-guest-os Ubuntu.16.04.3-server.aarch64 --yes-to-all

DATA_DIR=/var/lib/avocado/data/avocado-vt/backends/qemu/cfg/

if [[ -d "~/avocado/data/" ]]; then
    DATA_DIR=~/avocado/data/avocado-vt/backends/qemu/cfg/
fi

sudo cp test-qemu-ubuntu-compute.cfg $DATA_DIR
cd $DATA_DIR

avocado run --vt-config ./test-qemu-ubuntu-compute.cfg
