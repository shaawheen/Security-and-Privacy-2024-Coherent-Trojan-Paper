# Building with the framework {#compilation}

[TOC]

This page will guide the user in building benchmarks with RT-Bench.

## Dependencies

In the current implementation the framework has some
dependencies the user has to be aware of:

- A shell that can run scripts in Bash >= 5.
- git >= 2.37.
- git LFS >= 2.13: _Optional._ For the [Image Filters](https://rt-bench.gitlab.io/rt-bench/group__image-filters.html) module.
- Glibc: Provides primitives used by the memory watcher and the argument parser.
- POSIX.4 real-time signals: used to execute the benchmark periodically and to gather stats.
- Linux scheduler syscalls: Used to change the scheduling policy.
- Linux Perf: Used to read performance counters (currently only on CORTEX A53)
- [JSON-C](https://github.com/json-c/json-c) >= 0.15: _Optional._ Used to read and parse input JSON configuration files.
- [imagemagick](https://imagemagick.org/) >= 7.1.0-45 _Optional._ For the [Image Filters](https://rt-bench.gitlab.io/rt-bench/group__image-filters.html) module.

Currently RT-Bench targets the following platforms:
- x86/x86_64
- ARM64

For [Nix](https://nixos.org/) users a flake and a [direnv](https://direnv.net/) environment are available to make sure that all the dependencies are satisfied.

#### Dependence installation
  The `json-c` dependence can be installed with the following command:
- Ubuntu/Debian:
```{.sh}
sudo apt install libjson-c5 libjson-c-dev
```
- Fedora / OpenSuse:
```{.sh}
sudo dnf install json-c json-c-devel
```
- Arch Linux:
```{.sh}
sudo pacman -S json-c
```

## Compiling RT-Bench

Compiling a RT-Bench compliant benchmark (see [benchmark structure](3-Extending_rt-bench.markdown)) with the framework using the provided `Makefile` structure is easy and the best way to benefit from all the features offered by RT-Bench.

The `Makefile` provided in [Isolbench]() is a good example of how to use the provided makefile interface/variables.

Typically, once `generator/rtbench.mk` is included, five different variables are accessible:
 - `rtbench`: recipe to initialize and build the RT-Bench core components for the desired target
 - `CC`: user specified compiler for the desired target
 - `CFLAGS`: compilation flags. Automatically set by the `generator/rtbench.mk`, can be complemented with `override`
 - `BASE_O`: set of object files for the RT-Bench core components
 - `LDFLAGS`: linker flags. Automatically set by the `generator/rtbench.mk`, can be complemented with `override`

Using these variables and recipes, we recomend to write recipes for compiling your benchmark with the following template:
```{.mk}
<benchmark>: rtbench
	$(CC) $(CFLAGS) <benchmark>.c $(BASE_O) -o <benchmark> $(LDFLAGS)
```

## Optional RT-Bench specific options

In addition, RT-Bench supports dedicated flags that enable access to further features. These features are not part of the default set of features as they depend on the benchmark nature itself or on the platform on which the benchmarks will be deployed.

#### Extended Reporting (Benchmark Specific Measurement Reporting)

Some benchmark classes (e.g., synthetic workloads) measure specific impact on the platform. RT-Bench offers the possibility to extend the existing `.csv` report interface to include the desired _benchmark-specific_ measurement. Providing the benchmarks follows the rules mentioned in [benchmark structure](3-Extending_rt-bench.markdown), extended reporting can be enabled by adding the `-DEXTENDED_REPORT` flag in the compilation command line.

#### JSON configuration files support {#json_support}
To keep the mandatory dependencies to a minimum, the support for parsing JSON configuration files (`-g` option) is disabled.
To enable parsing of JSON files, the [JSON-C](https://github.com/json-c/json-c) library must be at least at version 0.15 and the `-DJSON_SUPPORT` flag must be added to the compilation command line.

This feature can be enabled on-the-fly while issuing a make commad by defining the `JSON=1` variable.

#### Performance counters and monitoring thread {#perf_support}

This set of feature being specific to the core and platform on which the benchmark will be deployed, two parameters must be added in other to enable them: the ISA and the core model. The table below lists of the flags to add and provide examples of compliant/tested platforms and CPU models.

Additionally, there are equivalent Make variables that will enable the corresponding parameters when issuing a `make` command.

|     ISA     |      CORE      |   Make Variable   | Platform/CPU Model  |
| :---------: | :------------: | :----------------:| :-----------------: |
| `-DAARCH64` | `-DCORTEX_A53` | `CORE=CORTEX_A53` | Xilinx ZCU102       |
| `-DX86_64`  | `-DCORE_I7`    | `CORE=CORE_I7`    | Intel Core i7-8550U |

@author Mattia Nicolella, Denis Hoornaert
@copyright (C) 2021 - 2022, Denis Hoornaert <denis.hoornaert@tum.de>, Mattia Nicolella <mnico@bu.edu> and the rt-bench contributors.
SPDX-License-Identifier: MIT
