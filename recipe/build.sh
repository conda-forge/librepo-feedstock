#!/bin/bash
set -euxo pipefail

mkdir -p build
cd build

cmake ${CMAKE_ARGS} \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DWITH_ZCHUNK=ON \
      -DENABLE_DOCS=OFF \
      ..

cmake --build . -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then
  ctest --progress --output-on-failure
fi
cmake --install .
