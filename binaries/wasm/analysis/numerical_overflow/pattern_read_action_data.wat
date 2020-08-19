(module
  (type $t0 (func (param i32 i32) (result i32)))
  (type $t1 (func (param i32 i32 i32) (result i32)))
  (type $t2 (func (param i32 i32)))
  (type $tapply (func (param i64 i64 i64)))
  (import "env" "read_action_data" (func $env.read_action_data (type $t0)))
  (import "env" "memcpy" (func $env.memcpy (type $t1)))
  (import "env" "eosio_assert" (func $env.eosio_assert (type $t2)))
  (func $apply (export "apply") (type $tapply) (param $p0 i64) (param $p1 i64) (param $p2 i64)
    (local $l3 i32)
    (global.set $g0
      (local.tee $l3
        (i32.sub
          (global.get $g0)
          (i32.const 80))))
    (drop
      (call $env.read_action_data
        (local.get $l3)
        (i32.const 16)))
    (i64.store offset=72
      (local.get $l3)
      (i64.const 0))
    (i64.store offset=64
      (local.get $l3)
      (i64.const 0))
    (drop
      (call $env.memcpy
        (i32.add
          (local.get $l3)
          (i32.const 64))
        (local.get $l3)
        (i32.const 8)))
    (drop
      (call $env.memcpy
        (i32.add
          (i32.add
            (local.get $l3)
            (i32.const 64))
          (i32.const 8))
        (i32.or
          (local.get $l3)
          (i32.const 8))
        (i32.const 8)))
    (block $B0
      (br_if $B0
        (i64.eq
          (i64.add
            (i64.load offset=72
              (local.get $l3))
            (i64.load offset=64
              (local.get $l3)))
          (i64.const 12345678)))
      (call $env.eosio_assert
        (i32.const 0)
        (i32.const 8208)))
    (global.set $g0
      (i32.add
        (local.get $l3)
        (i32.const 80))))
  (table $T0 1 1 funcref)
  (memory $M0 1)
  (global $g0 (mut i32) (i32.const 8192))
  (global $g1 i32 (i32.const 8221))
  (global $g2 i32 (i32.const 8221))
  (data $d0 (i32.const 8208) "wrong number\00")
  (data $d1 (i32.const 0) "  \00\00"))
