FROM ubuntu:20.04 as sdk

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
                build-essential \
                libcurl4-openssl-dev \
                libprotobuf-dev \
                libssl-dev \
                pkg-config \
                wget \
        && rm -rf /var/lib/apt/lists/*

ENV INTEL_SGX_URL "https://download.01.org/intel-sgx"
ENV LINUX_SGX_VERSION "2.15.1"

# prebuilt binutils
RUN set -eux; \
    pkg="as.ld.objdump.r4.tar.gz"; \
    url="${INTEL_SGX_URL}/sgx-linux/${LINUX_SGX_VERSION}/${pkg}"; \
    sha256="89be60f5736ef9387921a28cf8ceaddb29debea5e14969dfd21c97f546a4071e"; \
    wget "$url" --progress=dot:giga; \
    echo "$sha256 *$pkg" | sha256sum --strict --check -; \
    tar -xvf $pkg --directory /usr/local/bin/; \
    rm -f $pkg;

# SDK
RUN set -eux; \
    distro="ubuntu20.04-server"; \
    pkg="sgx_linux_x64_sdk_2.15.101.1.bin"; \
    url="$INTEL_SGX_URL/sgx-linux/${LINUX_SGX_VERSION}/distro/${distro}/${pkg}"; \
    sha256="21c633c271eafb3a1d15d604526ec2f827a4606ef91bac78a756bae7bed73dac"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk


# PSW
FROM sdk as psw

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
