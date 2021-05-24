PREFIX=arm-linux-androideabi-
ARCH=armv7ve
FPU=neon-vfpv4
API_LEVEL=23
HAVE_BE=0
CFLAGS= -mtune=cortex-a7 -mfpu=$(FPU) -Iinclude -O2 -fno-exceptions -fno-rtti -fPIC -march=$(ARCH) -DHAVE_BIG_ENDIAN=$(HAVE_BE) -D__ANDROID_API__=$(API_LEVEL) -DTSTAMP=1 -Wno-implicit-function-declaration

all: libtinyalsa.so 

pcm.o:
	$(PREFIX)gcc $(CFLAGS) -c pcm.c

mixer.o:
	$(PREFIX)gcc $(CFLAGS) -c mixer.c

libtinyalsa.so: pcm.o mixer.o
	$(PREFIX)gcc -shared -s -lcutils -llog -Wl,--build-id=md5 -Wl,-soname,libtinyalsa.so -o libtinyalsa.so pcm.o mixer.o
	if [ ! -d "build" ]; then mkdir build; fi
	mv libtinyalsa.so build/

clean:
	rm pcm.o mixer.o build/libtinyalsa.so
