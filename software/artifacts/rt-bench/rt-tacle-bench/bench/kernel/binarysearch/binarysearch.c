/**
 * @file binarysearch.c
 * @defgroup binarysearch Binarysearch
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible binarysearch benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/binarysearch/binarysearch.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: binarysearch

  @author Sung-Soo Lim <sslim@archi.snu.ac.kr>

  Function: binarysearch performs binary search in an array of 15 integer
    elements.
    This program is completely structured (no unconditional jumps, no exits
    from loop bodies), and does not contain switch statements, no do-while
    loops.

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/bs/bs.c

  Original name: bs

  Changes: No major functional changes.

  @copyright May be used, modified, and re-distributed freely, but
           the SNU-RT Benchmark Suite must be acknowledged

*/

/*
  This program is derived from the SNU-RT Benchmark Suite for Worst
  Case Timing Analysis by Sung-Soo Lim
*/


/*
  Forward declaration of functions
*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

void binarysearch_initSeed( void );
long binarysearch_randomInteger( void );
int binarysearch_binary_search( int );


/*
  Declaration of global variables
*/

volatile int binarysearch_seed;

struct binarysearch_DATA {
  long key;
  long value;
};

struct binarysearch_DATA binarysearch_data[ 15 ];

int binarysearch_result;


/*
  Initialization- and return-value-related functions
*/

/*
  binarysearch_initSeed initializes the seed used in the "random" number
  generator.
*/
void binarysearch_initSeed( void )
{
  binarysearch_seed = 0;
}


/*
  binarysearch_RandomInteger generates "random" integers between 0 and 8094.
*/
long binarysearch_randomInteger( void )
{
  binarysearch_seed = ( ( binarysearch_seed * 133 ) + 81 ) % 8095;
  return ( binarysearch_seed );
}


int benchmark_init(int parameters_num, void **parameters)
{
  int i;

  binarysearch_initSeed();

  _Pragma( "loopbound min 15 max 15" )
  for ( i = 0; i < 15; ++i ) {
    binarysearch_data[ i ].key = binarysearch_randomInteger();
    binarysearch_data[ i ].value = binarysearch_randomInteger();
    printf("%ld, %ld\n", binarysearch_data[ i ].key, binarysearch_data[ i ].value);
  }
  return 0;
}

const char* benchmark_log_header()
{
  return "result(exp:-1)";
}

float benchmark_log_data()
{
  return (float)( binarysearch_result );
}


/*
  Algorithm core functions
*/

int binarysearch_binary_search( int x )
{
  int fvalue, mid, up, low;

  low = 0;
  up = 14;
  fvalue = -1;

  _Pragma( "loopbound min 1 max 4" )
  while ( low <= up ) {
    mid = ( low + up ) >> 1;

    if ( binarysearch_data[ mid ].key == x ) {
      /* Item found */
      up = low - 1;
      fvalue = binarysearch_data[ mid ].value;
    } else

      if ( binarysearch_data[ mid ].key > x )
        /* Item not found */
        up = mid - 1;
      else
        low = mid + 1;
  }

  return ( fvalue );
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  binarysearch_result = binarysearch_binary_search( 8 );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
