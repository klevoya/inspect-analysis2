(module
  (type $t0 (func (param i64) (result i64)))
  (func $fac (export "fac") (type $t0) (param $p0 i64) (result i64)
    (local i32)
    local.get $p0
    i64.const 1
    i64.lt_s
    local.set 1
    f64.const 3.5
    f64.const 2.5
    f64.mul
    drop
    local.get 1
    if $I0 (result i64)
      i64.const 1
    else
      local.get $p0
      local.get $p0
      i64.const 1
      i64.sub
      i64.mul
    end))