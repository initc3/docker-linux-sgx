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
2.18 | <br>Ubuntu 20.04</br><br>Ubuntu 22.04</br> | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark:
2.19 | <br>Ubuntu 22.04</br> | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark:
2.19 | <br>Debian 10</br> | :heavy_check_mark: | :heavy_check_mark:

Please refer to the official repository,
https://github.com/intel/linux-sgx, for other versions.

Images are available on under [ghcr.io/initc3/linux-sgx][ghcr.io/initc3/linux-sgx].


## Usage

```dockerfile
FROM ghcr.io/initc3/linux-sgx:2.19-buster

# ...
```

[ghcr.io/initc3/linux-sgx]: https://github.com/initc3/docker-linux-sgx/pkgs/container/linux-sgx
