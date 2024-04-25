#!/bin/bash
#run first 'sudo docker run --rm --privileged multiarch/qemu-user-static --reset -p yes' and add gcc-i686-linux-gnu
mkdir tmp
mkdir bin
git clone https://github.com/esnet/iperf.git tmp/base
ARCHS=("arm-linux-gnueabi" "arm-linux-gnueabihf" "aarch64-linux-gnu")
for arch in "${ARCHS[@]}"; do
	cp -R tmp/base tmp/"$arch"
	sudo docker run --rm -v "$(pwd)"/tmp/"$arch":/workdir \
				-e CROSS_TRIPLE="$arch" \
				-e CXXFLAGS=--static \
				-e CPPFLAGS=--static \
				-e LDFLAGS=--static multiarch/crossbuild bash -c './configure --disable-shared --enable-static --enable-static-bin && make -j$(nproc) && make install'
	BIN=$(echo "$arch" | sed 's/-linux-gnueabihf/v7l/' | sed 's/-linux-gnueabi//' | sed 's/-linux-gnu//')
	cp tmp/"$arch"/src/iperf3 bin/iperf-"$BIN"
done

cp -R tmp/base tmp/x86_64
cd tmp/x86_64
sudo ./configure --disable-shared --enable-static --enable-static-bin \
		CXXFLAGS="--static" \
		CPPFLAGS="--static"
sudo make -j$(nproc)
cd ../../
cp tmp/x86_64/src/iperf3 bin/iperf-x64

cp -R tmp/base tmp/i386
cd tmp/i386
sudo ./configure --disable-shared --enable-static --enable-static-bin --host=i686-linux-gnu --build=i686-linux-gnu \
		CXXFLAGS="--static -m32 -march=i686 -O3" \
		CPPFLAGS="--static -m32 -march=i686 -O3"
sudo make -j$(nproc)
cd ../../
cp tmp/i386/src/iperf3 bin/iperf-x86
sudo chown -R 777 tmp/