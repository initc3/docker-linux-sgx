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

# SDK
RUN set -eux; \
    base_url='https://download.01.org/intel-sgx/sgx-linux/2.9.1/distro/ubuntu18.04-server'; \
    pkg='sgx_linux_x64_sdk_2.9.101.2.bin'; \
    url="$base_url/$pkg"; \
    sha256='365544fcccad0e806323e4b8a694d70d1440aaaf82ef817acfeadaa05737aa39'; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

# PSW
RUN set -eux; \
    echo 'deb [arch=amd64] \
        https://download.01.org/intel-sgx/sgx_repo/ubuntu bionic main' \
        | tee /etc/apt/sources.list.d/intel-sgx.list; \
    wget -qO - \
        https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key \
        | apt-key add -; \
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
    base_url='https://download.01.org/intel-sgx/sgx-linux/2.9.1'; \
    pkg='as.ld.objdump.gold.r1.tar.gz'; \
    url="$base_url/$pkg"; \
    sha256='eff285796ba97b4bcafc1e2c88534e486524d3295448207381cc9664a155e70d'; \
    wget "$url" --progress=dot:giga; \
    echo "$sha256 *$pkg" | sha256sum --strict --check -; \
    tar -xvf $pkg --directory /usr/local/bin/; \
    rm -f $pkg;

WORKDIR /opt/sgxsdk
