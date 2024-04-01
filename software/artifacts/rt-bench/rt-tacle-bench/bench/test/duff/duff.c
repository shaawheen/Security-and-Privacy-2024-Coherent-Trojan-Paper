/**
 @file duff.c
 * @defgroup duff Duff
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible duff benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/test/duff/duff.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: duff

  @author Jakob Engblom

  Function: Duff's device

  Source: MRTC
          http://www.mrtc.mdh.se/projects/wcet/wcet_bench/duff/duff.c

  Changes: no major functional changes

  @copyright may be used, modified, and re-distributed freely

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

/*
  Forward declaration of functions
*/

void duff_copy( char *to, char *from, int count );
void duff_initialize( char *arr, int length );

/*
  Declaration of global variables
*/

char duff_source[ 100 ];
char duff_target[ 100 ];


/*
  Initialization- and return-value-related functions
*/

int benchmark_init(int parameters_num, void **parameters)
{
  unsigned int i;
  unsigned char *p;
  volatile char bitmask = 0;

  duff_initialize( duff_source, 100 );

  /*
    Apply volatile XOR-bitmask to entire input array.
  */
  p = ( unsigned char * ) &duff_source[  0  ];
  _Pragma( "loopbound min 400 max 400" )
  for ( i = 0; i < sizeof( duff_source ); ++i, ++p )
    *p ^= bitmask;

  return 0;
}


int duff_return( void )
{
  return ( duff_target[ 28 ] - 72 != 0 );
}


/*
  Algorithm core functions
*/

void duff_initialize( char *arr, int length )
{
  int i;

  _Pragma( "loopbound min 100 max 100" )
  for ( i = 0; i < length; i++ )
    arr[ i ] = length - i;
}


void duff_copy( char *to, char *from, int count )
{
  int n = ( count + 7 ) / 8;

  _Pragma( "marker outside" )
  switch ( count % 8 ) {
    case 0:
      do {
        *to++ = *from++;
      case 7:
        *to++ = *from++;
      case 6:
        *to++ = *from++;
      case 5:
        *to++ = *from++;
      case 4:
        *to++ = *from++;
      case 3:
        *to++ = *from++;
      case 2:
        *to++ = *from++;
      case 1:
        _Pragma( "marker inside" )
        *to++ = *from++;


      } while ( --n > 0 );
  }
  _Pragma( "flowrestriction 1*inside <= 6*outside" )
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  duff_copy( duff_target, duff_source, 43 );
}


void benchmark_teardown(int parameters_num, void **parameters)
{}
