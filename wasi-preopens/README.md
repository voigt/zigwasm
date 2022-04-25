# wasi-preopens

A demonstration how to work with the WASI preopens. This allows us to add an existing directory to the "preopens" of the WASI environment and work with files of this directory from within the sandbox.

## Usage

Build `*.wasm` binary:

```bash
$ zig build-exe src/main.zig -target wasm32-wasi
```

Run `*.wasm` binary:

```bash
$ wasmtime --dir=. main.wasm test.txt
0: std.fs.wasi.Preopen{ .fd = 3, .type = PreopenType{ .Dir = '@"."' } }
std.fs.file.File.Stat{ .inode = 26159141, .size = 5, .mode = 0, .kind = std.fs.file.File.Kind.File, .atime = 1650746429495209915, .mtime = 1650746427552934624, .ctime = 1650746424073060560 }
```