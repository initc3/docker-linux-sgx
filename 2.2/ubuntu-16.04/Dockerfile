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
    base_url="https://download.01.org/intel-sgx/linux-2.2/ubuntu64-server/"; \
	\
    # PSW
    #url="$base_url/sgx_linux_x64_psw_2.2.100.45311.bin"; \
    #sha256="2633ac129a70fcbe4d0f2ff9c328b309e743e3b7dfbdcf83747214dee237a8b3"; \
    #wget -O psw.bin "$url" --progress=dot:giga; \
    #echo "$sha256 *psw.bin" | sha256sum --strict --check -; \
    #chmod +x ./psw.bin; \
    #./psw.bin; \
    #rm -f psw.bin; \
    #\
    # SDK
    url="$base_url/sgx_linux_x64_sdk_2.2.100.45311.bin"; \
    sha256="f5b639f1f6a4f5d2a90439a0419313db7160e4a111c51cf25223dc02d8ac8866"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk
