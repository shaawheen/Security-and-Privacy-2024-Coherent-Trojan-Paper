/**
 * @file isqrt.c
 * @defgroup isqrt Isqrt
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible isqrt benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/isqrt/isqrt.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 1.9

  Name: isqrt

  @author unknown

  Function: isqrt calculates the integer square root of a number

  Source: MiBench
          http://wwweb.eecs.umich.edu/mibench

  Original name: basicmath_small

  Changes: no major functional changes

  @copyright this code is FREE with no restrictions

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#include "basicmath_libc.h"
#include "snipmath.h"

#define BITSPERLONG 32
#define TOP2BITS(x) ((x & (3L << (BITSPERLONG-2))) >> (BITSPERLONG-2))

/* usqrt:
    ENTRY x: unsigned long
    EXIT  returns floor(sqrt(x) * pow(2, BITSPERLONG/2))

    Since the square root never uses more than half the bits
    of the input, we use the other half of the bits to contain
    extra bits of precision after the binary point.

    EXAMPLE
        suppose BITSPERLONG = 32
        then    usqrt(144) = 786432 = 12 * 65536
                usqrt(32) = 370727 = 5.66 * 65536

    NOTES
        (1) change BITSPERLONG to BITSPERLONG/2 if you do not want
            the answer scaled.  Indeed, if you want n bits of
            precision after the binary point, use BITSPERLONG/2+n.
            The code assumes that BITSPERLONG is even.
        (2) This is really better off being written in assembly.
            The line marked below is really a "arithmetic shift left"
            on the double-long value with r in the upper half
            and x in the lower half.  This operation is typically
            expressible in only one or two assembly instructions.
        (3) Unrolling this loop is probably not a bad idea.

    ALGORITHM
        The calculations are the base-two analogue of the square
        root algorithm we all learned in grammar school.  Since we're
        in base 2, there is only one nontrivial trial multiplier.

        Notice that absolutely no multiplications or divisions are performed.
        This means it'll be fast on a wide range of processors.
*/


/*
  Forward declaration of functions
*/

void isqrt_usqrt( unsigned long x, struct int_sqrt *q );

/*
  Declaration of global variables
*/

int isqrt_i;
struct int_sqrt isqrt_q;
unsigned long isqrt_l;
unsigned long isqrt_checksum;


/*
  Initialization function
*/

int benchmark_init(int parameters_num, void **parameters)
{
  isqrt_l = 0x3fed0169L;
  isqrt_checksum = 0;

  return 0;
}


/*
  Return function
*/

const char* benchmark_log_header()
{
  return "success(exp:1)";
}

float benchmark_log_data()
{
  return ( isqrt_checksum == 53364 );
}


/*
  Main functions
*/

void isqrt_usqrt( unsigned long x, struct int_sqrt *q )
{
  unsigned long a = 0L;                   /* accumulator      */
  unsigned long r = 0L;                   /* remainder        */
  unsigned long e = 0L;                   /* trial product    */

  int i;

  _Pragma( "loopbound min 32 max 32" )
  for ( i = 0; i < BITSPERLONG; i++ ) { /* NOTE 1 */
    r = ( r << 2 ) + TOP2BITS( x );
    x <<= 2;                            /* NOTE 2 */
    a <<= 1;
    e = ( a << 1 ) + 1;
    if ( r >= e ) {
      r -= e;
      a++;
    }
  }
  basicmath_memcpy( q, &a, sizeof( *q ) );
}

void benchmark_execution(int parameters_num, void **parameters)
{
  benchmark_init(0, NULL);

  /* perform some integer square roots */
  _Pragma( "loopbound min 1000 max 1000" )
  for ( isqrt_i = 1; isqrt_i < 1001; isqrt_i += 1 ) {
    isqrt_usqrt( isqrt_i, &isqrt_q );
    isqrt_checksum += isqrt_q.frac;
    // remainder differs on some machines
  }
  isqrt_usqrt( isqrt_l, &isqrt_q );
  isqrt_checksum += isqrt_q.frac;
}


void benchmark_teardown(int parameters_num, void **parameters)
{}
