/**
 * @file rad2deg.c
 * @defgroup rad2deg Rad2deg
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible rad2deg benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/rad2deg/rad2deg.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 1.9

  Name: rad2deg

  @author unknown

  Function: rad2deg performs conversion of radiant to degree

  Source: MiBench
          http://wwweb.eecs.umich.edu/mibench

  Original name: basicmath_small

  Changes: no major functional changes

  @copyright this code is FREE with no restrictions

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#include "pi.h"

#define rad2deg(r) ((r)*180/PI)

/*
  Declaration of global variables
*/

float rad2deg_X, rad2deg_Y;


/*
  Initialization function
*/

int benchmark_init(int parameters_num, void **parameters)
{
  rad2deg_X = 0;
  rad2deg_Y = 0;

  return 0;
}


/*
  Return function
*/

int rad2deg_return( void )
{
  int temp = rad2deg_Y;

  if ( temp == 64620 )
    return 0;
  else
    return -1;
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  _Pragma( "loopbound min 360 max 360" )
  for ( rad2deg_X = 0.0f; rad2deg_X <= ( 2 * PI + 1e-6f ); rad2deg_X += ( PI / 180 ) )
    rad2deg_Y += rad2deg( rad2deg_X );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
