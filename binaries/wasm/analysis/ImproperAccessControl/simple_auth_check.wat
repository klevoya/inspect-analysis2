(module
  (type $t0 (func))
  (type $t1 (func (param i64 i64 i64 i64 i32 i32) (result i32)))
  (type $t2 (func (param i64)))
  (import "env" "db_store_i64" (func $env.db_store_i64 (type $t1)))
  (import "env" "require_auth" (func $env.require_auth (type $t2)))
  (func (export "simple_auth_check") (param i32 i64)
    local.get 1
    call $env.require_auth
    local.get 0
    i32.const 1
    i32.add
	drop
    i64.const 0xDEADBEEFDEADBEEF
    i64.const -3020371635640205312
    local.get 1
    i64.const 0xDEADBEEFDEAD0001
    i32.const 100
    i32.const 200
    call $env.db_store_i64
    local.get 0
    i32.sub
    drop
))