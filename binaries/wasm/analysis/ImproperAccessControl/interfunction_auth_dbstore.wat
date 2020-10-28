(module
  (type $t0 (func))
  (type $t1 (func (param i64 i64 i64 i64 i32 i32) (result i32)))
  (type $t2 (func (param i64)))
  (type $t3 (func (param i64 i64)))
  (import "env" "db_store_i64" (func $env.db_store_i64 (type $t1)))
  (import "env" "require_auth" (func $env.require_auth (type $t2)))
  (func $interfn_auth_check (export "interfn_auth_check") (type $t3) (param $p0 i64) (param $p1 i64)
    (call $env.require_auth
      (local.get $p1))
    (call $store_in_db
      (local.get $p1)
      (i64.add
        (local.get $p0)
        (i64.const 1)))
    (call $store_in_db
      (i64.const 6100991154140239360)
      (i64.const -7704843146101080064))
    (call $wrap_store
      (local.get $p1)
      (i64.add
        (i64.const -7704843146101080064)
        (local.get $p0))))
  (func $wrap_store (type $t3) (param $p0 i64) (param $p1 i64)
    (call $store_in_db
      (local.get $p0)
      (local.get $p1)))
  (func $store_in_db (type $t3) (param $p0 i64) (param $p1 i64)
    (drop
      (call $env.db_store_i64
        (i64.const -2401053088876216593)
        (i64.const -3020371635640205312)
        (local.get $p0)
        (local.get $p1)
        (i32.const 100)
        (i32.const 200)))))
