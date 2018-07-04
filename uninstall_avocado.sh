#!/bin/bash

pip uninstall -y avocado-framework avocado-framework-plugin-vt
rm -rf ~/.local/lib/python2.7/site-packages/test-providers.d/
rm -rf ~/.local/lib/python2.7/site-packages/shared/
rm -rf ~/.local/lib/python2.7/site-packages/*.patch
rm -rf ~/.local/lib/python2.7/site-packages/backends/
