#ifndef AMMUNITION_STRING_H
#define AMMUNITION_STRING_H

/*
  Forward declaration of functions
*/

#include <stddef.h>

void *ammunition_memcpy( void *, const void *, size_t );
void *ammunition_memset( void *, int, size_t );
int ammunition_memcmp ( const void *mem1, const void *mem2, size_t size );
void *ammunition_memmove ( void *s1, const void *s2, size_t n );
int ammunition_strcmp ( const char *str1, const char *str2 );

#endif /* AMMUNITION_STRING_H */

