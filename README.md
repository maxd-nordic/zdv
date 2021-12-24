# zdv
Zephyr DAPLink Validation

## Build instructions

Follow the [Zephyr Getting Started Guide](https://docs.zephyrproject.org/2.7.0/getting_started) to setup the build environment. This project is tested using the [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm), you can also look at [the relevant section in Zephyr documentation](https://docs.zephyrproject.org/2.7.0/getting_started/toolchain_3rd_party_x_compilers.html#gnu-arm-embedded).

- Install the toolchain.
- Set `ZEPHYR_TOOLCHAIN_VARIANT` to `gnuarmemb`, and `GNUARMEMB_TOOLCHAIN_PATH` to the toolchain installation directory.
  ```
  export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
  export GNUARMEMB_TOOLCHAIN_PATH=/usr/local/gcc-arm-embedded/10.3-2021.07
  ```

```
$ mkdir zdv-workspace
$ cd zdv-workspace
$ west init -m git@github.com:mbrossard/zdv.git
$ west update
$ make -f zdv/build.mk
```

## Contributors

- [Frank Duignan](https://github.com/fduignan) helped this project get started. See his [Zephyr OS examples for BBC micro:bit v2](https://github.com/fduignan/zephyr_bbc_microbit_v2).
