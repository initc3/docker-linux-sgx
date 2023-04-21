FROM python:3.11.3-buster as sdk

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
                build-essential \
                libcurl4-openssl-dev \
                libprotobuf-dev \
                libssl-dev \
                pkg-config \
                vim \
                wget \
        && rm -rf /var/lib/apt/lists/*

ARG INTEL_SGX_URL="https://download.01.org/intel-sgx"
ARG LINUX_SGX_VERSION="2.19"
ARG distro="Debian10"
ARG distro_codename="buster"

ARG INSTALL_ROOT_DIR="/opt/intel"
ARG SGX_SDK="${INSTALL_ROOT_DIR}/sgxsdk"

ENV SGX_SDK ${SGX_SDK}

# prebuilt binutils
RUN set -eux; \
    pkg="as.ld.objdump.r4.tar.gz"; \
    url="${INTEL_SGX_URL}/sgx-linux/${LINUX_SGX_VERSION}/${pkg}"; \
    sha256="85dcba642ee951686cb01479be377dc5da0b4f1597014679d1a29162f0dc8160"; \
    wget "${url}" --progress=dot:giga; \
    echo "${sha256} *${pkg}" | sha256sum --strict --check -; \
    tar -xvf ${pkg} --directory /usr/local/bin/; \
    rm -f ${pkg};

# SDK
ARG sdk_sha256="9af86d53636c4c0d6f1f6a040aee39c766480137e65151bd1adf578c24363aaf"

RUN set -eux; \
    version="2.19.100.3"; \
    pkg="sgx_linux_x64_sdk_${version}.bin"; \
    url="${INTEL_SGX_URL}/sgx-linux/${LINUX_SGX_VERSION}/distro/${distro}/${pkg}"; \
    wget -O sdk.bin "${url}" --progress=dot:giga; \
    echo "${sdk_sha256} *sdk.bin" | sha256sum --strict --check -; \
    chmod +x sdk.bin; \
    echo -e "no\n/${INSTALL_ROOT_DIR}" | ./sdk.bin; \
    echo "source ${SGX_SDK}/environment" >> /root/.bashrc; \
    rm -f sdk.bin;

# PSW
FROM sdk as psw

WORKDIR ${INSTALL_ROOT_DIR}

RUN set -eux; \
    pkgname="sgx_debian_local_repo"; \
    url="${INTEL_SGX_URL}/sgx-linux/${LINUX_SGX_VERSION}/distro/${distro}/${pkgname}.tgz"; \
    wget "${url}" --progress=dot:giga; \
    sha256="bc0a52dd7ad2023d176ddae3a1db1e895e16389dfe6f8a454508ad786c0c9a20"; \
    echo "${sha256} ${pkgname}.tgz" | sha256sum --strict --check -; \
    tar -xvf ${pkgname}.tgz; \
    echo "deb [trusted=yes arch=amd64] file:${INSTALL_ROOT_DIR}/${pkgname} ${distro_codename} main" \
                | tee /etc/apt/sources.list.d/${pkgname}.list;

RUN apt-get update && apt-get install -y --no-install-recommends \
                libsgx-epid \
                libsgx-quote-ex \
                libsgx-dcap-ql \
                libsgx-urts \
                libsgx-launch \
                libsgx-ae-le \
                libsgx-ae-pce \
                libsgx-ae-qe3 \
                libsgx-ae-qve \
                libsgx-ae-epid \
                libsgx-qe3-logic \
                libsgx-pce-logic \
                libsgx-dcap-quote-verify \
                libsgx-aesm-ecdsa-plugin \
                libsgx-aesm-epid-plugin \
                libsgx-aesm-launch-plugin \
                libsgx-aesm-quote-ex-plugin \
                libsgx-enclave-common \
                sgx-aesm-service \
                # dev \
                libsgx-enclave-common-dev \
                libsgx-dcap-ql-dev \
                libsgx-dcap-default-qpl-dev \
                # debug \
                libsgx-urts-dbgsym \
                libsgx-enclave-common-dbgsym \
                libsgx-dcap-ql-dbgsym \
                libsgx-dcap-default-qpl-dbgsym \
                libsgx-dcap-quote-verify-dev \
    && rm -rf /var/lib/apt/lists/*


# (Optional) If you intend to run an SGX application that loads an enclave requiring the
# Provision Key Access, the user needs to be added to the group "sgx_prv". Applications
# that obtain a quote from the DCAP Quote Generation library for the purposes of remote
# attestation may require Provision Key Access. Use the following command to add
# access for a user:
#RUN usermod -aG sgx_prv <username>

# (Optional) To run enclave apps on distros with default “sgx” group, the user needs to be
# added to the group of "sgx ". Use the following command to add access for a user:
#RUN usermod -aG sgx <username>
