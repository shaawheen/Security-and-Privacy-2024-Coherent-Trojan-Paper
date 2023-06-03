include ../generator/rtbench.mk

PGMS=bandwidth latency

all: $(PGMS)

latency: rtbench
	$(CC) $(CFLAGS) latency.c $(BASE_O) -o latency $(LDFLAGS)

bandwidth: rtbench
	$(CC) $(CFLAGS) bandwidth.c $(BASE_O) -o bandwidth $(LDFLAGS)

clean:
	rm -f *.o $(PGMS) $(BASE_O)
