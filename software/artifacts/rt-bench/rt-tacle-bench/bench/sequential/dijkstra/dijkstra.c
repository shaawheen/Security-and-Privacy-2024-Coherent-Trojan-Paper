/**
 * @file dijkstra.c
 * @defgroup dijkstra Dijkstra
 * @ingroup rt-tacle-bench
 * @brief RT-Bench compatible dijkstra benchmark from TACle Bench.
 * @details
 * The original script has been broken down in three components:
 * - init: benchmark_init();
 * - execution: benchmark_execution();
 * - teardown: benchmark_teardown();
 *
 * Code is courtesy of TACle Bench project (see https://github.com/tacle/tacle-bench)
 * This header was generated automatically, please consult the code at bench/sequential/dijkstra/dijkstra.c for the exact license(s).
 *

  This program is part of the TACLeBench benchmark suite.
  Version V 2.0

  Name: dijkstra

  @author unknown

  Function: dijkstra finds the shortest path between nodes in a graph

  Source: network section of MiBench

  Changes: Made some variables local, compute checksum

  @copyright GPL

*/

// Libraries used by rt-bench
#include "logging.h"
#include "periodic_benchmark.h"

#include "input.h"

/*
  Definitions of symbolic constants
*/
#define NONE 9999
#define OUT_OF_MEMORY -1
#define QUEUE_SIZE 1000

/*
  Type declarations
*/
struct _NODE {
  int dist;
  int prev;
};

struct _QITEM {
  int node;
  int dist;
  int prev;
  struct _QITEM *next;
};

/*
  Global variable definitions
*/
struct _NODE dijkstra_rgnNodes[ NUM_NODES ];

int dijkstra_queueCount;
int dijkstra_queueNext;
struct _QITEM *dijkstra_queueHead;
struct _QITEM dijkstra_queueItems[ QUEUE_SIZE ];

int dijkstra_checksum = 0;

/*
  Forward declaration of functions
*/
int dijkstra_enqueue( int node, int dist, int prev );
void dijkstra_dequeue( int *node, int *dist, int *prev );
int dijkstra_qcount( void );
int dijkstra_find( int chStart, int chEnd );

int benchmark_init(int parameters_num, void **parameters)
{
  int i, k;
  volatile int x = 0;
  _Pragma( "loopbound min 100 max 100" )
  for ( i = 0; i < NUM_NODES; i++ ) {
    _Pragma( "loopbound min 100 max 100" )
    for ( k = 0; k < NUM_NODES; k++ )
      dijkstra_AdjMatrix[ i ][ k ] ^= x;
  }

  dijkstra_queueCount = 0;
  dijkstra_queueNext = 0;
  dijkstra_queueHead = ( struct _QITEM * )0;

  dijkstra_checksum = 0;

  return 0;
}

int dijkstra_return( void )
{
  return ( ( dijkstra_checksum == 25 ) ? 0 : -1 );
}

int dijkstra_enqueue( int node, int dist, int prev )
{
  struct _QITEM *newItem = &dijkstra_queueItems[ dijkstra_queueNext ];
  struct _QITEM *last = dijkstra_queueHead;

  if ( ++dijkstra_queueNext >= QUEUE_SIZE )
    return OUT_OF_MEMORY;
  newItem->node = node;
  newItem->dist = dist;
  newItem->prev = prev;
  newItem->next = 0;

  if ( !last )
    dijkstra_queueHead = newItem;
  else {
    /* TODO: where does this magic loop bound come from? */
    _Pragma( "loopbound min 0 max 313" )
    while ( last->next )
      last = last->next;
    last->next = newItem;
  }
  dijkstra_queueCount++;
  return 0;
}

void dijkstra_dequeue( int *node, int *dist, int *prev )
{
  if ( dijkstra_queueHead ) {
    *node = dijkstra_queueHead->node;
    *dist = dijkstra_queueHead->dist;
    *prev = dijkstra_queueHead->prev;
    dijkstra_queueHead = dijkstra_queueHead->next;
    dijkstra_queueCount--;
  }
}

int dijkstra_qcount( void )
{
  return ( dijkstra_queueCount );
}

int dijkstra_find( int chStart, int chEnd )
{
  int ch;
  int prev, node = 0;
  int cost, dist = 0;
  int i;

  _Pragma( "loopbound min 100 max 100" )
  for ( ch = 0; ch < NUM_NODES; ch++ ) {
    dijkstra_rgnNodes[ ch ].dist = NONE;
    dijkstra_rgnNodes[ ch ].prev = NONE;
  }

  if ( chStart == chEnd ) {
  } else {
    dijkstra_rgnNodes[ chStart ].dist = 0;
    dijkstra_rgnNodes[ chStart ].prev = NONE;

    if ( dijkstra_enqueue ( chStart, 0, NONE ) == OUT_OF_MEMORY )
      return OUT_OF_MEMORY;

    /* TODO: where does this magic loop bound come from? */
    _Pragma( "loopbound min 618 max 928" )
    while ( dijkstra_qcount() > 0 ) {
      dijkstra_dequeue ( &node, &dist, &prev );
      _Pragma( "loopbound min 100 max 100" )
      for ( i = 0; i < NUM_NODES; i++ ) {
        if ( ( cost = dijkstra_AdjMatrix[ node ][ i ] ) != NONE ) {
          if ( ( NONE == dijkstra_rgnNodes[ i ].dist ) ||
               ( dijkstra_rgnNodes[ i ].dist > ( cost + dist ) ) ) {
            dijkstra_rgnNodes[ i ].dist = dist + cost;
            dijkstra_rgnNodes[ i ].prev = node;
            if ( dijkstra_enqueue ( i, dist + cost, node ) == OUT_OF_MEMORY )
              return OUT_OF_MEMORY;
          }
        }
      }
    }
  }
  return 0;
}

void benchmark_execution(int parameters_num, void **parameters)
{
  int i, j;

  /* finds 20 shortest paths between nodes */
  _Pragma( "loopbound min 20 max 20" )
  for ( i = 0, j = NUM_NODES / 2; i < 20; i++, j++ ) {
    j = j % NUM_NODES;
    if ( dijkstra_find( i, j ) == OUT_OF_MEMORY ) {
      dijkstra_checksum += OUT_OF_MEMORY;
      return;
    } else
      dijkstra_checksum += dijkstra_rgnNodes[ j ].dist;
    dijkstra_queueNext = 0;
  }
}

void benchmark_teardown(int parameters_num, void **parameters)
{}
