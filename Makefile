.PHONY: all init clean build dist docker reset-submodules

FORCE ?= NO
DOCKER_IMAGE=techdevangelist/miyoomini-buildroot:latest

all: build dist

init:
	./init.sh

build: $(patsubst ./config/%,build/%,$(wildcard ./config/*))

build/%: ./config/%
	docker run \
		-v .:/root/workspace \
		-e "FORCE=${FORCE}" \
		${DOCKER_IMAGE} \
		/bin/bash -c "cd /root/workspace && ./build.sh $<"

dist: $(patsubst build/%,dist/libretro_cores_%.7z,$(wildcard build/*))

dist/libretro_cores_%.7z: build/%
	mkdir -p dist
	cd $< && 7z a "../../$@" *

clean:
	rm -rf build/*
	rm -rf dist/*
	rm -rf libretro-super/libretro-*

reset-submodules:
	git submodule foreach --recursive git clean -xfd
	git submodule foreach --recursive git reset --hard
	git submodule update --init --recursive