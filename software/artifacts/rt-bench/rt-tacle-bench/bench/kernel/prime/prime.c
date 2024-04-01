/**
 * @file prime.c
 * @defgroup prime Prime
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible prime benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/prime/prime.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: prime

  @author unknown

  Function: prime calculates whether numbers are prime.

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/prime/prime.c

  Changes: no major functional changes

  @copyright may be used, modified, and re-distributed freely

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/*
  Forward declaration of functions
*/

unsigned char prime_divides ( unsigned int n, unsigned int m );
unsigned char prime_even ( unsigned int n );
unsigned char prime_prime ( unsigned int n );
void prime_swap ( unsigned int *a, unsigned int *b );
unsigned int prime_randomInteger();
void prime_initSeed();

/*
  Declaration of global variables
*/

unsigned int prime_x;
unsigned int prime_y;
int prime_result;
volatile int prime_seed;


/*
  Initialization- and return-value-related functions
*/


void prime_initSeed()
{
  prime_seed = 0;
}


unsigned int prime_randomInteger()
{
  prime_seed = ( ( prime_seed * 133 ) + 81 ) % 8095;
  return ( prime_seed );
}

int benchmark_init(int parameters_num, void **parameters)
{
  prime_initSeed();

  prime_x = prime_randomInteger();
  prime_y = prime_randomInteger();

  return 0;
}


int prime_return ()
{
  return prime_result;
}


/*
  Algorithm core functions
*/

unsigned char prime_divides ( unsigned int n, unsigned int m )
{
  return ( m % n == 0 );
}


unsigned char prime_even ( unsigned int n )
{
  return ( prime_divides ( 2, n ) );
}


unsigned char prime_prime ( unsigned int n )
{
  unsigned int i;
  if ( prime_even ( n ) )
    return ( n == 2 );
  _Pragma( "loopbound min 0 max 16" )               
  for ( i = 3; i * i <= n; i += 2 ) {
    if ( prime_divides ( i, n ) ) /* ai: loop here min 0 max 357 end; */
      return 0;
  }
  return ( n > 1 );
}


void prime_swap ( unsigned int *a, unsigned int *b )
{
  unsigned int tmp = *a;
  *a = *b;
  *b = tmp;
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  prime_swap ( &prime_x, &prime_y );

  prime_result = !( !prime_prime( prime_x ) && !prime_prime( prime_y ) );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
