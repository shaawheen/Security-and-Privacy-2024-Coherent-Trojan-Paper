<!-- @defgroup rt-tacle-bench RT-TACLeBench
@ingroup benchmarks
@brief The TACLe benchmark collection. -->

# RT-TACLeBench

This page should be read from the corresponding [documentation page](https://rt-bench.gitlab.io/rt-bench/md_rt_tacle_bench__r_e_a_d_m_e.html) of RT-Bench for better fruition.

This module contains a version of [TACLe-Bench](https://github.com/tacle/tacle-bench) adapted to work with the [RT-Bench framework](https://gitlab.com/rt-bench/rt-bench).

The only benchmarks currently supported are in folders `app/`, `kernel/` and `sequential/`.
`test` and `parallel` folders have been excluded from the documentation.

### Documentation

Find the original documentation on the [TACLe-Bench original repository](https://github.com/tacle/tacle-bench/tree/master/doc) and RT-Bench documentation on the [original repository](https://rt-bench.gitlab.io/rt-bench/index.html).

### TODO List

- <!-- @bug --> Segmentation fault in `rt-tacle-bench/bench/sequential/anagram/anagram`.
- <!-- @bug --> Segmentation fault in `rt-tacle-bench/bench/sequential/audiobeam/audiobeam`.
- <!-- @bug --> Segmentation fault in `rt-tacle-bench/bench/sequential/cjpeg_wrbmp/cjpeg_wrbmp`.
- <!-- @bug --> Segmentation fault in `rt-tacle-bench/bench/sequential/g723_enc/g723_enc`.

### Usage

This module is registered as a submodule of RT-Bench, from which it also depends.

#### Setup

The suggested way to compile benchmarks in this module requires the user to:

- Clone RT-Bench: `git clone https://gitlab.com/rt-bench/rt-bench.git`.
- Initialize the submodule by typing, from the RT-Bench root folder `make setup-tacle`

#### Compilation

Compilation is done from the `rt-tacle-bench` folder (the module root folder).

To compile the whole suite, you can simply type:

```{.sh}
make
```

Otherwise a single benchmark can be compiled by typing `make` followed by the path to the benchmark.
For example to compile only the `ammunition` benchmark
```{.sh}
make bench/sequential/ammunition/ammunition
```

By default, it will compile for `x86` platform with `gcc` and assumes RT-Bench is the parent folder.
Append these options to the `make` command to tailor compilation to your needs

- ```CC=<compiler>``` for cross-compiling
- ```RTBENCH_PATH=<path/to/rtbench/repository>``` to specify the location of the RT-bench project/repository used
- ```CORE=CORTEX_A53``` to enable performance counters features

### Citing projects

If you have found this project useful, please consider citing both RT-Bench and TACLe Bench.

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

TacleBench:
```
@INPROCEEDINGS{TACLeBench,
	author = {Heiko Falk and Sebastian Altmeyer and Peter Hellinckx and Bj{\"o}rn Lisper and Wolfgang Puffitsch and Christine Rochange and Martin Schoeberl and Rasmus Bo S{\o}rensen and Peter W{\"a}gemann and Simon Wegener},
	title = {{TACLeBench}: A Benchmark Collection to Support Worst-Case Execution Time Research},
	booktitle = {16th International Workshop on Worst-Case Execution Time Analysis (WCET 2016)},
	year = {2016},
	editor = {Martin Schoeberl},
	volume = {55},
	series = {OpenAccess Series in Informatics (OASIcs)},
	pages = {2:1--2:10},
	address = {Dagstuhl, Germany},
	publisher = {Schloss Dagstuhl--Leibniz-Zentrum f\"ur Informatik}
}
```

<!-- @author Denis Hoornaert, for the current file only.
@copyright This file is under the SPDX-License-Identifier: MIT
Individual benchmarks are subject to their original license, specified in each file. -->
