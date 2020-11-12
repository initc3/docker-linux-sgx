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
    base_url="https://download.01.org/intel-sgx/linux-2.1.3/ubuntu64-server/"; \
	\
    # PSW
    #url="$base_url/sgx_linux_x64_psw_2.1.103.44322.bin"; \
    #sha256="ca3c481474dea0a3cb03b619def692ca76b6c43e426a2d4e339728af5fef1c07"; \
    #wget -O psw.bin "$url" --progress=dot:giga; \
    #echo "$sha256 *psw.bin" | sha256sum --strict --check -; \
    #chmod +x ./psw.bin; \
    #./psw.bin; \
    #rm -f psw.bin; \
    #\
    # SDK
    url="$base_url/sgx_linux_x64_sdk_2.1.103.44322.bin"; \
    sha256="f4aff5fcd057170b3e149d934dd7141853b290946abbfa2a98733ce28a57b896"; \
    wget -O sdk.bin "$url" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e 'no\n/opt' | ./sdk.bin; \
    echo 'source /opt/sgxsdk/environment' >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR /opt/sgxsdk
