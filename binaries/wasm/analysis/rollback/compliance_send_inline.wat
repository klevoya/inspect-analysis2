(module
  (type $t0 (func (param i32 i32)))
  (type $t4 (func (param i64 i64 i64)))
  (import "env" "send_inline" (func $env.send_inline (type $t0)))
  (import "env" "eosio_assert" (func $env.eosio_assert (type $t0)))
  (func $apply (export "apply") (type $t4) (param $p0 i64) (param $p1 i64) (param $p2 i64)
    (local $l3 i32)
    (global.set $stackp
      (local.tee $l3
        (i32.sub
          (global.get $stackp)
          (i32.const 16))))
    (i64.store offset=8
      (local.get $l3)
      (i64.const 123456))
    (i64.store
      (local.get $l3)
      (local.get $p0))
    (call $env.send_inline
      (local.get $l3)
      (i32.const 16)))
  (table $T0 1 1 funcref)
  (memory $M0 1)
  (global $stackp (mut i32) (i32.const 8192))
  (data $d0 (i32.const 0) "\10 \00\00"))
