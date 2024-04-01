/**
 * @file countnegative.c
 * @defgroup countnegative Countnegative
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible countnegative benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/countnegative/countnegative.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: countnegative

  @author unknown

  Function: Counts negative and non-negative numbers in a
    matrix. Features nested loops, well-structured code.

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/cnt/cnt.c

  Changes: Changed split between initialization and computation

  @copyright May be used, modified, and re-distributed freely

*/

/*
  The dimension of the matrix
*/
#define MAXSIZE 20

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/*
  Type definition for the matrix
*/
typedef int matrix [ MAXSIZE ][ MAXSIZE ];

/*
  Forward declaration of functions
*/
void countnegative_initSeed( void );
int countnegative_randomInteger( void );
void countnegative_initialize( matrix );
void countnegative_sum( matrix );

/*
  Globals
*/
volatile int countnegative_seed;
matrix countnegative_array;
int countnegative_postotal, countnegative_negtotal;
int countnegative_poscnt, countnegative_negcnt;

/*
  Initializes the seed used in the random number generator.
*/
void countnegative_initSeed ( void )
{
  countnegative_seed = 0;
}

/*
  Generates random integers between 0 and 8094
*/
int countnegative_randomInteger( void )
{
  countnegative_seed = ( ( countnegative_seed * 133 ) + 81 ) % 8095;
  return  countnegative_seed;
}

/*
  Initializes the given array with random integers.
*/
void countnegative_initialize( matrix Array )
{
  register int OuterIndex, InnerIndex;

  _Pragma( "loopbound min 20 max 20" )
  for ( OuterIndex = 0; OuterIndex < MAXSIZE; OuterIndex++ )
    _Pragma( "loopbound min 20 max 20" )
    for ( InnerIndex = 0; InnerIndex < MAXSIZE; InnerIndex++ )
      Array[ OuterIndex ][ InnerIndex ] =  countnegative_randomInteger();
}

int benchmark_init(int parameters_num, void **parameters)
{
  countnegative_initSeed();
  countnegative_initialize( countnegative_array );
  return 0;
}

const char* benchmark_log_header()
{
  return "sucess(exp:1)";
}

float benchmark_log_data()
{
  int checksum = ( countnegative_postotal +
                   countnegative_poscnt +
                   countnegative_negtotal +
                   countnegative_negcnt );

  return ( ( checksum == ( int )0x1778de ) ? 1.0 : 0.0 );
}

void countnegative_sum( matrix Array )
{
  register int Outer, Inner;

  int Ptotal = 0; /* changed these to locals in order to drive worst case */
  int Ntotal = 0;
  int Pcnt = 0;
  int Ncnt = 0;

  _Pragma( "loopbound min 20 max 20" )
  for ( Outer = 0; Outer < MAXSIZE; Outer++ )
    _Pragma( "loopbound min 20 max 20" )
    for ( Inner = 0; Inner < MAXSIZE; Inner++ )
      if ( Array[ Outer ][ Inner ] >= 0 ) {
        Ptotal += Array[ Outer ][ Inner ];
        Pcnt++;
      } else {
        Ntotal += Array[ Outer ][ Inner ];
        Ncnt++;
      }

  countnegative_postotal = Ptotal;
  countnegative_poscnt = Pcnt;
  countnegative_negtotal = Ntotal;
  countnegative_negcnt = Ncnt;
}

/*
  The main function
*/
void benchmark_execution(int parameters_num, void **parameters)
{
  countnegative_sum(  countnegative_array );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
