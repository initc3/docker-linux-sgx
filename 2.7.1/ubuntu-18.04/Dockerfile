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
    base_url='https://download.01.org/intel-sgx/sgx-linux/2.7.1/distro/ubuntu18.04-server'; \
	\
    # workaround for PSW deb pkgs 
    # see https://github.com/intel/linux-sgx/issues/395
    mkdir /etc/init; \
    \
    # PSW
    pkg='libsgx-enclave-common_2.7.101.3-bionic1_amd64.deb'; \
    url="$base_url/$pkg"; \
    sha256='8beb502569cc616937caa756b528114d88dba25d3da3c03856a7585216d774af'; \
    wget -O libsgx-enclave-common.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common.deb; \
    rm -f libsgx-enclave-common.deb; \
    \
    # PSW dev
    pkg='libsgx-enclave-common-dev_2.7.101.3-bionic1_amd64.deb'; \
    url="$base_url/$pkg"; \
    sha256='8dafa261eaf3ba817f1423ffc1172b38fa41e69985df4bab27987c16ec9dafdc'; \
    wget -O libsgx-enclave-common-dev.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common-dev.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common-dev.deb; \
    rm -f libsgx-enclave-common-dev.deb; \
    \
    # PSW debug
    pkg='libsgx-enclave-common-dbgsym_2.7.101.3-bionic1_amd64.ddeb'; \
    url="$base_url/$pkg"; \
    sha256='0481cc195b6dc213f3390571f3efce78c97ec52c3726a422087d280589f7174b'; \
    wget -O libsgx-enclave-common-dbgsym.ddeb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common-dbgsym.ddeb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common-dbgsym.ddeb; \
    rm -f libsgx-enclave-common-dbgsym.ddeb; \
    \
    # SDK
    pkg='sgx_linux_x64_sdk_2.7.101.3.bin'; \
    url="$base_url/$pkg"; \
    sha256='fb891626b853c0e4ee1fc74818a29f9b2caf392746229426ed0966e704891b46'; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk
