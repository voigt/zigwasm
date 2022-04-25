# wasm-args

A demonstration how to get CLI arguments.

## Usage

Build `*.wasm` binary:

```bash
$ zig build-exe src/main.zig -target wasm32-wasi
```

Run `*.wasm` binary:

```bash
$ wasmtime main.wasm hello this is the fifth argument
0: main.wasm
1: hello
2: this
3: is
4: the
5: fifth
6: argument
```