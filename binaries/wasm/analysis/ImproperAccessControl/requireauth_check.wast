(module
  (type $t0 (func))
  (type $t1 (func (param i32 i64)))
  (type $t2 (func (param i32 i32)))
  (type $t3 (func (param i32 i32 i32) (result i32)))
  (type $t4 (func (result i32)))
  (type $t5 (func (param i32 i32) (result i32)))
  (type $t6 (func (param i64)))
  (type $t7 (func (param i64 i64 i64 i64) (result i32)))
  (type $t8 (func (result i64)))
  (type $t9 (func (param i64 i64 i64 i64 i32 i32) (result i32)))
  (type $t10 (func (param i32) (result i32)))
  (type $t11 (func (param i32)))
  (type $t12 (func (param i64 i64 i64)))
  (type $t13 (func (param i64 i64 i32) (result i32)))
  (type $t14 (func (param i32 i32 i32 i32)))
  (type $t15 (func (param i64 i64)))
  (import "env" "eosio_assert" (func $env.eosio_assert (type $t2)))
  (import "env" "memcpy" (func $env.memcpy (type $t3)))
  (import "env" "require_auth" (func $env.require_auth (type $t6)))
  (import "env" "db_find_i64" (func $env.db_find_i64 (type $t7)))
  (import "env" "current_receiver" (func $env.current_receiver (type $t8)))
  (import "env" "db_store_i64" (func $env.db_store_i64 (type $t9)))
  (import "env" "f20" (func $f20 (type $t10)))
  (import "env" "f22" (func $f22 (type $t11)))
  (import "env" "f32" (func $f32 (type $t5)))
  (import "env" "f33" (func $f33 (type $t14)))
 (func $requireauth_check (param $p0 i32) (param $p1 i64)
    (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i64)
    global.get $g0
    i32.const 32
    i32.sub
    local.tee $l2
    global.set $g0
    local.get $p1
    call $env.require_auth
    local.get $p0
    i32.const 32
    i32.add
    local.set $l3
    block $B0
      block $B1
        local.get $p0
        i32.const 56
        i32.add
        i32.load
        local.tee $l4
        local.get $p0
        i32.const 60
        i32.add
        i32.load
        local.tee $l5
        i32.eq
        br_if $B1
        block $B2
          loop $L3
            local.get $l5
            i32.const -24
            i32.add
            local.tee $l6
            i32.load
            local.tee $l7
            i64.load
            local.get $p1
            i64.eq
            br_if $B2
            local.get $l6
            local.set $l5
            local.get $l4
            local.get $l6
            i32.ne
            br_if $L3
            br $B1
          end
        end
        local.get $l4
        local.get $l5
        i32.eq
        br_if $B1
        local.get $l7
        i32.load offset=16
        local.get $l3
        i32.eq
        br_if $B0
        i32.const 0
        i32.const 8245
        call $env.eosio_assert
        local.get $l2
        i32.const 32
        i32.add
        global.set $g0
        return
      end
      block $B4
        local.get $l3
        i64.load
        local.get $p0
        i32.const 40
        i32.add
        i64.load
        i64.const -3020371635640205312
        local.get $p1
        call $env.db_find_i64
        local.tee $l6
        i32.const 0
        i32.lt_s
        br_if $B4
        local.get $l3
        local.get $l6
        call $f32
        i32.load offset=16
        local.get $l3
        i32.eq
        br_if $B0
        i32.const 0
        i32.const 8245
        call $env.eosio_assert
        local.get $l2
        i32.const 32
        i32.add
        global.set $g0
        return
      end
      block $B5
        call $env.current_receiver
        local.get $l3
        i64.load
        i64.eq
        br_if $B5
        i32.const 0
        i32.const 8324
        call $env.eosio_assert
      end
      i32.const 32
      call $f20
      local.tee $l6
      local.get $l3
      i32.store offset=16
      local.get $l6
      i64.const 0
      i64.store offset=8
      local.get $l6
      local.get $p1
      i64.store
      local.get $l2
      i32.const 16
      i32.add
      local.get $l6
      i32.const 8
      call $env.memcpy
      drop
      local.get $l2
      i32.const 16
      i32.add
      i32.const 8
      i32.or
      local.get $l6
      i32.const 8
      i32.add
      i32.const 8
      call $env.memcpy
      drop
      local.get $l6
      local.get $p0
      i32.const 40
      i32.add
      i64.load
      i64.const -3020371635640205312
      local.get $p1
      local.get $l6
      i64.load
      local.tee $l8
      local.get $l2
      i32.const 16
      i32.add
      i32.const 16
      call $env.db_store_i64
      local.tee $l4
      i32.store offset=20
      block $B6
        local.get $l8
        local.get $p0
        i32.const 48
        i32.add
        local.tee $l5
        i64.load
        i64.lt_u
        br_if $B6
        local.get $l5
        i64.const -2
        local.get $l8
        i64.const 1
        i64.add
        local.get $l8
        i64.const -3
        i64.gt_u
        select
        i64.store
      end
      local.get $l2
      local.get $l6
      i32.store offset=8
      local.get $l2
      local.get $l6
      i64.load
      local.tee $p1
      i64.store offset=16
      local.get $l2
      local.get $l4
      i32.store offset=4
      block $B7
        block $B8
          local.get $p0
          i32.const 60
          i32.add
          local.tee $l7
          i32.load
          local.tee $l5
          local.get $p0
          i32.const 64
          i32.add
          i32.load
          i32.ge_u
          br_if $B8
          local.get $l5
          local.get $p1
          i64.store offset=8
          local.get $l5
          local.get $l4
          i32.store offset=16
          local.get $l2
          i32.const 0
          i32.store offset=8
          local.get $l5
          local.get $l6
          i32.store
          local.get $l7
          local.get $l5
          i32.const 24
          i32.add
          i32.store
          local.get $l2
          i32.load offset=8
          local.set $l6
          local.get $l2
          i32.const 0
          i32.store offset=8
          local.get $l6
          br_if $B7
          br $B0
        end
        local.get $p0
        i32.const 56
        i32.add
        local.get $l2
        i32.const 8
        i32.add
        local.get $l2
        i32.const 16
        i32.add
        local.get $l2
        i32.const 4
        i32.add
        call $f33
        local.get $l2
        i32.load offset=8
        local.set $l6
        local.get $l2
        i32.const 0
        i32.store offset=8
        local.get $l6
        i32.eqz
        br_if $B0
      end
      local.get $l6
      call $f22
    end
    local.get $l2
    i32.const 32
    i32.add
    global.set $g0)
  (memory $M0 1)
  (global $g0 (mut i32) (i32.const 8192))
)
