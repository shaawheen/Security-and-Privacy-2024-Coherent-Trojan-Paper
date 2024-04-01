/**
 * @file bsort.c
 * @defgroup bsort Bsort
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible bsort benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/bsort/bsort.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version 2.0

  Name: bsort

  @author unknown

  Function: A program for testing the basic loop constructs,
            integer comparisons, and simple array handling by
            sorting 100 integers

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/bsort100/bsort100.c

  Original name: bsort100

  Changes: See ChangeLog.txt

  @copyright May be used, modified, and re-distributed freely.

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/*
  Forward declaration of functions
*/

int bsort_Initialize( int Array[] );
int bsort_BubbleSort( int Array[] );


/*
  Declaration of global variables
*/

#define bsort_SIZE 100

static int bsort_Array[ bsort_SIZE ];


/*
  Initialization- and return-value-related functions
*/

/* Initializes given array with randomly generated integers. */
int bsort_Initialize( int Array[] )
{
  int Index;

  _Pragma( "loopbound min 100 max 100" )
  for ( Index = 0; Index < bsort_SIZE; Index ++ )
    Array[ Index ] = ( Index + 1 ) * -1;

  return 0;
}

int benchmark_init(int parameters_num, void **parameters)
{
  return bsort_Initialize( bsort_Array );
}

const char* benchmark_log_header()
{
  return "sorted(exp:1)";
}

float benchmark_log_data()
{
  int Sorted = 1;
  int Index;

  _Pragma( "loopbound min 99 max 99" )
  for ( Index = 0; Index < bsort_SIZE - 1; Index ++ )
    Sorted = Sorted && ( bsort_Array[ Index ] < bsort_Array[ Index + 1 ] );

  return Sorted;
}


/*
  Core benchmark functions
*/

/* Sorts an array of integers of size bsort_SIZE in ascending
   order with bubble sort. */
int bsort_BubbleSort( int Array[] )
{
  int Sorted = 0;
  int Temp, Index, i;

  _Pragma( "loopbound min 99 max 99" )
  for ( i = 0; i < bsort_SIZE - 1; i ++ ) {
    Sorted = 1;
    _Pragma( "loopbound min 3 max 99" )
    for ( Index = 0; Index < bsort_SIZE - 1; Index ++ ) {
      if ( Index > bsort_SIZE - i )
        break;
      if ( Array[ Index ] > Array[Index + 1] ) {
        Temp = Array[ Index ];
        Array[ Index ] = Array[ Index + 1 ];
        Array[ Index + 1 ] = Temp;
        Sorted = 0;
      }
    }

    if ( Sorted )
      break;
  }
  printf("%i, %i, %i, %i\n", Sorted, Temp, Index, i);

  return 0;
}

void benchmark_execution(int parameters_num, void **parameters)
{
  bsort_Initialize( bsort_Array );
  bsort_BubbleSort( bsort_Array );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
