FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
                build-essential \
                libcurl4-openssl-dev \
                libprotobuf-dev \
                libssl-dev \
                pkg-config \
                wget \
        && rm -rf /var/lib/apt/lists/*

ENV INTEL_SGX_URL https://download.01.org/intel-sgx

# SDK
RUN set -eux; \
    base_url="$INTEL_SGX_URL/sgx-linux/2.13/distro/ubuntu20.04-server"; \
    pkg="sgx_linux_x64_sdk_2.13.100.4.bin"; \
    url="$base_url/$pkg"; \
    sha256="e00dd32f4d1f38892fde843a247471b759745f1815dfc57ba61db61f8c05be24"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

# PSW
RUN set -eux; \
    url="$INTEL_SGX_URL/sgx_repo/ubuntu"; \
    echo "deb [arch=amd64] $url focal main" \
                | tee /etc/apt/sources.list.d/intel-sgx.list; \
    wget -qO - "$url/intel-sgx-deb.key" | apt-key add -; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
                libsgx-headers \
                libsgx-ae-epid \
                libsgx-ae-le \
                libsgx-ae-pce \
                libsgx-aesm-epid-plugin \
                libsgx-aesm-launch-plugin \
                libsgx-aesm-pce-plugin \
                libsgx-aesm-quote-ex-plugin \
                libsgx-enclave-common \
                libsgx-enclave-common-dev \
                libsgx-epid \
                libsgx-epid-dev \
                libsgx-launch \
                libsgx-launch-dev \
                libsgx-quote-ex \
                libsgx-quote-ex-dev \
                libsgx-uae-service \
                libsgx-urts \
                sgx-aesm-service; \
    rm -rf /var/lib/apt/lists/*;

# binutils
RUN set -eux; \
    base_url="$INTEL_SGX_URL/sgx-linux/2.13"; \
    pkg="as.ld.objdump.gold.r3.tar.gz"; \
    url="$base_url/$pkg"; \
    sha256="794963ca90fb0561caf3ed2bee1d9ba394226f355689cdda28161e6e0620a713"; \
    wget "$url" --progress=dot:giga; \
    echo "$sha256 *$pkg" | sha256sum --strict --check -; \
    tar -xvf $pkg --directory /usr/local/bin/; \
    rm -f $pkg;

WORKDIR /opt/sgxsdk
