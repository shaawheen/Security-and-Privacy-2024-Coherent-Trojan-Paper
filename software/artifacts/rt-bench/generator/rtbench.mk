# If no target compiler specified, compiled with default gcc
CC ?= gcc

# Paths
CUR_DIR=$(dir $(lastword $(MAKEFILE_LIST)))
OBJECT=$(CUR_DIR)/object/$(notdir $(CC))
INCLUDE=$(CUR_DIR)/include
SOURCE=$(CUR_DIR)/src

# Lists of all object files
BASE_O=$(OBJECT)/*.o

# Basic compilation flags for rt-bench
override CFLAGS+=-O2 -Wall -g -I$(INCLUDE) -DGCC
CXXFLAGS=$(CFLAGS)
# Add linker's flags
override LDFLAGS+=-lrt -lm -pthread -Wl,--wrap=malloc -Wl,--wrap=mmap -Wl,--no-as-needed

# Check for specified core architecture family. When specified, set the required flags.
ifdef CORE
ifeq ($(CORE),CORTEX_A53)
override CFLAGS +=-DAARCH64 -DCORTEX_A53
endif
ifeq ($(CORE),CORE_I7)
override CFLAGS +=-DX86_64 -DCORE_I7
endif
endif

# Check if json configuration input is desired.
ifeq ($(JSON),1)
override CFLAGS+=-DJSON_SUPPORT
override LDFLAGS+=-ljson-c
endif

# Check if extended report is desired
ifeq ($(EXTENDED_REPORT),1)
override CFLAGS+=-DEXTENDED_REPORT
endif

# RT-Bench core recipes

.PHONY: default rtbench
## Add this recipe such that 'all' recipe in children makefile become the defualt one
default: all
## Base recipe to build with the whole RT-Bench core! 
rtbench: init main periodic_benchmark performance_sampler performance_counters memory_watcher logging get_cpu_timestamp

init:
	mkdir -p $(OBJECT)

get_cpu_timestamp: init $(INCLUDE)/get_cpu_timestamp.h
	$(CC) $(CFLAGS) -c $(SOURCE)/get_cpu_timestamp.c -o $(OBJECT)/get_cpu_timestamp.o $(LDFLAGS)

logging: init $(INCLUDE)/logging.h
	$(CC) $(CFLAGS) -c $(SOURCE)/logging.c -o $(OBJECT)/logging.o $(LDFLAGS)

memory_watcher: init $(INCLUDE)/memory_watcher.h
	$(CC) $(CFLAGS) -c $(SOURCE)/memory_watcher.c -o $(OBJECT)/memory_watcher.o $(LDFLAGS)

performance_counters: init $(INCLUDE)/performance_counters.h
	$(CC) $(CFLAGS) -c $(SOURCE)/performance_counters.c -o $(OBJECT)/performance_counters.o $(LDFLAGS)

performance_sampler: init $(INCLUDE)/performance_sampler.h
	$(CC) $(CFLAGS) -c $(SOURCE)/performance_sampler.c -o $(OBJECT)/performance_sampelr.o $(LDFLAGS)

periodic_benchmark: init $(INCLUDE)/periodic_benchmark.h
	$(CC) $(CFLAGS) -c $(SOURCE)/periodic_benchmark.c -o $(OBJECT)/periodic_benchmark.o $(LDFLAGS)

main: init $(SOURCE)/main.c
	$(CC) $(CFLAGS) -c $(SOURCE)/main.c -o $(OBJECT)/main.o $(LDFLAGS)

