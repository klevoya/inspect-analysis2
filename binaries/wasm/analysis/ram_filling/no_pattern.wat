  
(module
  (type $tapply (func (param i64 i64 i64)))
  (type $t1 (func (param i64 i64 i64 i64 i32 i32) (result i32)))
  (type $t2 (func (param i64)))
  (import "env" "db_store_i64" (func $env.db_store_i64 (type $t1)))
  (import "env" "require_auth" (func $env.require_auth (type $t2)))
  (func $apply (export "apply") (type $tapply) (param $p0 i64) (param $p1 i64) (param $p2 i64)
    ;; require_auth of receiver (_self)
    local.get 0
    call $env.require_auth
    ;; but use receiver as payer
    ;; name scope, name table, const account_name& payer,
    ;; uint64_t id, const char* buffer, size_t buffer_size
    i64.const 0xDEADBEEFDEADBEEF
    i64.const -3020371635640205312
    local.get 0
    i64.const 0xDEADBEEFDEAD0001
    i32.const 100
    i32.const 200
    call $env.db_store_i64
    drop
))