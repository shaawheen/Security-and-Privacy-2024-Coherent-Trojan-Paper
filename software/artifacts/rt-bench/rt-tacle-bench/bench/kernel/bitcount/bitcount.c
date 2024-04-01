/**
 * @file bitcount.c
 * @defgroup bitcount Bitcount
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible bitcount benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/bitcount/bitcount.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 1.x

  Name: bitcount.c

  @author Bob Stout & Auke Reitsma

  Function: test program for bit counting functions

  Source: www.snippest.com

  Changes: no major functional changes

  @copyright May be used, modified, and re-distributed freely.

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#include "bitops.h"

#define FUNCS  8

/*
   Global variables
*/

unsigned long bitcount_randseed;
int bitcount_res;
unsigned long bitcount_seed;
unsigned long bitcount_n;
unsigned int bitcount_iterations;

/*
   First declaration of the functions
*/
int bitcount_bit_shifter( long int x );
unsigned long bitcount_random( void );

int bitcount_bit_shifter( long int x )
{
  int n;
  unsigned int i;

  _Pragma( "loopbound min 31 max 31" )
  for ( i = n = 0; x && ( i < ( sizeof( long ) * 8 ) ); ++i, x >>= 1 )
    n += ( int )( x & 1L );
  return n;
}

const char* benchmark_log_header()
{
  return "correct(exp:0)";
}

float benchmark_log_data()
{
  return ( bitcount_n + ( -1095 ) ) != 0;
}

int benchmark_init(int parameters_num, void **parameters)
{
  bitcount_randseed = 1;
  bitcount_n = 0;
  bitcount_iterations = 10;

  bitcount_init3();
  bitcount_init4();

  return 0;
}

unsigned long bitcount_random( void )
{
  long x, hi, lo, t;

  /*
     Compute x[n + 1] = (7^5 * x[n]) mod (2^31 - 1).
     From "Random number generators: good ones are hard to find",
     Park and Miller, Communications of the ACM, vol. 31, no. 10,
     October 1988, p. 1195.
  */
  x = bitcount_randseed;
  hi = x / 127773;
  lo = x % 127773;
  t = 16807 * lo - 2836 * hi;
  if ( t <= 0 )
    t += 0x7fffffff;
  bitcount_randseed = t;
  return ( t );
}

void benchmark_execution(int parameters_num, void **parameters)
{
  unsigned int i, j;
  bitcount_n = 0; // same as in init
  bitcount_randseed = 1; // same as in init
  _Pragma( "loopbound min 8 max 8" )
  for ( i = 0; i < FUNCS; i++ ) {
    _Pragma( "loopbound min 10 max 10" )
    for ( j = 0, bitcount_seed = bitcount_random(); j < bitcount_iterations;
          j++, bitcount_seed += 13 ) {
      // The original calls were done by function pointers
      switch ( i ) {
        case 0:
          bitcount_res = bitcount_bit_count( bitcount_seed );
          break;
        case 1:
          bitcount_res = bitcount_bitcount( bitcount_seed );
          break;
        case 2: {
            _Pragma( "marker call_ntbl" )
            bitcount_res = bitcount_ntbl_bitcnt( bitcount_seed );
            break;
          }
        case 3: {
            _Pragma( "marker call_btbl" )
            bitcount_res = bitcount_btbl_bitcnt( bitcount_seed );
            break;
          }
        case 4:
          bitcount_res = bitcount_ntbl_bitcount( bitcount_seed );
          break;
        case 5:
          bitcount_res = bitcount_BW_btbl_bitcount( bitcount_seed );
          break;
        case 6:
          bitcount_res = bitcount_AR_btbl_bitcount( bitcount_seed );
          break;
        case 7:
          bitcount_res = bitcount_bit_shifter( bitcount_seed );
          break;
        default:
          break;
      }
      bitcount_n += bitcount_res;
    }
  }
  _Pragma( "flowrestriction 1*ntbl_bitcount <= 8*call_ntbl" )
  _Pragma( "flowrestriction 1*btbl_bitcount <= 4*call_btbl" )
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
