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

ENV INTEL_SGX_URL https://download.01.org/intel-sgx

# SDK
RUN set -eux; \
    base_url="$INTEL_SGX_URL/sgx-linux/2.11/distro/ubuntu18.04-server"; \
    pkg="sgx_linux_x64_sdk_2.11.100.2.bin"; \
    url="$base_url/$pkg"; \
    sha256="490ebe4a6972870626fdec0146ffa6f1ce2cfa73194a70002b98f70286bbbb90"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

# PSW
RUN set -eux; \
    url="$INTEL_SGX_URL/sgx_repo/ubuntu"; \
    echo "deb [arch=amd64] $url bionic main" \
                | tee /etc/apt/sources.list.d/intel-sgx.list; \
    wget -qO - "$url/intel-sgx-deb.key" | apt-key add -; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
                libsgx-aesm-launch-plugin \
                libsgx-enclave-common \
                libsgx-enclave-common-dev \
                libsgx-epid \
                libsgx-epid-dev \
                libsgx-launch \
                libsgx-launch-dev \
                libsgx-quote-ex \
                libsgx-quote-ex-dev \
                libsgx-uae-service \
                libsgx-urts; \
    rm -rf /var/lib/apt/lists/*;

# binutils
RUN set -eux; \
    base_url="$INTEL_SGX_URL/sgx-linux/2.11"; \
    pkg="as.ld.objdump.gold.r2.tar.gz"; \
    url="$base_url/$pkg"; \
    sha256="97f623594960e4b3313cda2496bee2cef18191d86b4f07f89e8eef8eee7135e0"; \
    wget "$url" --progress=dot:giga; \
    echo "$sha256 *$pkg" | sha256sum --strict --check -; \
    tar -xvf $pkg --directory /usr/local/bin/; \
    rm -f $pkg;

WORKDIR /opt/sgxsdk
