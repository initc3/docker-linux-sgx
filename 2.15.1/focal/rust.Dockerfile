FROM linux-sgx:sdk-2.15.1

ARG rust_toolchain="nightly-2021-08-01"
ENV rust_toolchain ${rust_toolchain}

RUN apt-get update && apt-get install --yes \
                curl \
            && rm -rf /var/lib/apt/lists/*

# Taken from https://github.com/apache/incubator-teaclave-sgx-sdk/blob/master/dockerfile/05_rust.sh
RUN set -eux; \
    cd /root; \
    url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"; \
    curl "$url" --output /root/rustup-init; \
    chmod +x /root/rustup-init; \
    echo "1" | /root/rustup-init --default-toolchain "$rust_toolchain"; \
    echo "source /root/.cargo/env" >> /root/.bashrc; \
    /root/.cargo/bin/rustup component add rust-src rls rust-analysis clippy rustfmt; \
    /root/.cargo/bin/cargo install xargo; \
    rm /root/rustup-init; \
    rm -rf /root/.cargo/registry; \
    rm -rf /root/.cargo/git;

# See https://github.com/apache/incubator-teaclave-sgx-sdk/blob/master/dockerfile/Dockerfile.2004.nightly
# for a list of dependencies that may be necessary to work with the Rust SGX
# SDK
RUN apt update && apt install --yes \
            cmake \
    && rm -rf /var/lib/apt/lists/*
