#!/bin/bash

set -xe

DESTDIR=~/drive2/radio/tools/install

pushd tools/hackrf/host
mkdir -p build
pushd build
cmake -Wno-dev ../
make -j4
make DESTDIR=${DESTDIR} install
popd
popd

if false; then
	pushd tools/SoapySDR
	mkdir -p build
	pushd build
	cmake -Wno-dev ../
	make -j4
	make DESTDIR=${DESTDIR} install
	popd
	popd

	pushd tools/SoapySDRPlay
	mkdir -p build
	pushd build
	cmake -Wno-dev ../ -DSoapySDR_DIR=${DESTDIR}/usr/local/share/cmake/SoapySDR
	make -j4
	popd
	popd

	# git clone https://github.com/pothosware/SoapySDRPlay.git
	# git clone https://github.com/pothosware/SoapySDR.git
	# git clone https://github.com/pothosware/SoapyRemote.git
fi

pushd tools/gr-osmosdr
mkdir -p build
pushd build
LIBHACKRF_DIR=${DESTDIR}/usr/local cmake -Wno-dev -DENABLE_PYTHON=OFF ../
make -j4
make DESTDIR=${DESTDIR} install
popd
popd

pushd tools/gqrx
mkdir -p build
pushd build
GNURADIO_OSMOSDR_DIR=${DESTDIR}/usr/local cmake -Wno-dev ../
make -j4
make DESTDIR=${DESTDIR} install
popd
popd
