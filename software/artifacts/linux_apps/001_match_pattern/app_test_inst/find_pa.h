#ifndef FIND_PA_H
#define FIND_PA_H

#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

uint64_t getPhysicalAddress(void* virtual_address);

#endif