#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export SWITCH_UTILS=$DIR/externals/switch-utils
(
cd $SWITCH_UTILS
make
)

mkdir -p build
cd build

if [ "$DEVKITPRO" = "" ]
then
  echo "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitpro"
fi

cmake -DENABLE_FLUIDSYNTH=OFF -DSDL2_MIXER_LIBRARY=$DEVKITPRO/portlibs/switch/lib/libSDL2_mixer.a -DSDL2_DIR=/opt/devkitpro/portlibs/switch/lib/cmake/SDL2 -DCMAKE_TOOLCHAIN_FILE=${SWITCH_UTILS}/cmake/Toolchain-cross-Switch.cmake -DENABLE_SDL2=ON -DENABLE_OPENGL=OFF -DOPENGL_EGL_INCLUDE_DIR=$DEVKITPRO/portlibs/switch/include -DOPENGL_INCLUDE_DIR=$DEVKITPRO/portlibs/switch/include -DOPENGL_EGL_LIBRARY=$DEVKITPRO/portlibs/switch/lib/libEGL.a  ..

make VERBOSE=1
