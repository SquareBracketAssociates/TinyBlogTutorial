#!/usr/bin/env bash

wget http://files.pharo.org/mooc/image/PharoWeb-50.zip 
unzip PharoWeb-50.zip
rm PharoWeb-50.zip

# vm
# wget http://files.pharo.org/platform/Pharo5.0-mac.zip
curl http://get.pharo.org/vm50 | bash


