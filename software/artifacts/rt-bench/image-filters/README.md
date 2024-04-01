<!-- @defgroup image-filters Image filters
@ingroup benchmarks
@brief Image filters. -->

# Image filters

This page should be read from the corresponding [documentation page](https://rt-bench.gitlab.io/rt-bench/group__image-filters.html) of RT-Bench for better fruition.

### Documentation

Find the full documentation on the [RT-Bench wiki](https://rt-bench.gitlab.io/rt-bench/index.html).

### Usage

This module is registered as a submodule of RT-Bench, from which it also depends.

#### Setup

The suggested way to compile benchmarks in this module requires the user to:

- Clone RT-Bench: `git clone https://gitlab.com/rt-bench/rt-bench.git`.
- Initialize the submodule by typing, from the RT-Bench root folder `make setup-image-filters`

#### Compilation

Compilation is done from the `image-filters` folder (the module root folder).

To compile the whole suite, you can simply type:
```{.sh}
make
```

Otherwise a single benchmark can be compiled by typing `make` followed by the path to the benchmark.
For example to compile only the `grayscale` benchmark
```{.sh}
make grayscale
```

Finally, the whole suite can be compiled directly from the RT-Bench root folder by typing:
```{.sh}
make compile-image-filters
```

By default, it will compile for the ISA of the platform in use (i.e., call to `gcc`) and assumes RT-Bench is the parent folder.
Append these options to the `make` command to tailor compilation to your needs

- ```CC=<compiler>``` for cross-compiling
- ```RTBENCH_PATH=<path/to/rtbench/repository>``` to specify the location of the RT-bench project/repository used
- ```CORE=<core-model>``` to enable performance counters features

See the compilation flags guide in the [RT-Bench wiki](https://rt-bench.gitlab.io/rt-bench/compilation.html) for further details.

#### Example

All benchmark in `image-filters` take two arguments: (1) the path to the input BMP image, and (2) the path to the output BMP image.
For instance, the canny filter can be launch as follows
```{.sh}
./canny -d 1 -p 1 -b "inputs/vga.bmp canny.bmp"
```

### Citing projects

If you have found this project useful, please consider citing RT-Bench.

RT-Bench:
```
@inproceedings{10.1145/3534879.3534888,
	author = {Nicolella, Mattia and Roozkhosh, Shahin and Hoornaert, Denis and Bastoni, Andrea and Mancuso, Renato},
	title = {RT-Bench: An Extensible Benchmark Framework for the Analysis and Management of Real-Time Applications},
	year = {2022},
	isbn = {9781450396509},
	publisher = {Association for Computing Machinery},
	address = {New York, NY, USA},
	url = {https://doi.org/10.1145/3534879.3534888},
	doi = {10.1145/3534879.3534888},
	booktitle = {Proceedings of the 30th International Conference on Real-Time Networks and Systems},
	pages = {184–195},
	numpages = {12},
	keywords = {portable, framework, real-time, profiling, extensible, periodic, benchmark suite, open-source, interference},
	location = {Paris, France},
	series = {RTNS 2022}
}
```

<!-- @author Denis Hoornaert, for the current file only.
@copyright This file is under the SPDX-License-Identifier: MIT
Individual benchmarks are subject to their original license, specified in each file. -->
