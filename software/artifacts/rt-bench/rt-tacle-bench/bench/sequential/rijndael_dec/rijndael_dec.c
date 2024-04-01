/**
 * @file rijndael_dec.c
 * @defgroup rijndael_dec Rijndael_dec
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible rijndael_dec benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/sequential/rijndael_dec/rijndael_dec.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: rijndael_enc

  @author Dr Brian Gladman

  Function: rijndael_dec is an implementation of the AES decryption
            algorithm (Rijndael).

  Source: security section of MiBench

  Changes: Add computation of a checksum, refactoring

  @copyright see below

*/

/*
  -----------------------------------------------------------------------
  Copyright (c) 2001 Dr Brian Gladman <brg@gladman.uk.net>, Worcester, UK

  TERMS

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:
  1. Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.

  This software is provided 'as is' with no guarantees of correctness or
  fitness for purpose.
  -----------------------------------------------------------------------
*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#include "aes.h"
#include "rijndael_dec_libc.h"

/*
  Global variable definitions
*/
unsigned char rijndael_dec_key[ 32 ];
int rijndael_dec_key_len;

extern unsigned char rijndael_dec_data[  ];
struct rijndael_dec_FILE rijndael_dec_fin;

int rijndael_dec_checksum = 0;

/*
  Forward declaration of functions
*/
void rijndael_dec_fillrand( unsigned char *buf, int len );
void rijndael_dec_decfile( struct rijndael_dec_FILE *fin, struct aes *ctx );

int benchmark_init(int parameters_num, void **parameters)
{
  /* create a pseudo-file for the input*/
  rijndael_dec_fin.data = rijndael_dec_data;
  rijndael_dec_fin.size = 32768;
  rijndael_dec_fin.cur_pos = 0;

  unsigned i;
  volatile int x = 0;
  rijndael_dec_fin.size ^= x;
  _Pragma( "loopbound min 32768 max 32768" )
  for ( i = 0; i < rijndael_dec_fin.size; i++ )
    rijndael_dec_fin.data[ i ] ^= x;

  /* this is a pointer to the hexadecimal key digits  */
  const volatile char *cp =
    "1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321";
  char ch;
  int by = 0;

  i = 0;                  /* this is a count for the input digits processed */
  _Pragma( "loopbound min 64 max 64" )
  while ( i < 64 && *cp ) { /* the maximum key length is 32 bytes and       */
    /* hence at most 64 hexadecimal digits            */
    ch = rijndael_dec_toupper( *cp++ );     /* process a hexadecimal digit  */
    if ( ch >= '0' && ch <= '9' )
      by = ( by << 4 ) + ch - '0';
    else
      if ( ch >= 'A' && ch <= 'F' )
        by = ( by << 4 ) + ch - 'A' + 10;
      else {                                /* error if not hexadecimal     */
        rijndael_dec_checksum = -2;
        return;
      }

    /* store a key byte for each pair of hexadecimal digits         */
    if ( i++ & 1 )
      rijndael_dec_key[ i / 2 - 1 ] = by & 0xff;
  }

  if ( *cp ) {
    rijndael_dec_checksum = -3;
    return;
  } else
    if ( i < 32 || ( i & 15 ) ) {
      rijndael_dec_checksum = -4;
      return;
    }

  rijndael_dec_key_len = i / 2;

  return 0;
}

int rijndael_dec_return( void )
{
  return ( ( rijndael_dec_checksum == ( int )262180 ) ? 0 : -1 );
}

void rijndael_dec_decfile( struct rijndael_dec_FILE *fin, struct aes *ctx )
{
  unsigned char inbuf1[ 16 ], inbuf2[ 16 ], outbuf[ 16 ], *bp1, *bp2, *tp;
  int           i;


  rijndael_dec_fread( inbuf1, 1, 16, fin );

  i = rijndael_dec_fread( inbuf2, 1, 16,
                          fin ); /* read 1st encrypted file block    */

  if ( i && i != 16 ) {
    rijndael_dec_checksum = -10;
    return;
  }

  rijndael_dec_decrypt( inbuf2, outbuf,
                        ctx ); /* decrypt it                       */

  rijndael_dec_checksum += outbuf[ 15 ];

  _Pragma( "loopbound min 16 max 16" )
  for ( i = 0; i < 16; ++i )      /* xor with previous input          */
    outbuf[ i ] ^= inbuf1[ i ];

  bp1 = inbuf1;           /* set up pointers to two input buffers     */
  bp2 = inbuf2;

  /* TODO: this is necessarily an input-dependent loop bound */
  _Pragma( "loopbound min 2046 max 2046" )
  while ( 1 ) {
    i = rijndael_dec_fread( bp1, 1, 16, fin );   /* read next encrypted block    */
    /* to first input buffer        */
    if ( i != 16 )      /* no more bytes in input - the decrypted   */
      break;          /* partial final buffer needs to be output  */

    /* if a block has been read the previous block must have been   */
    /* full lnegth so we can now write it out                       */

    rijndael_dec_decrypt( bp1, outbuf, ctx ); /* decrypt the new input block and  */

    rijndael_dec_checksum += outbuf[ 15 ];

    _Pragma( "loopbound min 16 max 16" )
    for ( i = 0; i < 16; ++i )  /* xor it with previous input block */
      outbuf[ i ] ^= bp2[ i ];

    /* swap buffer pointers                */
    tp = bp1, bp1 = bp2, bp2 = tp;
  }
}

void benchmark_execution(int parameters_num, void **parameters)
{
  struct aes ctx[ 1 ];

  /* decryption in Cipher Block Chaining mode */
  rijndael_dec_set_key( rijndael_dec_key, rijndael_dec_key_len, dec, ctx );
  rijndael_dec_decfile( &rijndael_dec_fin, ctx );
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
