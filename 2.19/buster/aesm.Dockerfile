FROM buildpack-deps:buster-curl as aesm-buster

LABEL org.opencontainers.image.source=https://github.com/initc3/docker-linux-sgx/tree/master/2.19/debian-10
LABEL org.opencontainers.image.description="Linux SGX AESM service v2.19 for Debian 10 (buster)"
LABEL org.opencontainers.image.licenses=BSD-3-Clause

RUN apt-get update && apt-get install -y \
		libprotobuf17 \	
    && rm -rf /var/lib/apt/lists/*

ARG sgx_url="https://download.01.org/intel-sgx"
ARG sgx_version="2.19"
ARG distro="Debian10"
ARG distro_codename="buster"
ARG sgx_dir="/opt/intel"
ARG deb_pkg="sgx_debian_local_repo"

WORKDIR ${sgx_dir}

RUN set -eux; \
    url="${sgx_url}/sgx-linux/${sgx_version}/distro/${distro}/${deb_pkg}.tgz"; \
    wget "${url}" --progress=dot:giga; \
    sha256="bc0a52dd7ad2023d176ddae3a1db1e895e16389dfe6f8a454508ad786c0c9a20"; \
    echo "${sha256} ${deb_pkg}.tgz" | sha256sum --strict --check -; \
    tar -xvf ${deb_pkg}.tgz; \
    echo "deb [trusted=yes arch=amd64] file:${sgx_dir}/${deb_pkg} ${distro_codename} main" \
                | tee /etc/apt/sources.list.d/${deb_pkg}.list; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
				libsgx-ae-epid \
				libsgx-ae-id-enclave \
				libsgx-ae-le \
				libsgx-ae-pce \
				libsgx-ae-qe3 \
				libsgx-aesm-ecdsa-plugin \
				libsgx-aesm-epid-plugin \
				libsgx-aesm-launch-plugin \
				libsgx-aesm-pce-plugin \
				libsgx-aesm-quote-ex-plugin \
				libsgx-enclave-common \
				libsgx-launch \
				libsgx-pce-logic \
				libsgx-qe3-logic \
				libsgx-urts \
				sgx-aesm-service; \
    rm -rf /var/lib/apt/lists/*; \
	rm ${deb_pkg}.tgz;

RUN groupadd sgx && groupadd sgx_priv
RUN useradd -G sgx,sgx_priv aesm 

USER aesm

WORKDIR /opt/intel/sgx-aesm-service/aesm/
ENV LD_LIBRARY_PATH=.
CMD ./aesm_service --no-daemon
