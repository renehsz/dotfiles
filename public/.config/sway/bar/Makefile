CC=musl-gcc
CFLAGS=-Ofast -march=native -mtune=native

status: status.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f status

.PHONY: clean

