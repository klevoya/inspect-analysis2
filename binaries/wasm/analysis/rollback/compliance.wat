  
(module
  (type $tapply (func (param i64 i64 i64)))
  (type $treq_recipient (func (param i64)))
  (import "env" "require_recipient" (func $env.require_recipient (type $treq_recipient)))
  (func $apply (export "apply") (type $tapply) (param $p0 i64) (param $p1 i64) (param $p2 i64)
    local.get 0
    call $env.require_recipient
))