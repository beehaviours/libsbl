CC = gcc
CFLAGS = -Wall -Iinclude -c -fPIC
LDFLAGS = -shared
PREFIX = /usr/local/lib
LIB_NAME = libsbl.so
SOURCES = $(wildcard src/*.c)
OBJECTS = $(patsubst src/%.c, build/%.o, $(SOURCES))

all: build build/$(LIB_NAME)

build:
	mkdir -p build

build/$(LIB_NAME): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

build/%.o: src/%.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -rf build

install:
	install -m 0755 build/$(LIB_NAME) $(PREFIX)/lib
	install -m 0644 include/sbl.h    $(PREFIX)/include
	install -m 0644 include/sblv.h   $(PREFIX)/include

.PHONY: all clean

