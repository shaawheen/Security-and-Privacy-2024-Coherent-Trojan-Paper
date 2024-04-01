/**
 * @file insertsort.c
 * @defgroup insertsort Insertsort
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible insertsort benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/insertsort/insertsort.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 1.x

  Name: insertsort

  @author Sung-Soo Lim

  Function: Insertion sort for 10 integer numbers.
     The integer array insertsort_a[  ] is initialized in main function.
     Input-data dependent nested loop with worst-case of
     (n^2)/2 iterations (triangular loop).

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/insertsort/insertsort.c

  Changes: a brief summary of major functional changes (not formatting)

  @copyright may be used, modified, and re-distributed freely, but
           the SNU-RT Benchmark Suite must be acknowledged

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/*
  This program is derived from the SNU-RT Benchmark Suite for Worst
  Case Timing Analysis by Sung-Soo Lim
*/


/*
  Forward declaration of functions
*/
void insertsort_initialize( unsigned int *array );
void insertsort_init( void );
int insertsort_return( void );
void insertsort_main( void );
int main( void );

/*
  Declaration of global variables
*/
unsigned int insertsort_a[ 11 ];
int insertsort_iters_i, insertsort_min_i, insertsort_max_i;
int insertsort_iters_a, insertsort_min_a, insertsort_max_a;

/*
  Initialization- and return-value-related functions
*/

void insertsort_initialize( unsigned int *array )
{

  register volatile int i;
  _Pragma( "loopbound min 11 max 11" )
  for ( i = 0; i < 11; i++ )
    insertsort_a[ i ] = array[ i ];

}

int benchmark_init(int parameters_num, void **parameters)
{
  unsigned int a[ 11 ] = {0, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2};

  insertsort_iters_i = 0;
  insertsort_min_i = 100000;
  insertsort_max_i = 0;
  insertsort_iters_a = 0;
  insertsort_min_a = 100000;
  insertsort_max_a = 0;

  insertsort_initialize( a );

  return 0;
}

const char* benchmark_log_header()
{
  return "success(exp:1)";
}

float benchmark_log_data()
{
  int i, returnValue = 0;

  _Pragma( "loopbound min 11 max 11" )
  for ( i = 0; i < 11; i++ )
    returnValue += insertsort_a[ i ];

  return ( returnValue == 65 );
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  benchmark_init(0, NULL);

  int  i, j, temp;
  i = 2;

  insertsort_iters_i = 0;

  _Pragma( "loopbound min 9 max 9" )
  while ( i <= 10 ) {

    insertsort_iters_i++;

    j = i;

    insertsort_iters_a = 0;

    _Pragma( "loopbound min 1 max 9" )
    while ( insertsort_a[ j ] < insertsort_a[ j - 1 ] ) {
      insertsort_iters_a++;

      temp = insertsort_a[ j ];
      insertsort_a[ j ] = insertsort_a[ j - 1 ];
      insertsort_a[ j - 1 ] = temp;
      j--;
    }

    if ( insertsort_iters_a < insertsort_min_a )
      insertsort_min_a = insertsort_iters_a;
    if ( insertsort_iters_a > insertsort_max_a )
      insertsort_max_a = insertsort_iters_a;

    i++;
  }

  if ( insertsort_iters_i < insertsort_min_i )
    insertsort_min_i = insertsort_iters_i;
  if ( insertsort_iters_i > insertsort_max_i )
    insertsort_max_i = insertsort_iters_i;
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
