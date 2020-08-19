const env = {
  require_recipient: (account) => {
    console.log(`receiver: `, account)
  },
}
const wasmInstance =
      new WebAssembly.Instance(wasmModule, { env });

const { apply } = wasmInstance.exports;
console.log(
  apply(BigInt(123456), BigInt(0), BigInt(0))
);

