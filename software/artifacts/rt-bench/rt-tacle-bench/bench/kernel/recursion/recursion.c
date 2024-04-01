/**
 * @file recursion.c
 * @defgroup recursion Recursion
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible recursion benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/recursion/recursion.c for the exact license(s).
 *
  This program is part of the TACLeBench benchmark suite.
  Version V 1.x

  Name: recursion

  @author unknown

  Function: recursion is a recursion program.
    This program computes the Fibonacci number recursively.

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/recursion/recursion.c

  Changes: no major functional changes

  @copyright May be used, modified, and re-distributed freely.

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/*
   Global Variables
*/
int recursion_result;
int recursion_input;

/*
  Forward declaration of functions
*/
int recursion_fib( int i );

int benchmark_init(int parameters_num, void **parameters)
{
  int volatile temp_input = 10;
  recursion_input = temp_input;

  return 0;
}


int recursion_fib( int i )
{
  if ( i == 0 )
    return 1;
  if ( i == 1 )
    return 1;

  return recursion_fib( i - 1 ) + recursion_fib( i - 2 );
}

int recursion_return()
{
  return ( recursion_result  + ( -89 ) ) != 0;
}

void benchmark_execution(int parameters_num, void **parameters)
{
  _Pragma( "marker recursivecall" )
  _Pragma( "flowrestriction 1*fib <= 177*recursivecall" )
  recursion_result = recursion_fib( recursion_input );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
