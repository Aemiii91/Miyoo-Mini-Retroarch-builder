#!/bin/bash

git submodule init
git submodule update
patch -p0 < ./buildbot-tweaks.patch
