/**
 * @file deg2rad.c
 * @defgroup deg2rad Deg2rad
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible deg2rad benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/deg2rad/deg2rad.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 1.9

  Name: deg2rad

  @author unknown

  Function: deg2rad performs conversion of degree to radiant

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

#define deg2rad(d) ((d)*PI/180)

/*
  Declaration of global variables
*/

float deg2rad_X, deg2rad_Y;


/*
  Initialization function
*/

int benchmark_init(int parameters_num, void **parameters)
{
  deg2rad_X = 0;
  deg2rad_Y = 0;
  return 0;
}


/*
  Return function
*/

const char* benchmark_log_header()
{
  return "success(epx:1)";
}

float benchmark_log_data()
{
  int temp = deg2rad_Y;
  return ( temp == 1133 );
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  benchmark_init(0, NULL);
  /* convert some rads to degrees */
  _Pragma( "loopbound min 361 max 361" )
  for ( deg2rad_X = 0.0f; deg2rad_X <= 360.0f; deg2rad_X += 1.0f )
    deg2rad_Y += deg2rad( deg2rad_X );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
