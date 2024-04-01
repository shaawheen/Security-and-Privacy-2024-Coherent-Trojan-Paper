/**
 * @file fac.c
 * @defgroup fac Fac
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible fac benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/fac/fac.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 1.x

  Name: fac

  @author unknown

  Function: fac is a program to calculate factorials.
    This program computes the sum of the factorials
    from zero to five.

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/fac/fac.c

  Changes: CS 2006/05/19: Changed loop bound from constant to variable.

  @copyright public domain

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/*
  Forward declaration of functions
*/
int fac_fac( int n );

/*
  Declaration of global variables
*/

int fac_s;
volatile int fac_n;


/*
  Initialization- and return-value-related functions
*/

int benchmark_init(int parameters_num, void **parameters)
{
  fac_s = 0;
  fac_n = 5;
  return 0;
}

const char* benchmark_log_header()
{
  return "success(exp:1)";
}

float benchmark_log_data()
{
  int expected_result = 154;
  return (fac_s == expected_result);
}


/*
  Arithmetic math functions
*/


int fac_fac ( int n )
{
  if ( n == 0 )
    return 1;
  else
    return ( n * fac_fac ( n - 1 ) );
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  int i;
  benchmark_init(0, NULL);
  _Pragma( "loopbound min 6 max 6" )
  for ( i = 0;  i <= fac_n; i++ ) {
    _Pragma( "marker recursivecall" )
    fac_s += fac_fac ( i );
    _Pragma( "flowrestriction 1*fac_fac <= 6*recursivecall" )
  }
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
