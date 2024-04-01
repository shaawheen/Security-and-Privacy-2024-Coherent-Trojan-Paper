RTBENCH_PATH=..
include $(RTBENCH_PATH)/generator/rtbench.mk

PGMS=grayscale threshold sepia sobel sobel5 gaussian_noise3 gaussian_noise5 gaussian_noise7 canny

all: $(PGMS)

image-inputs:
	bash inputs/init.sh

obj/common.o:
	$(CC) -c src/common.c -o obj/common.o

obj/filters.o:
	$(CC) -c src/filters.c -o obj/filters.o

grayscale: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/grayscale.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

threshold: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/threshold.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

sepia: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/sepia.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

sobel: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/sobel.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

sobel5: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/sobel5.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

gaussian_noise3: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/gaussian_noise3.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

gaussian_noise5: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/gaussian_noise5.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

gaussian_noise7: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/gaussian_noise7.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

canny: rtbench obj/common.o obj/filters.o image-inputs
	$(CC) $(CFLAGS) src/canny.c obj/*.o $(BASE_O) -o $@ $(LDFLAGS)

clean:
	rm -f obj/*.o src/*.o $(BASE_O) inputs/*.bmp $(PGMS)
