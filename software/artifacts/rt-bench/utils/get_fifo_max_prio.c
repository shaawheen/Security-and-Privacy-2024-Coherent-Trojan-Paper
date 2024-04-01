/** @file get_fifo_max_prio.c
@brief a simple C file that gives as output the max supported priority for the FIFO scheduler.
*/
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
int main(void)
{
	int max_prio = sched_get_priority_max(SCHED_FIFO);
	printf("%d\n", max_prio);
	return ((max_prio == -1) ? EXIT_FAILURE : EXIT_SUCCESS);
}
