/**
 * @file complex_updates.c
 * @defgroup complex_updates Complex_updates
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible complex_updates benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/kernel/complex_updates/complex_updates.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: complex_updates

  @author Juan Martinez Velarde

  Function: complex_updates is a program for filter benchmarking.
    This program performs n complex updates of the form
              D(i) = C(i) + A(i)*B(i),
    where A(i), B(i), C(i) and D(i) are complex numbers,
    and i = 1,...,N
             A(i) = Ar(i) + j Ai(i)
             B(i) = Br(i) + j Bi(i)
             C(i) = Cr(i) + j Ci(i)
             D(i) = C(i) + A(i)*B(i) =   Dr(i)  +  j Di(i)
                         =>  Dr(i) = Cr(i) + Ar(i)*Br(i) - Ai(i)*Bi(i)
                         =>  Di(i) = Ci(i) + Ar(i)*Bi(i) + Ai(i)*Br(i)

  Source: DSP-Stone
    http://www.ice.rwth-aachen.de/research/tools-projects/entry/detail/dspstone/

  Original name: n_complex_updates_float

  Changes: no major functional changes

  @copyright may be used, modified, and re-distributed freely

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#define N 16


/*
  Forward declaration of functions
*/

void complex_updates_pin_down( float *pa, float *pb, float *pc, float *pd );

/*
  Declaration of global variables
*/

float complex_updates_A[ 2 * N ], complex_updates_B[ 2 * N ],
      complex_updates_C[ 2 * N ], complex_updates_D[ 2 * N ];


/*
  Initialization- and return-value-related functions
*/

int benchmark_init(int parameters_num, void **parameters)
{
  int i;
  volatile float x = 0;

  complex_updates_pin_down( &complex_updates_A[ 0 ], &complex_updates_B[ 0 ],
                            &complex_updates_C[ 0 ], &complex_updates_D[ 0 ] );

  /* avoid constant propagation */
  _Pragma( "loopbound min 16 max 16" )
  for ( i = 0 ; i < N ; i++ ) {
    complex_updates_A[ i ] += x;
    complex_updates_B[ i ] += x;
    complex_updates_C[ i ] += x;
    complex_updates_D[ i ] += x;
  }

  return 0;
}


void complex_updates_pin_down( float *pa, float *pb, float *pc, float *pd )
{
  register int i;

  _Pragma( "loopbound min 16 max 16" )
  for ( i = 0; i < N; i++ ) {
    *pa++ = 2;
    *pa++ = 1;
    *pb++ = 2;
    *pb++ = 5;
    *pc++ = 3;
    *pc++ = 4;
    *pd++ = 0;
    *pd++ = 0;
  }
}

const char* benchmark_log_header()
{
  return "success(exp:1)";
}

float benchmark_log_data()
{
  float check_sum = 0;
  int i;

  _Pragma( "loopbound min 16 max 16" )
  for ( i = 0; i < N; i++ )
    check_sum += complex_updates_D[ i ];

  return ( check_sum == 144.0f );
}


/*
  Main functions
*/

void benchmark_execution(int parameters_num, void **parameters)
{
  register float *p_a = &complex_updates_A[ 0 ], *p_b = &complex_updates_B[ 0 ];
  register float *p_c = &complex_updates_C[ 0 ], *p_d = &complex_updates_D[ 0 ];
  int i;

  _Pragma( "loopbound min 16 max 16" )
  for ( i = 0 ; i < N ; i++, p_a++ ) {
    *p_d    = *p_c++ + *p_a++ * *p_b++ ;
    *p_d++ -=          *p_a   * *p_b-- ;

    *p_d    = *p_c++ + *p_a-- * *p_b++ ;
    *p_d++ +=          *p_a++ * *p_b++ ;
  }

}

void benchmark_teardown(int parameters_num, void **parameters)
{}
