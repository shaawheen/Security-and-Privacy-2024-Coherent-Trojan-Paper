RTBENCH_PATH=..
include ${RTBENCH_PATH}/generator/rtbench.mk

BINARIES=./binaries/

PGMS=minver binarysearch bitcount bitonic bsort complex_updates cosf countnegative cubic deg2rad fac fft filterbank fir2dim iir insertsort isqrt jfdctint lms ludcmp matrix1 md5 pm prime quicksort rad2deg recursion sha st adpcm_dec adpcm_enc ammunition anagram audiobeam cjpeg_transupp cjpeg_wrbmp dijkstra epic fmref g723_enc gsm_dec gsm_enc h264_dec huff_dec huff_enc mpeg2 ndes petrinet rijndael_dec rijndael_enc statemate susan lift powerwindow cover duff test3


all: $(PGMS)

minver: rtbench
	$(CC) $(CFLAGS) $(LDFLAGS) bench/kernel/minver/minver.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

binarysearch: rtbench
	$(CC) $(CFLAGS) bench/kernel/binarysearch/binarysearch.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

bitcount: rtbench
	$(CC) $(CFLAGS) bench/kernel/bitcount/bitcount.c $(BASE_O) bench/kernel/bitcount/bitcnt_*.c -o $(BINARIES)/$@ $(LDFLAGS)

bitonic: rtbench
	$(CC) $(CFLAGS) bench/kernel/bitonic/bitonic.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

bsort: rtbench
	$(CC) $(CFLAGS) bench/kernel/bsort/bsort.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

complex_updates: rtbench
	$(CC) $(CFLAGS) bench/kernel/complex_updates/complex_updates.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

cosf: rtbench
	$(CC) $(CFLAGS) bench/kernel/cosf/cosf.c $(BASE_O) bench/kernel/cosf/wcclibm.c -o $(BINARIES)/$@ $(LDFLAGS)

countnegative: rtbench
	$(CC) $(CFLAGS) bench/kernel/countnegative/countnegative.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

cubic: rtbench
	$(CC) $(CFLAGS) bench/kernel/cubic/cubic.c $(BASE_O) bench/kernel/cubic/wcclibm.c -o $(BINARIES)/$@ $(LDFLAGS)

deg2rad: rtbench
	$(CC) $(CFLAGS) bench/kernel/deg2rad/deg2rad.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

fac: rtbench
	$(CC) $(CFLAGS) bench/kernel/fac/fac.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

fft: rtbench
	$(CC) $(CFLAGS) bench/kernel/fft/fft.c $(BASE_O) bench/kernel/fft/fft_input.c -o $(BINARIES)/$@ $(LDFLAGS)

filterbank: rtbench
	$(CC) $(CFLAGS) bench/kernel/filterbank/filterbank.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

fir2dim: rtbench
	$(CC) $(CFLAGS) bench/kernel/fir2dim/fir2dim.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

iir: rtbench
	$(CC) $(CFLAGS) bench/kernel/iir/iir.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

insertsort: rtbench
	$(CC) $(CFLAGS) bench/kernel/insertsort/insertsort.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

isqrt: rtbench
	$(CC) $(CFLAGS) bench/kernel/isqrt/isqrt.c $(BASE_O) bench/kernel/isqrt/basicmath_libc.c -o $(BINARIES)/$@ $(LDFLAGS)

jfdctint: rtbench
	$(CC) $(CFLAGS) bench/kernel/jfdctint/jfdctint.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

lms: rtbench
	$(CC) $(CFLAGS) bench/kernel/lms/lms.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

ludcmp: rtbench
	$(CC) $(CFLAGS) bench/kernel/ludcmp/ludcmp.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

matrix1: rtbench
	$(CC) $(CFLAGS) bench/kernel/matrix1/matrix1.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

md5: rtbench
	$(CC) $(CFLAGS) bench/kernel/md5/md5.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

pm: rtbench
	$(CC) $(CFLAGS) bench/kernel/pm/pm.c $(BASE_O) bench/kernel/pm/pm_input.c bench/kernel/pm/pm_libm.c bench/kernel/pm/pm_stdlib.c -o $(BINARIES)/$@ $(LDFLAGS)

prime: rtbench
	$(CC) $(CFLAGS) bench/kernel/prime/prime.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

quicksort: rtbench
	$(CC) $(CFLAGS) bench/kernel/quicksort/quicksort.c $(BASE_O) bench/kernel/quicksort/quicksortlibm.c bench/kernel/quicksort/quicksortstdlib.c bench/kernel/quicksort/input.c -o $(BINARIES)/$@ $(LDFLAGS)

rad2deg: rtbench
	$(CC) $(CFLAGS) bench/kernel/rad2deg/rad2deg.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

recursion: rtbench
	$(CC) $(CFLAGS) bench/kernel/recursion/recursion.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

sha: rtbench
	$(CC) $(CFLAGS) bench/kernel/sha/sha.c $(BASE_O) bench/kernel/sha/input_small.c bench/kernel/sha/memhelper.c bench/kernel/sha/memcpy.c bench/kernel/sha/memset.c -o $(BINARIES)/$@ $(LDFLAGS)

st: rtbench
	$(CC) $(CFLAGS) bench/kernel/st/st.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

adpcm_dec: rtbench
	$(CC) $(CFLAGS) bench/sequential/adpcm_dec/adpcm_dec.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

adpcm_enc: rtbench
	$(CC) $(CFLAGS) bench/sequential/adpcm_enc/adpcm_enc.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

ammunition: rtbench
	$(CC) $(CFLAGS) bench/sequential/ammunition/ammunition.c $(BASE_O) bench/sequential/ammunition/arithm.c bench/sequential/ammunition/ammunition_libc.c bench/sequential/ammunition/bits.c -o $(BINARIES)/$@ $(LDFLAGS)

anagram: rtbench
	$(CC) $(CFLAGS) bench/sequential/anagram/anagram.c $(BASE_O) bench/sequential/anagram/anagram_input.c bench/sequential/anagram/anagram_stdlib.c -o $(BINARIES)/$@ $(LDFLAGS)

audiobeam: rtbench
	$(CC) $(CFLAGS) bench/sequential/audiobeam/audiobeam.c $(BASE_O) bench/sequential/audiobeam/audiobeamlibm.c bench/sequential/audiobeam/audiobeamlibmalloc.c bench/sequential/audiobeam/audiobeaminput.c -o $(BINARIES)/$@ $(LDFLAGS)

cjpeg_transupp: rtbench
	$(CC) $(CFLAGS) bench/sequential/cjpeg_transupp/cjpeg_transupp.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

cjpeg_wrbmp: rtbench
	$(CC) $(CFLAGS) bench/sequential/cjpeg_wrbmp/cjpeg_wrbmp.c $(BASE_O) bench/sequential/cjpeg_wrbmp/input.c -o $(BINARIES)/$@ $(LDFLAGS)

dijkstra: rtbench
	$(CC) $(CFLAGS) bench/sequential/dijkstra/dijkstra.c $(BASE_O) bench/sequential/dijkstra/input.c -o $(BINARIES)/$@ $(LDFLAGS)

epic: rtbench
	$(CC) $(CFLAGS) bench/sequential/epic/epic.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

fmref: rtbench
	$(CC) $(CFLAGS) bench/sequential/fmref/fmref.c $(BASE_O) bench/sequential/fmref/wcclibm.c -o $(BINARIES)/$@ $(LDFLAGS)

g723_enc: rtbench
	$(CC) $(CFLAGS) bench/sequential/g723_enc/g723_enc.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

gsm_dec: rtbench
	$(CC) $(CFLAGS) bench/sequential/gsm_dec/gsm_dec.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

gsm_enc: rtbench
	$(CC) $(CFLAGS) bench/sequential/gsm_enc/gsm_enc.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

h264_dec: rtbench
	$(CC) $(CFLAGS) bench/sequential/h264_dec/h264_dec.c $(BASE_O) bench/sequential/h264_dec/h264_decinput.c -o $(BINARIES)/$@ $(LDFLAGS)

huff_dec: rtbench
	$(CC) $(CFLAGS) bench/sequential/huff_dec/huff_dec.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

huff_enc: rtbench
	$(CC) $(CFLAGS) bench/sequential/huff_enc/huff_enc.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

mpeg2: rtbench
	$(CC) $(CFLAGS) bench/sequential/mpeg2/mpeg2.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

ndes: rtbench
	$(CC) $(CFLAGS) bench/sequential/ndes/ndes.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

petrinet: rtbench
	$(CC) $(CFLAGS) bench/sequential/petrinet/petrinet.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

rijndael_dec: rtbench
	$(CC) $(CFLAGS) bench/sequential/rijndael_dec/rijndael_dec.c $(BASE_O) bench/sequential/rijndael_dec/rijndael_dec_libc.c bench/sequential/rijndael_dec/aes.c bench/sequential/rijndael_dec/input_small_enc.c -o $(BINARIES)/$@ $(LDFLAGS)

rijndael_enc: rtbench
	$(CC) $(CFLAGS) bench/sequential/rijndael_enc/rijndael_enc.c $(BASE_O) bench/sequential/rijndael_enc/rijndael_enc_libc.c bench/sequential/rijndael_enc/aes.c bench/sequential/rijndael_enc/input_small.c -o $(BINARIES)/$@ $(LDFLAGS)

statemate: rtbench
	$(CC) $(CFLAGS) bench/sequential/statemate/statemate.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

susan: rtbench
	$(CC) $(CFLAGS) bench/sequential/susan/susan.c $(BASE_O) bench/sequential/susan/input.c bench/sequential/susan/wccfile.c bench/sequential/susan/wcclibm.c bench/sequential/susan/wccmalloc.c -o $(BINARIES)/$@ $(LDFLAGS)

lift: rtbench
	$(CC) $(CFLAGS) bench/app/lift/lift.c $(BASE_O) bench/app/lift/liftlibcontrol.c bench/app/lift/liftlibio.c -o $(BINARIES)/$@ $(LDFLAGS)

powerwindow: rtbench
	$(CC) $(CFLAGS) bench/app/powerwindow/powerwindow.c $(BASE_O) bench/app/powerwindow/powerwindow_const_params.c bench/app/powerwindow/powerwindow_controlexclusion.c bench/app/powerwindow/powerwindow_debounce.c bench/app/powerwindow/powerwindow_inputs.c bench/app/powerwindow/powerwindow_powerwindow_control.c bench/app/powerwindow/powerwindow_PW_Control_DRV.c bench/app/powerwindow/powerwindow_PW_Control_PSG_BackL.c bench/app/powerwindow/powerwindow_PW_Control_PSG_BackR.c bench/app/powerwindow/powerwindow_PW_Control_PSG_Front.c bench/app/powerwindow/wcclib.c -o $(BINARIES)/$@ $(LDFLAGS)

cover: rtbench
	$(CC) $(CFLAGS) bench/test/cover/cover.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

duff: rtbench
	$(CC) $(CFLAGS) bench/test/duff/duff.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

test3: rtbench
	$(CC) $(CFLAGS) bench/test/test3/test3.c $(BASE_O) -o $(BINARIES)/$@ $(LDFLAGS)

clean:
	rm -f $(PGMS) $(BASE_O)
	rm -f bench/*/*/*.o
