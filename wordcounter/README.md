# wordcounter

A demonstration how to count words of a file in the WebAssembly sandbox. Based on [wasi-preopens](https://github.com/voigt/zigwasm/wasi-preopens/).

## Usage

Build `*.wasm` binary:

```bash
$ zig build-exe src/main.zig -target wasm32-wasi
```

Run `*.wasm` binary:

```bash
$ wasmtime --dir=. main.wasm text.txt
A 1
sea, 1
whom 1
clod 1
main. 1
part 1
of 5
Europe 1
If 1
own 1
were. 1
involved 1
never 1
I 1
man 2
well 2
send 1
me, 1
away 1
bell 1
man’s 1
thine 1
Because 1
continent, 1
promontory 1
therefore 1
island, 1
the 5
were: 1
friend’s 1
thy 1
Or 1
Every 1
Any 1
less. 1
diminishes 1
am 1
And 1
a 4
mankind, 1
is 3
be 1
Entire 1
an 1
No 1
piece 1
as 2
It 1
to 1
if 2
washed 1
in 1
for 2
tolls; 1
As 2
itself, 1
know 1
tolls 1
by 1
manor 1
thee. 1
death 1
```