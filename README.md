# inspect-analysis2
Inspect is a security scanner for EOSIO smart contracts.

## Getting Started

### Requirements
* Soufflé: https://github.com/souffle-lang/souffle/releases (Inspect-Analysis currently has only been tested to work on [v1.7.1](https://github.com/souffle-lang/souffle/releases/tag/1.7.1) of Souffle, it will likely not work with the latest v2.x package). As of writing, Soufflé is not available on Windows, so Inspect should not be expected to run on Windows either. For Mac see here.
* Java10

### Use

#### WebAssembly Disassembly

The disassembler is contained in the "binaries/" folder. To see the full list of disassembly options:
```sh
java -jar build/libs/inspect-0.x.x.jar -h
```

WebAssembly byte-code must first be disassembled to extract a series of facts upon which Souffle static analysis will be performed.

Disassemble the WASM binary/smart contract (e.g. produced by running the [eosio-cpp compiler](https://github.com/EOSIO/eosio.cdt)) and tell the disassembler to keep the produced artefacts in a newly created "artefacts" directory by:
```sh
mkdir artefacts
java -jar binaries/inspect-0.x.x.jar -i binaries/wasm/analysis/ImproperAccessControl/simple_no_auth_check.wasm --keep-artefacts -w artefacts/
```
The "artefacts/" directory will contain newly produced directories labelled with souffle and some random identifier, one each for input and output facts per disassembly run.

#### Perform static analysis with Souffle

Then with all the relevant input facts in the "artefacts" directory, you can run Souffle as many times as needed (in this example input facts are in "souffle-0c52e085-3252-4a82-826e-366f0ba7c6e3/" and output facts will be placed in "souffle-0c52e085-3252-4a82-826e-366f0ba7c6e3_OUT":
```sh
souffle -F artefacts/souffle-0c52e085-3252-4a82-826e-366f0ba7c6e3 -D artefacts/souffle-0c52e085-3252-4a82-826e-366f0ba7c6e3_OUT/ smt_files/analysis.dl
```

#### Bash script usage
1. Grant Permission
```sh
inspect-analysis2$ chomod +x inspect trans 
```
2. Run inspect (decompiler + analysis in datalog)
```sh
inspect-analysis2$ inspect foo.wasm
```
3. Print out the decompiled program to the terminal (Only one will be printed)
```sh
inspect-analysis2$ trans
```
