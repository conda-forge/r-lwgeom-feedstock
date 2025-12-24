#!/bin/bash

set -o xtrace -o nounset -o pipefail -o errexit

if [[ "${build_platform}" != "${target_platform}" ]]; then
  # This is misleading, remove.
  rm $BUILD_PREFIX/bin/geos-config
fi
export PROJ_VERSION=$proj

export CPPFLAGS="${CPPFLAGS} -Wl,-rpath,${PREFIX}/lib -I${PREFIX}/include"
# This is just to get around a configure failure when trying to link to gdal.	  ${R} CMD INSTALL --build .
LIBS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib"
if [[ ${target_platform} == osx-* ]] || [[ ${target_platform} == linux-* ]]; then
  LIBRARY_PATH=${PREFIX}/lib
  export CXX="${CXX} --std=c++14 -Wl,-rpath,${PREFIX}/lib"
  export CC="${CC} -Wl,-rpath,${PREFIX}/lib"
fi

export DISABLE_AUTOBREW=1
${R} CMD INSTALL --build . ${R_ARGS:-} --configure-args="--with-proj-lib=$PREFIX/lib --with-proj-include=$PREFIX/include"
