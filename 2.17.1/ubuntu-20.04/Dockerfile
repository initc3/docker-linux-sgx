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
ENV LINUX_SGX_VERSION "2.17.1"
ENV LINUX_SGX_MAJOR_MINOR_VERSION "2.17"

ARG INSTALL_ROOT_DIR="/opt/intel"
ARG SGX_SDK="${INSTALL_ROOT_DIR}/sgxsdk"
ENV SGX_SDK ${SGX_SDK}

# prebuilt binutils
RUN set -eux; \
    pkg="as.ld.objdump.r4.tar.gz"; \
    url="${INTEL_SGX_URL}/sgx-linux/${LINUX_SGX_MAJOR_MINOR_VERSION}/${pkg}"; \
    sha256="9e4eb03442d26d38d59f47f796389ad919f33d5598dc3825dcd750b8dc55e9d2"; \
    wget "${url}" --progress=dot:giga; \
    echo "${sha256} *${pkg}" | sha256sum --strict --check -; \
    tar -xvf ${pkg} --directory /usr/local/bin/; \
    rm -f ${pkg};

# SDK
RUN set -eux; \
    distro="ubuntu20.04-server"; \
    pkg="sgx_linux_x64_sdk_2.17.101.1.bin"; \
    url="${INTEL_SGX_URL}/sgx-linux/${LINUX_SGX_VERSION}/distro/${distro}/${pkg}"; \
    sha256="a9546afa218418c46a7a5262aa07748d940c686ebae0097e3f4c6d4c67985cda"; \
    wget -O sdk.bin "${url}" --progress=dot:giga; \
    echo "$sha256 *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e "no\n/${INSTALL_ROOT_DIR}" | ./sdk.bin; \
    echo "source ${SGX_SDK}/environment" >> /root/.bashrc; \
    rm -f sdk.bin;

WORKDIR ${SGX_SDK}


# PSW
FROM sdk as psw

RUN set -eux; \
    url="${INTEL_SGX_URL}/sgx_repo/ubuntu"; \
    echo "deb [arch=amd64] ${url} focal main" \
                | tee /etc/apt/sources.list.d/intel-sgx.list; \
    wget -qO - "${url}/intel-sgx-deb.key" | apt-key add -; \
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


# SGX SSL
FROM psw as ssl

# NOTE Versions for openssl and sgx ssl should match.
# See the intel-sgx-ssl repo tags for more information.
ARG OPENSSL_VERSION="1.1.1q"
ARG SGX_SSL_COMMIT="150056cf7427a6b2e7d3bed544fcc985dfac29bb"
ARG SGX_MODE=SIM
ARG SGX_SSL="${INSTALL_ROOT_DIR}/sgxssl"

ENV SGX_SSL ${SGX_SSL}

RUN apt-get update && apt-get install -y \
                git \
                nasm \
        && rm -rf /var/lib/apt/lists/*

WORKDIR ${SGX_SSL}

ENV PKG_CONFIG_PATH ${SGX_SDK}/pkgconfig
ENV LD_LIBRARY_PATH ${SGX_SDK}/sdk_libs
ENV PATH ${PATH}:${SGX_SDK}/bin:${SGX_SDK}/bin/x64

RUN set -eux; \
    git clone https://github.com/intel/intel-sgx-ssl.git ${SGX_SSL}; \
    git checkout ${SGX_SSL_COMMIT}; \
    \
    pkg="openssl-${OPENSSL_VERSION}.tar.gz"; \
    openssl_url="https://www.openssl.org/source/${pkg}"; \
    sha256="d7939ce614029cdff0b6c20f0e2e5703158a489a72b2507b8bd51bf8c8fd10ca"; \
    wget ${openssl_url} -P openssl_source; \
    echo "${sha256} openssl_source/${pkg}" | sha256sum --strict --check -; \
    \
    make -C Linux sgxssl_no_mitigation SGX_MODE=${SGX_MODE}; \
    DESTDIR=${SGX_SSL} make -C Linux install;
