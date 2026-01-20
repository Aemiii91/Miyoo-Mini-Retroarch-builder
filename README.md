# RetroArch cores build-bot for Linux ARMv7

## Usage

### Building cores

To build all cores for a given target (e.g., `linux-armv7-neon`):

```sh
make build/linux-armv7-neon
```

Or use the Makefile targets as needed:

```sh
make init           # Initialize submodules and environment
make build/<target> # Build for a specific target
make clean          # Clean build and dist directories
```

## Recipes

A recipe defines all the information needed to fetch, configure, and build a specific core for RetroArch. Each recipe entry specifies:

- The core's name and source repository
- The branch or commit to use
- Whether the core is enabled for building
- The build system and makefile to use
- Any subdirectory or extra build arguments

The buildbot script uses these recipes to automate and repeat the build process for different targets.


### Example recipe entry

| name | dir           | url                                           | git_branch | enabled | command | makefile          | subdir | args |
| ---- | ------------- | --------------------------------------------- | ---------- | ------- | ------- | ----------------- | ------ | ---- |
| 2048 | libretro-2048 | https://github.com/libretro/libretro-2048.git | master     | YES     | GENERIC | Makefile.libretro | .      |      |
