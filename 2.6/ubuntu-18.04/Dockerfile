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
    base_url='https://download.01.org/intel-sgx/linux-2.6/ubuntu18.04-server'; \
	\
    # workaround for PSW deb pkgs 
    # see https://github.com/intel/linux-sgx/issues/395
    mkdir /etc/init; \
    \
    # PSW
    url="$base_url/libsgx-enclave-common_2.6.100.51363-bionic1_amd64.deb"; \
    sha256='a52580cb8537eaf46f0e2b0b791e49754ce9aa1e495e60025032b49eba847ffc'; \
    wget -O libsgx-enclave-common.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common.deb; \
    rm -f libsgx-enclave-common.deb; \
    \
    # PSW dev
    url="$base_url/libsgx-enclave-common-dev_2.6.100.51363-bionic1_amd64.deb"; \
    sha256='e599d6875dd57068bd94b4abc613a1efa92744feb20e2769d5c740677568992a'; \
    wget -O libsgx-enclave-common-dev.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common-dev.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common-dev.deb; \
    rm -f libsgx-enclave-common-dev.deb; \
    \
    # PSW debug
    url="$base_url/libsgx-enclave-common-dbgsym_2.6.100.51363-bionic1_amd64.ddeb"; \
    sha256='6a5263b45abb783d1e82c4f30e65a40a66bb68d33d418e3745d21b9b5571f1df'; \
    wget -O libsgx-enclave-common-dbgsym.ddeb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common-dbgsym.ddeb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common-dbgsym.ddeb; \
    rm -f libsgx-enclave-common-dbgsym.ddeb; \
    \
    # SDK
    url="$base_url/sgx_linux_x64_sdk_2.6.100.51363.bin"; \
    sha256='70933fa3dc7f3de64f18cc50cc58e469ed3ffb07059cec15e0b083fe7a70b12b'; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk
