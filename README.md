# docker linux-sgx
Dockerfiles for [linux-sgx](https://github.com/intel/linux-sgx).

Provided versions:

SGX version | OS | SDK | PSW | SGX SSL
--- | --- | --- | --- | ---
2.1.3 | Ubuntu 16.04 | :heavy_check_mark: | :x: | :x:
2.2 | Ubuntu 16.04 | :heavy_check_mark: | :x: | :x:
2.3.1 | <br>Ubuntu 16.04</br><br>Ubuntu 18.04</br> | <br>:heavy_check_mark:</br><br>:heavy_check_mark:</br> | <br>:x:</br><br>:heavy_check_mark:</br> | :x:
2.6 | <br>Ubuntu 16.04</br><br>Ubuntu 18.04</br> | :heavy_check_mark: | :heavy_check_mark: | :x:
2.7.1 | Ubuntu 18.04 | :heavy_check_mark: | :heavy_check_mark: | :x:
2.9.1 | Ubuntu 18.04 | :heavy_check_mark: | :heavy_check_mark: | :x:
2.11 | Ubuntu 18.04 | :heavy_check_mark: | :heavy_check_mark: | :x:
2.12 | Ubuntu 18.04 | :heavy_check_mark: | :heavy_check_mark: | :x:
2.13 | <br>Ubuntu 18.04</br><br>Ubuntu 20.04</br> | :heavy_check_mark: | :heavy_check_mark: | :x:
2.13.3 | <br>Ubuntu 18.04</br><br>Ubuntu 20.04</br> | :heavy_check_mark: | :heavy_check_mark: | :x:
2.14 | <br>Ubuntu 20.04</br> | :heavy_check_mark: | :heavy_check_mark: | :x:
2.15.1 | <br>Ubuntu 20.04</br> | :heavy_check_mark: | :heavy_check_mark: | :x:
2.16 | <br>Ubuntu 20.04</br> | :heavy_check_mark: | :heavy_check_mark: | :x:
2.17 | <br>Ubuntu 20.04</br> | :heavy_check_mark: | :heavy_check_mark: | :x:
2.17.1 | <br>Ubuntu 20.04</br> | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark:

Please refer to the official repository,
https://github.com/intel/linux-sgx, for other versions.

Images are available on DockerHub under
[initc3/linux-sgx](https://hub.docker.com/repository/docker/initc3/linux-sgx).

Example of usage:

```dockerfile
FROM initc3/linux-sgx:2.17.1

# ...
```
