(module
  (type $t0 (func))
  (type $t1 (func (param i32 i32) (result i32)))
  (func $__wasm_call_ctors (type $t0))
  (func $ch (export "ch") (type $t1) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l0 i32) (local $l1 i32)
    i32.const 1
    set_local $l0
    block $B0
      block $B1
        get_local $p0
        get_local $p1
        i32.eq
        br_if $B1
        i32.const 3
        set_local $l1
        i32.const 2
        set_local $l0
        get_local $p1
        i32.const 1
        i32.add
        get_local $p0
        i32.ne
        br_if $B0
      end
      get_local $l0
      set_local $l1
    end
    get_local $l1)
  (table $T0 1 1 anyfunc)
  (memory $memory (export "memory") 2)
  (global $g0 (mut i32) (i32.const 66560))
  (global $__heap_base (export "__heap_base") i32 (i32.const 66560))
  (global $__data_end (export "__data_end") i32 (i32.const 1024)))
