#!/usr/bin/env bash

# PHAROWEB_IMAGE_ARCHIVE=PharoWeb-50.zip
# test -f ${PHAROWEB_IMAGE_ARCHIVE} || wget http://mooc.pharo.org/image/${PHAROWEB_IMAGE_ARCHIVE}
# rm -fr PharoWeb.{image,changes}
# unzip ${PHAROWEB_IMAGE_ARCHIVE}

# curl http://files.pharo.org/vm/pharo-spur32/mac/latest.zip

# curl get.pharo.org/vm60 | bash
#
# PHAROWEB_IMAGE_ARCHIVE=PharoWeb-60.zip
# test -f ${PHAROWEB_IMAGE_ARCHIVE} || wget http://mooc.pharo.org/image/${PHAROWEB_IMAGE_ARCHIVE}
# rm -fr PharoWeb.{image,changes}
# unzip ${PHAROWEB_IMAGE_ARCHIVE}

# curl get.pharo.org/50+vm |  bash
curl get.pharo.org/50 | bash