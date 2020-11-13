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
    base_url="https://download.01.org/intel-sgx/linux-2.3.1/ubuntu16.04/"; \
    \
    # PSW
    url="$base_url/libsgx-enclave-common_2.3.101.46683-1_amd64.deb"; \
    sha256="0bfbfc0fea3f1ac5c90c93081a1bcbbe56d42352c323e81abaeb21e21cc03e5b"; \
    wget -O libsgx-enclave-common.deb "$url" --progress=dot:giga; \
    echo "$sha256 *libsgx-enclave-common.deb" | sha256sum --strict --check -; \
    dpkg -i libsgx-enclave-common.deb; \
    rm -f libsgx-enclave-common.deb; \
    \
    # SDK
    url="$base_url/sgx_linux_x64_sdk_2.3.101.46683.bin"; \
    sha256="a664d41a41a95ea08034e6b5c1a47ec6796f12ee5b13612681978c0ae331cb74"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk
