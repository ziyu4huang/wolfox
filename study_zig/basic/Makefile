

all: zig-curl-test.run

zig-curl-test.run: zig-curl-test
	./$<

zig-curl-test: zig-curl-test.zig
	zig build-exe $< --library curl --library c $(pkg-config --cflags libcurl)

