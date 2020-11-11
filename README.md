# inspect-analysis2
Inspect is a security scanner for EOSIO smart contracts.

## Getting Started

### Requirements
* Soufflé: https://github.com/souffle-lang/souffle/releases. As of writing, Soufflé is not available on Windows, so Inspect should not be expected to run on Windows either. For Mac see here.
* Java10

### Use

#### WebAssembly Disassembly

WebAssembly byte-code must first be disassembled to extract a series of facts upon which Souffle static analysis will be performed.
 Place the disassembler binary you have been provided with into the "binaries/" folder. To see the full list of disassembly options:
```sh
java -jar build/libs/inspect-0.x.x.jar -h
```

#### Bash script usage
1. Grant Permission
```sh
inspect-analysis2$ chmod +x inspect trans run_test
```
2. Run inspect (decompiler + analysis in datalog)
```sh
inspect-analysis2$ ./inspect foo.wasm
```
3. Print out the decompiled program to the terminal (For debugging purpose and only one will be printed)
```sh
inspect-analysis2$ ./trans
```
4. Run test suite
```sh
inspect-analysis2$ ./run_test path/to/benchmark/
```
"benchmark" should be a directory with sub-directories storing assorted test cases(.wasm) with according expected output files(.out). The script will generate expected output from actual output if one does not exist.
