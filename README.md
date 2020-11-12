# docker linux-sgx
Dockerfiles for [linux-sgx](https://github.com/intel/linux-sgx).

Currently only versions 2.6, 2.7.1, 2.9.1, and 2.11, for Ubuntu 18.04, are
provided. Please refer to the official repository,
https://github.com/intel/linux-sgx, for other versions.

Please note that there's also a `Dockerfile` for the SGX SDK version 2.1.3. It
does not have the PSW as installing the PSW for this version requires the driver.

Images are available on DockerHub under [initc3/linux-sgx](https://hub.docker.com/repository/docker/initc3/linux-sgx).

Example of usage:

```dockerfile
FROM initc3/linux-sgx:2.11

# ...
```
