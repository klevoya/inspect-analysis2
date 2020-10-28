(module
  (type $t0 (func))
  (type $t1 (func (param i32 i32) (result i32)))
  (func $__wasm_call_ctors (type $t0))
  (func $arr_store (export "arr_store") (type $t1) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l0 i32) (local $l1 i32)
    get_global $g0
    tee_local $l0
    drop
    get_local $l0
    get_local $p1
    i32.const 2
    i32.shl
    i32.const 15
    i32.add
    i32.const -16
    i32.and
    i32.sub
    tee_local $l1
    drop
    block $B0
      get_local $p1
      i32.const 1
      i32.lt_s
      br_if $B0
      i32.const 0
      set_local $l0
      loop $L1
        get_local $l1
        get_local $l0
        i32.add
        get_local $p0
        get_local $l0
        i32.add
        i32.load
        i32.const 1
        i32.add
        i32.store
        get_local $l0
        i32.const 4
        i32.add
        set_local $l0
        get_local $p1
        i32.const -1
        i32.add
        tee_local $p1
        br_if $L1
      end
      get_local $l1
      i32.load
      return
    end
    i32.const 0)
  (table $T0 1 1 anyfunc)
  (memory $memory (export "memory") 2)
  (global $g0 (mut i32) (i32.const 66560))
  (global $__heap_base (export "__heap_base") i32 (i32.const 66560))
  (global $__data_end (export "__data_end") i32 (i32.const 1024)))
