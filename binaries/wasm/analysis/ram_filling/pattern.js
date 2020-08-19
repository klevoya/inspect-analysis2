const env = {
  db_store_i64: (...args) => console.log(`db_store_i64 `, args.join(` `)),
  require_auth: (account) => {
    console.log(`require_auth `, account)
  },
}
const wasmInstance =
      new WebAssembly.Instance(wasmModule, { env });

const { apply } = wasmInstance.exports;
console.log(
  apply(BigInt(123456), BigInt(0), BigInt(0))
);

