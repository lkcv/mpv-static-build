#!/bin/sh

# env vars to confine package search to just the static libraries we're building and to pass fPIC

export BUILD="$(pwd)"

export LC_ALL=C

export CFLAGS="-fPIC"
export CXXFLAGS="-fPIC"

export PKG_CONFIG_LIBDIR="$BUILD/build_libs/lib/pkgconfig"
export PKG_CONFIG_LIBDIR="$BUILD/build_libs/share/pkgconfig:$PKG_CONFIG_LIBDIR"

if [[ "$CLEAN_BUILD" == "yes" ]]
then
    rm -rf "$BUILD/build_libs"
    rm -rf "$BUILD/repos"
fi

scripts/expat-check
scripts/bzip2-check 
scripts/libxml2-check 
scripts/libffi-check 
scripts/luajit-check 
scripts/brotli-check 
scripts/zlib-check 
scripts/libpng-check 
scripts/freetype-check 
scripts/harfbuzz-check 
scripts/fontconfig-check 
SKIP="yes" scripts/libjpeg-check 
scripts/vulkan-headers-check 
scripts/vulkan-loader-check 
scripts/spirv-tools-check 
scripts/shaderc-check 
scripts/wayland-check 
scripts/wayland-protocols-check 
scripts/libxkbcommon-check 
scripts/lcms2-check
scripts/xxhash-check
scripts/fribidi-check
scripts/libunibreak-check
scripts/libass-check 
scripts/zimg-check #needed for vapoursynth
scripts/vapoursynth-check 
scripts/hwdata-check #optional for libdisplay-info
scripts/libdisplay-info-check 
scripts/libdrm-check 
scripts/libplacebo-check 
scripts/ffmpeg-check 
scripts/uchardet-check 
scripts/alsa-check 
scripts/pipewire-check 
TAG="master" scripts/mpv-check

