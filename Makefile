VERSION_MAJOR = 0
VERSION_MINOR = 1
VERSION_PATCH = 0

CC = gcc
CFLAGS = -Wall -Iinclude -c -fPIC \
		 -DVERSION_MAJOR=$(VERSION_MAJOR) \
		 -DVERSION_MINOR=$(VERSION_MINOR) \
		 -DVERSION_PATCH=$(VERSION_PATCH)
LDFLAGS = -shared

PREFIX ?= /usr/local

SOURCES = $(wildcard src/*.c)
OBJECTS = $(patsubst src/%.c, build/%.o, $(SOURCES))

all: build build/libsbl.so build/libsbl.pc

build:
	mkdir -p build

build/libsbl.so: $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

build/%.o: src/%.c
	$(CC) $(CFLAGS) -o $@ $<

build/libsbl.pc: libsbl.pc.in
	cp libsbl.pc.in build/libsbl.pc
	sed -i -e 's+@PREFIX@+$(PREFIX)+g' build/libsbl.pc
	sed -i -e 's+@MAJOR@+$(VERSION_MAJOR)+g' build/libsbl.pc
	sed -i -e 's+@MINOR@+$(VERSION_MINOR)+g' build/libsbl.pc
	sed -i -e 's+@PATCH@+$(VERSION_PATCH)+g' build/libsbl.pc

clean:
	rm -f $(OBJECTS)

distclean:
	rm -fr build

install:
	install -D -m 644 build/libsbl.so  $(DESTDIR)$(PREFIX)/lib/libsbl.so
	install -D -m 644 include/sbl.h    $(DESTDIR)$(PREFIX)/include/sbl.h
	install -D -m 644 include/sblv.h   $(DESTDIR)$(PREFIX)/include/sblv.h
	install -D -m 644 build/libsbl.pc  `pkg-config --variable=pc_path pkg-config | cut -d ":" -f1`/libsbl.pc

.PHONY: all clean distclean install

