FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
                build-essential \
                libcurl4-openssl-dev \
                libprotobuf-dev \
                libssl-dev \
                pkg-config \
                wget \
        && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    base_url='https://download.01.org/intel-sgx/linux-2.6/ubuntu16.04-server'; \
    \
    # PSW
    url="$base_url/libsgx-enclave-common_2.6.100.51363-xenial1_amd64.deb"; \
    sha256="fb6efce6d2485b2830669d2421e109e52a62c22d9c8ca1aed9fc7938e5245f3f"; \
    wget -O libsgx-enclave-common.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common.deb; \
    rm -f libsgx-enclave-common.deb; \
    \
    # PSW dev
    url="$base_url/libsgx-enclave-common-dev_2.6.100.51363-xenial1_amd64.deb"; \
    sha256="276f7e1b5c33c6be6233004dce18502fba72bbd4e8bb0b784b39342ff586d741"; \
    wget -O libsgx-enclave-common-dev.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common-dev.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common-dev.deb; \
    rm -f libsgx-enclave-common-dev.deb; \
    \
    # SDK
    url="$base_url/sgx_linux_x64_sdk_2.6.100.51363.bin"; \
    sha256="338d606b05612b76780acfc5ccbccc724447235677a1a4d7632e2f113658f9cc"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk
