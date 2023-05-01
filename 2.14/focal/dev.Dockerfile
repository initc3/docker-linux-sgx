FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --yes \
                autoconf \
                automake \
                build-essential \
                cmake \
                curl \
                debhelper \
                git \
                libcurl4-openssl-dev \
                libprotobuf-dev \
                libssl-dev \
                libtool \
                lsb-release \
                ocaml \
                ocamlbuild \
                protobuf-compiler \
                python-is-python3 \
                wget \
                libcurl4 \
                libssl1.1 \
                make \
                g++ \
    && rm -rf /var/lib/apt/lists/*

# nasm 2.15, to build ipp-crypto
RUN set -eux; \
    \
    wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.xz; \
    tar -xvf nasm-2.15.05.tar.xz; \
    cd nasm-2.15.05; \
    ./configure --prefix=/usr; \
    make; \
    make install;

WORKDIR /usr/src
RUN set -eux; \
    \
    git clone --branch sgx_ippcp.h-sgx_2.13.3 https://github.com/sbellem/linux-sgx.git; \
    cd linux-sgx; \
    git checkout b0823af5cd9760a5da468e50434c7feb7280a6dd;

WORKDIR /usr/src/linux-sgx
