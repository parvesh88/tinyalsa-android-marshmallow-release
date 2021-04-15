PREFIX=arm-linux-androideabi-
ARCH=armv7l
API_LEVEL=23
HAVE_BE=0
CFLAGS= -Iinclude -O2 -fno-exceptions -fno-rtti -fPIC -march=armv7l -DHAVE_BIG_ENDIAN=$(HAVE_BE) -D__ANDROID_API__=$(API_LEVEL)

all: libtinyalsa.so 

pcm.o:
	$(PREFIX)gcc $(CFLAGS) -c -o pcm.o  pcm.c

mixer.o:
	$(PREFIX)gcc $(CFLAGS) -c -o mixer.o -Iinclude -fPIC mixer.c

libtinyalsa.so: pcm.o mixer.o
	$(PREFIX)gcc $(CFLAGS) -shared -s -lcutils -llog -o libtinyalsa.so -Wl,--build-id=md5 pcm.o mixer.o
	if [ ! -d "build" ]; then mkdir build; fi
	mv libtinyalsa.so build/

clean:
	rm pcm.o mixer.o build/libtinyalsa.so
