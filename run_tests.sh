#!/bin/bash

sudo cp test-qemu-ubuntu-compute.cfg /var/lib/avocado/data/avocado-vt/backends/qemu/cfg/
cd /var/lib/avocado/data/avocado-vt/backends/qemu/cfg/

export PATH=~/.local/bin:$PATH
avocado run --vt-config ./test-qemu-ubuntu-compute.cfg
