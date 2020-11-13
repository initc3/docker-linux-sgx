FROM ubuntu:18.04

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
    base_url="https://download.01.org/intel-sgx/linux-2.3.1/ubuntu18.04/"; \
	\
    # workaround for PSW deb pkgs 
    # see https://github.com/intel/linux-sgx/issues/395
    mkdir /etc/init; \
    \
    # PSW
    url="$base_url/libsgx-enclave-common_2.3.101.46683-1_amd64.deb"; \
    sha256="2b29bb006cd2542e417d92ebf4bb7c7f1effac144698ae6746e98427e99df308"; \
    wget -O libsgx-enclave-common.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common.deb; \
    rm -f libsgx-enclave-common.deb; \
    \
    # PSW debug
    url="$base_url/libsgx-enclave-common-dbgsym_2.3.101.46683-1_amd64.ddeb"; \
    sha256="d0bc04e5df635cbf70e3417c3031accd5d90cc3c46f989fcc7ddd8a5cd1e236d"; \
    wget -O libsgx-enclave-common-dbgsym.ddeb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common-dbgsym.ddeb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common-dbgsym.ddeb; \
    rm -f libsgx-enclave-common-dbgsym.ddeb; \
    \
    # SDK
    url="$base_url/sgx_linux_x64_sdk_2.3.101.46683.bin"; \
    sha256="6483fd98dfaabf6f2ad2987b7bba562fabb92fb0da19285c7a298d5080b8de13"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk
