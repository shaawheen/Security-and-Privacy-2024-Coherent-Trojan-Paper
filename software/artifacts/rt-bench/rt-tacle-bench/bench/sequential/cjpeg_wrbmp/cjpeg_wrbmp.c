/**
 * @file cjpeg_wrbmp.c
 * @defgroup cjpeg_wrbmp Cjpeg_wrbmp
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible cjpeg_wrbmp benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/sequential/cjpeg_wrbmp/cjpeg_wrbmp.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 1.x

  Name: cjpeg_jpeg6b_wrbmp.c

  @author Thomas G. Lane.

  Function: This file contains routines to write output images in Microsoft "BMP"
  format (MS Windows 3.x and OS/2 1.x flavors).
  Either 8-bit colormapped or 24-bit full-color format can be written.
  No compression is supported.

  These routines may need modification for non-Unix environments or
  specialized applications.  As they stand, they assume output to
  an ordinary stdio stream.

  Source: Independent JPEG Group's software

  Changes: a brief summary of major functional changes (not formatting)

  @copyright  See the accompanying README file

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#include "cdjpeg.h"

#ifdef CJPEG_WRBMP_BMP_SUPPORTED

/*
  Declaration of global variables
*/
typedef struct {
  struct cjpeg_wrbmp_djpeg_dest_struct pub; /* public fields */
  cjpeg_wrbmp_boolean is_os2;   /* saves the OS2 format request flag */
  cjpeg_wrbmp_jvirt_sarray_ptr
  whole_image; /* needed to reverse row order */
  CJPEG_WRBMP_JDIMENSION data_width;  /* JSAMPLEs per row */
  CJPEG_WRBMP_JDIMENSION
  row_width;   /* physical width of one row in the BMP file */
  int pad_bytes;    /* number of padding bytes needed per row */
  CJPEG_WRBMP_JDIMENSION
  cur_output_row;  /* next row# to write to virtual array */
} cjpeg_wrbmp_bmp_dest_struct;

typedef cjpeg_wrbmp_bmp_dest_struct *cjpeg_wrbmp_bmp_dest_ptr;
extern unsigned char cjpeg_wrbmp_colormap[ 3 ][ 256 ];
unsigned char cjpeg_wrbmp_output_array[ 6144 ];
unsigned char *cjpeg_wrbmp_jpeg_stream /*= cjpeg_jpeg6b_wrbmp_output_array*/;
int cjpeg_wrbmp_checksum;

struct cjpeg_wrbmp_jpeg_decompress_struct
  cjpeg_wrbmp_jpeg_dec_1;
struct cjpeg_wrbmp_jpeg_decompress_struct
  cjpeg_wrbmp_jpeg_dec_2;
struct cjpeg_wrbmp_djpeg_dest_struct
  cjpeg_wrbmp_djpeg_dest;
cjpeg_wrbmp_bmp_dest_struct    cjpeg_wrbmp_bmp_dest;

/*
  Forward declaration of functions
*/
void cjpeg_wrbmp_initInput( void );
void cjpeg_wrbmp_finish_output_bmp( cjpeg_wrbmp_j_decompress_ptr cinfo );
void cjpeg_wrbmp_write_colormap( cjpeg_wrbmp_j_decompress_ptr
                                 cinfo,
                                 int map_colors, int map_entry_size,
                                 int cMap );
int cjpeg_wrbmp_putc_modified( int character );

/*
   Initialization functions
*/
int benchmark_init(int parameters_num, void **parameters)
{
  cjpeg_wrbmp_initInput();

  cjpeg_wrbmp_jpeg_dec_1.progress                = 0;
  cjpeg_wrbmp_jpeg_dec_1.output_height           = 30;
  cjpeg_wrbmp_jpeg_dec_1.actual_number_of_colors = 256;
  cjpeg_wrbmp_jpeg_dec_1.out_color_components    = 2;

  cjpeg_wrbmp_jpeg_dec_2.progress                = 0;
  cjpeg_wrbmp_jpeg_dec_2.output_height           = 30;
  cjpeg_wrbmp_jpeg_dec_2.actual_number_of_colors = 256;
  cjpeg_wrbmp_jpeg_dec_2.out_color_components    = 3;

  cjpeg_wrbmp_jpeg_stream = cjpeg_wrbmp_output_array;

  cjpeg_wrbmp_checksum = 0;

  return 0;
}

/*
   Calculation functions
*/
int cjpeg_wrbmp_putc_modified( int character )
{
  *( cjpeg_wrbmp_jpeg_stream ) = character;

  ++cjpeg_wrbmp_jpeg_stream;

  cjpeg_wrbmp_checksum += character;

  return character;
}

void cjpeg_wrbmp_finish_output_bmp( cjpeg_wrbmp_j_decompress_ptr cinfo )
{
  CJPEG_WRBMP_JDIMENSION row;
  cjpeg_wrbmp_cd_progress_ptr progress =
    ( cjpeg_wrbmp_cd_progress_ptr ) cinfo->progress;

  // Write the file body from our virtual array
  _Pragma( "loopbound min 30 max 30" )
  for ( row = cinfo->output_height; row > 0; --row ) {
    if ( progress != 0 ) {
      progress->pub.pass_counter = ( long )( cinfo->output_height - row );
      progress->pub.pass_limit = ( long ) cinfo->output_height;
    }
  }

  if ( progress != 0 )
    progress->completed_extra_passes++;
}

void cjpeg_wrbmp_write_colormap( cjpeg_wrbmp_j_decompress_ptr
                                 cinfo,
                                 int map_colors, int map_entry_size, int cMap )
{

  int num_colors = cinfo->actual_number_of_colors;
  int i;

  if ( cMap != 0 ) {

    if ( cinfo->out_color_components == 3 ) {
      // Normal case with RGB colormap
      _Pragma( "loopbound min 256 max 256" )
      for ( i = 0; i < num_colors; i++ ) {
        cjpeg_wrbmp_putc_modified( CJPEG_WRBMP_GETJSAMPLE(
                                     cjpeg_wrbmp_colormap[ 2 ][ i ] ) );
        cjpeg_wrbmp_putc_modified( CJPEG_WRBMP_GETJSAMPLE(
                                     cjpeg_wrbmp_colormap[ 1 ][ i ] ) );
        cjpeg_wrbmp_putc_modified( CJPEG_WRBMP_GETJSAMPLE(
                                     cjpeg_wrbmp_colormap[ 0 ][ i ] ) );

        if ( map_entry_size == 4 )
          cjpeg_wrbmp_putc_modified( 0 );
      }
    } else {
      // Grayscale colormap (only happens with grayscale quantization)
      _Pragma( "loopbound min 256 max 256" )
      for ( i = 0; i < num_colors; i++ ) {

        cjpeg_wrbmp_putc_modified( CJPEG_WRBMP_GETJSAMPLE(
                                     cjpeg_wrbmp_colormap[ 2 ][ i ] ) );
        cjpeg_wrbmp_putc_modified( CJPEG_WRBMP_GETJSAMPLE(
                                     cjpeg_wrbmp_colormap[ 1 ][ i ] ) );
        cjpeg_wrbmp_putc_modified( CJPEG_WRBMP_GETJSAMPLE(
                                     cjpeg_wrbmp_colormap[ 0 ][ i ] ) );

        if ( map_entry_size == 4 )
          cjpeg_wrbmp_putc_modified( 0 );
      }
    }
  } else {
    // If no colormap, must be grayscale data.  Generate a linear "map".
    _Pragma( "loopbound min 256 max 256" )
    for ( i = 0; i < 256; i++ ) {
      cjpeg_wrbmp_putc_modified( i );
      cjpeg_wrbmp_putc_modified( i );
      cjpeg_wrbmp_putc_modified( i );

      if ( map_entry_size == 4 )
        cjpeg_wrbmp_putc_modified( 0 );
    }
  }

  // Pad colormap with zeros to ensure specified number of colormap entries.
  _Pragma( "loopbound min 512 max 512" )
  for ( ; i < map_colors; i++ ) {
    cjpeg_wrbmp_putc_modified( 0 );
    cjpeg_wrbmp_putc_modified( 0 );
    cjpeg_wrbmp_putc_modified( 0 );

    if ( map_entry_size == 4 )
      cjpeg_wrbmp_putc_modified( 0 );
  }
}

void benchmark_execution(int parameters_num, void **parameters)
{
  cjpeg_wrbmp_finish_output_bmp( &cjpeg_wrbmp_jpeg_dec_1 );
  cjpeg_wrbmp_write_colormap(    &cjpeg_wrbmp_jpeg_dec_1, 768, 4, 1 );

  cjpeg_wrbmp_finish_output_bmp( &cjpeg_wrbmp_jpeg_dec_2 );
  cjpeg_wrbmp_write_colormap(    &cjpeg_wrbmp_jpeg_dec_2, 768, 4, 1 );
}

int cjpeg_wrbmp_return()
{
  return ( cjpeg_wrbmp_checksum  + ( -209330 ) ) != 0;
}

void benchmark_teardown(int parameters_num, void **parameters)
{}

#endif /* BMP_SUPPORTED */
