/**
 * @file lift.c
 * @defgroup lift Lift
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible lift benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/app/lift/lift.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: lift

  @author Martin Schoeberl, Benedikt Huber

  Function: Lift Controler

  Source: C-Port from http://www.jopdesign.com/doc/jembench.pdf

  Original name: run_lift.c

  Changes: no major functional changes

  @copyright GPL version 3 or later

*/


/*
  Include section
*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#include "liftlibio.h"
#include "liftlibcontrol.h"


/*
  Forward declaration of functions
*/

void lift_controller();

/*
  Declaration of global variables
*/

int lift_checksum;/* Checksum */


/*
  Initialization- and return-value-related functions
*/

int benchmark_init(int parameters_num, void **parameters)
{
  unsigned int i;
  unsigned char *p;
  volatile char bitmask = 0;

  /*
    Apply volatile XOR-bitmask to entire input array.
  */
  p = ( unsigned char * ) &lift_ctrl_io_in[ 0 ];
  _Pragma( "loopbound min 40 max 40" )
  for ( i = 0; i < sizeof( lift_ctrl_io_in ); ++i, ++p )
    *p ^= bitmask;

  p = ( unsigned char * ) &lift_ctrl_io_out[ 0 ];
  _Pragma( "loopbound min 16 max 16" )
  for ( i = 0; i < sizeof( lift_ctrl_io_out ); ++i, ++p )
    *p ^= bitmask;

  p = ( unsigned char * ) &lift_ctrl_io_analog[ 0 ];
  _Pragma( "loopbound min 16 max 16" )
  for ( i = 0; i < sizeof( lift_ctrl_io_analog ); ++i, ++p )
    *p ^= bitmask;

  p = ( unsigned char * ) &lift_ctrl_io_led[ 0 ];
  _Pragma( "loopbound min 64 max 64" )
  for ( i = 0; i < sizeof( lift_ctrl_io_led ); ++i, ++p )
    *p ^= bitmask;

  lift_checksum = 0;
  lift_ctrl_init();

  return 0;
}


int lift_return()
{
  return ( lift_checksum - 4005888 != 0 );
}


/*
  Algorithm core functions
*/

void lift_controller()
{
  lift_ctrl_get_vals();
  lift_ctrl_loop();
  lift_ctrl_set_vals();
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  int i = 0;
  _Pragma( "loopbound min 1001 max 1001" )
  while ( 1 ) {
    /* zero input stimulus */
    lift_simio_in = 0;
    lift_simio_adc1 = 0;
    lift_simio_adc2 = 0;
    lift_simio_adc3 = 0;
    /* run lift_controller */
    lift_controller();
    if ( i++ >= 1000 )
      break;
  }
}


void benchmark_teardown(int parameters_num, void **parameters)
{}
