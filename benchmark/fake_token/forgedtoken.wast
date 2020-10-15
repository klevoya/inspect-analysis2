(module
  (type $t0 (func))
  (type $t1 (func (result i32)))
  (type $t2 (func (param i32 i32)))
  (type $t3 (func (param i32 i32 i32) (result i32)))
  (type $t4 (func (param i32 i32) (result i32)))
  (type $t5 (func (param i32 f32)))
  (type $t6 (func (param i32 i64 i64 i64 i64)))
  (type $t7 (func (param i32 f64)))
  (type $t8 (func (param i64 i64 i64 i64) (result i32)))
  (type $t9 (func (param i64 i64) (result f64)))
  (type $t10 (func (param i64 i64) (result f32)))
  (type $t11 (func (param i64 i64) (result i32)))
  (type $t12 (func (param i32 i64)))
  (type $t13 (func (param i64 i64 i64)))
  (type $t14 (func (param i32) (result i32)))
  (type $t15 (func (param i32)))
  (type $t16 (func (param i64 i64)))
  (import "env" "action_data_size" (func $env.action_data_size (type $t1)))
  (import "env" "eosio_assert" (func $env.eosio_assert (type $t2)))
  (import "env" "memset" (func $env.memset (type $t3)))
  (import "env" "read_action_data" (func $env.read_action_data (type $t4)))
  (import "env" "memcpy" (func $env.memcpy (type $t3)))
  (import "env" "abort" (func $env.abort (type $t0)))
  (import "env" "memmove" (func $env.memmove (type $t3)))
  (import "env" "__extendsftf2" (func $env.__extendsftf2 (type $t5)))
  (import "env" "__floatsitf" (func $env.__floatsitf (type $t2)))
  (import "env" "__multf3" (func $env.__multf3 (type $t6)))
  (import "env" "__floatunsitf" (func $env.__floatunsitf (type $t2)))
  (import "env" "__divtf3" (func $env.__divtf3 (type $t6)))
  (import "env" "__addtf3" (func $env.__addtf3 (type $t6)))
  (import "env" "__extenddftf2" (func $env.__extenddftf2 (type $t7)))
  (import "env" "__eqtf2" (func $env.__eqtf2 (type $t8)))
  (import "env" "__letf2" (func $env.__letf2 (type $t8)))
  (import "env" "__netf2" (func $env.__netf2 (type $t8)))
  (import "env" "__subtf3" (func $env.__subtf3 (type $t6)))
  (import "env" "__trunctfdf2" (func $env.__trunctfdf2 (type $t9)))
  (import "env" "__getf2" (func $env.__getf2 (type $t8)))
  (import "env" "__trunctfsf2" (func $env.__trunctfsf2 (type $t10)))
  (import "env" "prints_l" (func $env.prints_l (type $t2)))
  (import "env" "__unordtf2" (func $env.__unordtf2 (type $t8)))
  (import "env" "__fixunstfsi" (func $env.__fixunstfsi (type $t11)))
  (import "env" "__fixtfsi" (func $env.__fixtfsi (type $t11)))
  (import "env" "eosio_assert_code" (func $env.eosio_assert_code (type $t12)))
  (func $f26 (type $t0)
    call $f30)
  (func $apply (type $t13) (param $p0 i64) (param $p1 i64) (param $p2 i64)
    call $f26
    local.get $p0
    local.get $p1
    i64.eq
    if $I0
      local.get $p0
      i64.const 6138663577826885632 ;; eosio
      i64.ne
      if $I1
        i32.const 0
        i64.const 8000000000000000000
        call $env.eosio_assert_code
      end
    else
      i64.const 6138663577826885632 ;; eosio
      local.get $p1
      i64.eq
      if $I2
        i64.const -6569208335818555392 ;; onerror
        local.get $p2
        i64.eq
        if $I3
          i32.const 0
          i64.const 8000000000000000001
          call $env.eosio_assert_code
        end
      end
      i64.const 6138663591592764928 ;; eosio.token
      local.get $p1 ;; THIS IS WHERE THE CHECK HAPPENS WHEN USING on_notify
      i64.eq
      if $I4 ;; if (code == name("eosio.token")) ... else return;
        i64.const -3617168760277827584 ;; transfer
        local.get $p2
        i64.eq
        if $I5
          local.get $p0
          local.get $p1
          call $f47
        end
      end
      i32.const 0
      call $f45
    end)
  (func $f28 (type $t14) (param $p0 i32) (result i32)
    (local $l1 i32) (local $l2 i32) (local $l3 i32)
    block $B0
      block $B1
        block $B2
          block $B3
            local.get $p0
            i32.eqz
            br_if $B3
            i32.const 0
            i32.const 0
            i32.load offset=8204
            local.get $p0
            i32.const 16
            i32.shr_u
            local.tee $l1
            i32.add
            local.tee $l2
            i32.store offset=8204
            i32.const 0
            i32.const 0
            i32.load offset=8196
            local.tee $l3
            local.get $p0
            i32.add
            i32.const 7
            i32.add
            i32.const -8
            i32.and
            local.tee $p0
            i32.store offset=8196
            local.get $l2
            i32.const 16
            i32.shl
            local.get $p0
            i32.le_u
            br_if $B2
            local.get $l1
            memory.grow
            i32.const -1
            i32.eq
            br_if $B1
            br $B0
          end
          i32.const 0
          return
        end
        i32.const 0
        local.get $l2
        i32.const 1
        i32.add
        i32.store offset=8204
        local.get $l1
        i32.const 1
        i32.add
        memory.grow
        i32.const -1
        i32.ne
        br_if $B0
      end
      i32.const 0
      i32.const 8220
      call $env.eosio_assert
      local.get $l3
      return
    end
    local.get $l3)
  (func $f29 (type $t15) (param $p0 i32))
  (func $f30 (type $t0)
    (local $l0 i32)
    global.get $g0
    i32.const 16
    i32.sub
    local.tee $l0
    i32.const 0
    i32.store offset=12
    i32.const 0
    local.get $l0
    i32.load offset=12
    i32.load
    i32.const 7
    i32.add
    i32.const -8
    i32.and
    local.tee $l0
    i32.store offset=8196
    i32.const 0
    local.get $l0
    i32.store offset=8192
    i32.const 0
    memory.size
    i32.store offset=8204)
  (func $f31 (type $t1) (result i32)
    i32.const 8208)
  (func $f32 (type $t4) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32)
    i32.const 0
    local.set $l2
    block $B0
      block $B1
        i32.const 0
        local.get $p0
        i32.sub
        local.tee $l3
        local.get $p0
        i32.and
        local.get $p0
        i32.ne
        br_if $B1
        local.get $p0
        i32.const 16
        i32.gt_u
        br_if $B0
        local.get $p1
        call $f28
        return
      end
      call $f31
      i32.const 22
      i32.store
      i32.const 0
      return
    end
    block $B2
      block $B3
        block $B4
          local.get $p0
          i32.const -1
          i32.add
          local.tee $l4
          local.get $p1
          i32.add
          call $f28
          local.tee $p0
          i32.eqz
          br_if $B4
          local.get $p0
          local.get $l4
          local.get $p0
          i32.add
          local.get $l3
          i32.and
          local.tee $l2
          i32.eq
          br_if $B3
          local.get $p0
          i32.const -4
          i32.add
          local.tee $l3
          i32.load
          local.tee $l4
          i32.const 7
          i32.and
          local.tee $p1
          i32.eqz
          br_if $B2
          local.get $p0
          local.get $l4
          i32.const -8
          i32.and
          i32.add
          local.tee $l4
          i32.const -8
          i32.add
          local.tee $l5
          i32.load
          local.set $l6
          local.get $l3
          local.get $p1
          local.get $l2
          local.get $p0
          i32.sub
          local.tee $l7
          i32.or
          i32.store
          local.get $l2
          i32.const -4
          i32.add
          local.get $l4
          local.get $l2
          i32.sub
          local.tee $l3
          local.get $p1
          i32.or
          i32.store
          local.get $l2
          i32.const -8
          i32.add
          local.get $l6
          i32.const 7
          i32.and
          local.tee $p1
          local.get $l7
          i32.or
          i32.store
          local.get $l5
          local.get $p1
          local.get $l3
          i32.or
          i32.store
          local.get $p0
          call $f29
        end
        local.get $l2
        return
      end
      local.get $p0
      return
    end
    local.get $l2
    i32.const -8
    i32.add
    local.get $p0
    i32.const -8
    i32.add
    i32.load
    local.get $l2
    local.get $p0
    i32.sub
    local.tee $p0
    i32.add
    i32.store
    local.get $l2
    i32.const -4
    i32.add
    local.get $l3
    i32.load
    local.get $p0
    i32.sub
    i32.store
    local.get $l2)
  (func $f33 (type $t3) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    (local $l3 i32)
    i32.const 22
    local.set $l3
    block $B0
      block $B1
        local.get $p1
        i32.const 4
        i32.lt_u
        br_if $B1
        local.get $p1
        local.get $p2
        call $f32
        local.tee $p1
        i32.eqz
        br_if $B0
        local.get $p0
        local.get $p1
        i32.store
        i32.const 0
        local.set $l3
      end
      local.get $l3
      return
    end
    call $f31
    i32.load)
  (func $f34 (type $t14) (param $p0 i32) (result i32)
    (local $l1 i32) (local $l2 i32)
    block $B0
      local.get $p0
      i32.const 1
      local.get $p0
      select
      local.tee $l1
      call $f28
      local.tee $p0
      br_if $B0
      loop $L1
        i32.const 0
        local.set $p0
        i32.const 0
        i32.load offset=8216
        local.tee $l2
        i32.eqz
        br_if $B0
        local.get $l2
        call_indirect (type $t0) $T0
        local.get $l1
        call $f28
        local.tee $p0
        i32.eqz
        br_if $L1
      end
    end
    local.get $p0)
  (func $f35 (type $t14) (param $p0 i32) (result i32)
    local.get $p0
    call $f34)
  (func $f36 (type $t15) (param $p0 i32)
    block $B0
      local.get $p0
      i32.eqz
      br_if $B0
      local.get $p0
      call $f29
    end)
  (func $f37 (type $t15) (param $p0 i32)
    local.get $p0
    call $f36)
  (func $f38 (type $t4) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32) (local $l3 i32)
    global.get $g0
    i32.const 16
    i32.sub
    local.tee $l2
    global.set $g0
    block $B0
      local.get $l2
      i32.const 12
      i32.add
      local.get $p1
      i32.const 4
      local.get $p1
      i32.const 4
      i32.gt_u
      select
      local.tee $p1
      local.get $p0
      i32.const 1
      local.get $p0
      select
      local.tee $l3
      call $f33
      i32.eqz
      br_if $B0
      block $B1
        loop $L2
          i32.const 0
          i32.load offset=8216
          local.tee $p0
          i32.eqz
          br_if $B1
          local.get $p0
          call_indirect (type $t0) $T0
          local.get $l2
          i32.const 12
          i32.add
          local.get $p1
          local.get $l3
          call $f33
          br_if $L2
          br $B0
        end
      end
      local.get $l2
      i32.const 0
      i32.store offset=12
    end
    local.get $l2
    i32.load offset=12
    local.set $p0
    local.get $l2
    i32.const 16
    i32.add
    global.set $g0
    local.get $p0)
  (func $f39 (type $t4) (param $p0 i32) (param $p1 i32) (result i32)
    local.get $p0
    local.get $p1
    call $f38)
  (func $f40 (type $t2) (param $p0 i32) (param $p1 i32)
    block $B0
      local.get $p0
      i32.eqz
      br_if $B0
      local.get $p0
      call $f29
    end)
  (func $f41 (type $t2) (param $p0 i32) (param $p1 i32)
    local.get $p0
    local.get $p1
    call $f40)
  (func $f42 (type $t15) (param $p0 i32)
    call $env.abort
    unreachable)
  (func $f43 (type $t4) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32) (local $l3 i32) (local $l4 i32)
    local.get $p0
    i64.const 0
    i64.store align=4
    local.get $p0
    i32.const 8
    i32.add
    local.tee $l2
    i32.const 0
    i32.store
    block $B0
      local.get $p1
      i32.load8_u
      i32.const 1
      i32.and
      br_if $B0
      local.get $p0
      local.get $p1
      i64.load align=4
      i64.store align=4
      local.get $l2
      local.get $p1
      i32.const 8
      i32.add
      i32.load
      i32.store
      local.get $p0
      return
    end
    block $B1
      local.get $p1
      i32.load offset=4
      local.tee $l2
      i32.const -16
      i32.ge_u
      br_if $B1
      local.get $p1
      i32.load offset=8
      local.set $l3
      block $B2
        block $B3
          local.get $l2
          i32.const 11
          i32.ge_u
          br_if $B3
          local.get $p0
          local.get $l2
          i32.const 1
          i32.shl
          i32.store8
          local.get $p0
          i32.const 1
          i32.add
          local.set $p1
          local.get $l2
          br_if $B2
          local.get $p1
          local.get $l2
          i32.add
          i32.const 0
          i32.store8
          local.get $p0
          return
        end
        local.get $l2
        i32.const 16
        i32.add
        i32.const -16
        i32.and
        local.tee $l4
        call $f34
        local.set $p1
        local.get $p0
        local.get $l4
        i32.const 1
        i32.or
        i32.store
        local.get $p0
        local.get $p1
        i32.store offset=8
        local.get $p0
        local.get $l2
        i32.store offset=4
      end
      local.get $p1
      local.get $l3
      local.get $l2
      call $env.memcpy
      drop
      local.get $p1
      local.get $l2
      i32.add
      i32.const 0
      i32.store8
      local.get $p0
      return
    end
    call $env.abort
    unreachable)
  (func $f44 (type $t2) (param $p0 i32) (param $p1 i32)
    (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i32)
    block $B0
      block $B1
        block $B2
          block $B3
            local.get $p1
            i32.const -16
            i32.ge_u
            br_if $B3
            block $B4
              block $B5
                local.get $p0
                i32.load8_u
                local.tee $l2
                i32.const 1
                i32.and
                br_if $B5
                local.get $l2
                i32.const 1
                i32.shr_u
                local.set $l3
                i32.const 10
                local.set $l4
                br $B4
              end
              local.get $p0
              i32.load
              local.tee $l2
              i32.const -2
              i32.and
              i32.const -1
              i32.add
              local.set $l4
              local.get $p0
              i32.load offset=4
              local.set $l3
            end
            i32.const 10
            local.set $l5
            block $B6
              local.get $l3
              local.get $p1
              local.get $l3
              local.get $p1
              i32.gt_u
              select
              local.tee $p1
              i32.const 11
              i32.lt_u
              br_if $B6
              local.get $p1
              i32.const 16
              i32.add
              i32.const -16
              i32.and
              i32.const -1
              i32.add
              local.set $l5
            end
            block $B7
              block $B8
                block $B9
                  local.get $l5
                  local.get $l4
                  i32.eq
                  br_if $B9
                  block $B10
                    local.get $l5
                    i32.const 10
                    i32.ne
                    br_if $B10
                    i32.const 1
                    local.set $l6
                    local.get $p0
                    i32.const 1
                    i32.add
                    local.set $p1
                    local.get $p0
                    i32.load offset=8
                    local.set $l4
                    i32.const 0
                    local.set $l7
                    i32.const 1
                    local.set $l8
                    local.get $l2
                    i32.const 1
                    i32.and
                    br_if $B7
                    br $B2
                  end
                  local.get $l5
                  i32.const 1
                  i32.add
                  call $f34
                  local.set $p1
                  local.get $l5
                  local.get $l4
                  i32.gt_u
                  br_if $B8
                  local.get $p1
                  br_if $B8
                end
                return
              end
              block $B11
                local.get $p0
                i32.load8_u
                local.tee $l2
                i32.const 1
                i32.and
                br_if $B11
                i32.const 1
                local.set $l7
                local.get $p0
                i32.const 1
                i32.add
                local.set $l4
                i32.const 0
                local.set $l6
                i32.const 1
                local.set $l8
                local.get $l2
                i32.const 1
                i32.and
                i32.eqz
                br_if $B2
                br $B7
              end
              local.get $p0
              i32.load offset=8
              local.set $l4
              i32.const 1
              local.set $l6
              i32.const 1
              local.set $l7
              i32.const 1
              local.set $l8
              local.get $l2
              i32.const 1
              i32.and
              i32.eqz
              br_if $B2
            end
            local.get $p0
            i32.load offset=4
            i32.const 1
            i32.add
            local.tee $l2
            i32.eqz
            br_if $B0
            br $B1
          end
          call $env.abort
          unreachable
        end
        local.get $l2
        i32.const 254
        i32.and
        local.get $l8
        i32.shr_u
        i32.const 1
        i32.add
        local.tee $l2
        i32.eqz
        br_if $B0
      end
      local.get $p1
      local.get $l4
      local.get $l2
      call $env.memcpy
      drop
    end
    block $B12
      local.get $l6
      i32.eqz
      br_if $B12
      local.get $l4
      call $f36
    end
    block $B13
      local.get $l7
      i32.eqz
      br_if $B13
      local.get $p0
      local.get $l3
      i32.store offset=4
      local.get $p0
      local.get $p1
      i32.store offset=8
      local.get $p0
      local.get $l5
      i32.const 1
      i32.add
      i32.const 1
      i32.or
      i32.store
      return
    end
    local.get $p0
    local.get $l3
    i32.const 1
    i32.shl
    i32.store8)
  (func $f45 (type $t15) (param $p0 i32))
  (func $f46 (type $t15) (param $p0 i32)
    call $env.abort
    unreachable)
  (func $f47 (type $t16) (param $p0 i64) (param $p1 i64)
    (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i64)
    global.get $g0
    i32.const 80
    i32.sub
    local.tee $l2
    local.set $l3
    local.get $l2
    global.set $g0
    block $B0
      block $B1
        block $B2
          block $B3
            call $env.action_data_size
            local.tee $l4
            i32.eqz
            br_if $B3
            local.get $l4
            i32.const 512
            i32.lt_u
            br_if $B2
            local.get $l4
            call $f28
            local.set $l2
            br $B1
          end
          i32.const 0
          local.set $l2
          br $B0
        end
        local.get $l2
        local.get $l4
        i32.const 15
        i32.add
        i32.const -16
        i32.and
        i32.sub
        local.tee $l2
        global.set $g0
      end
      local.get $l2
      local.get $l4
      call $env.read_action_data
      drop
    end
    local.get $l3
    local.get $l2
    i32.store offset=68
    local.get $l3
    local.get $l2
    i32.store offset=64
    local.get $l3
    local.get $l2
    local.get $l4
    i32.add
    local.tee $l5
    i32.store offset=72
    local.get $l3
    i64.const 0
    i64.store offset=56
    block $B4
      local.get $l4
      i32.const 7
      i32.gt_u
      br_if $B4
      i32.const 0
      i32.const 8263
      call $env.eosio_assert
      local.get $l3
      i32.const 72
      i32.add
      i32.load
      local.set $l5
      local.get $l3
      i32.load offset=68
      local.set $l2
    end
    local.get $l3
    i32.const 56
    i32.add
    local.get $l2
    i32.const 8
    call $env.memcpy
    drop
    local.get $l3
    local.get $l2
    i32.const 8
    i32.add
    local.tee $l2
    i32.store offset=68
    local.get $l3
    i64.const 0
    i64.store offset=48
    block $B5
      local.get $l5
      local.get $l2
      i32.sub
      i32.const 7
      i32.gt_u
      br_if $B5
      i32.const 0
      i32.const 8263
      call $env.eosio_assert
      local.get $l3
      i32.const 64
      i32.add
      i32.const 8
      i32.add
      i32.load
      local.set $l5
      local.get $l3
      i32.load offset=68
      local.set $l2
    end
    local.get $l3
    i32.const 48
    i32.add
    local.get $l2
    i32.const 8
    call $env.memcpy
    drop
    local.get $l3
    local.get $l2
    i32.const 8
    i32.add
    local.tee $l2
    i32.store offset=68
    local.get $l3
    i64.const 0
    i64.store offset=40
    local.get $l3
    i64.const 0
    i64.store offset=32
    block $B6
      local.get $l5
      local.get $l2
      i32.sub
      i32.const 7
      i32.gt_u
      br_if $B6
      i32.const 0
      i32.const 8263
      call $env.eosio_assert
      local.get $l3
      i32.const 72
      i32.add
      i32.load
      local.set $l5
      local.get $l3
      i32.load offset=68
      local.set $l2
    end
    local.get $l3
    i32.const 32
    i32.add
    local.get $l2
    i32.const 8
    call $env.memcpy
    drop
    local.get $l3
    local.get $l2
    i32.const 8
    i32.add
    local.tee $l2
    i32.store offset=68
    local.get $l3
    i64.const 0
    i64.store offset=16
    block $B7
      local.get $l5
      local.get $l2
      i32.sub
      i32.const 7
      i32.gt_u
      br_if $B7
      i32.const 0
      i32.const 8263
      call $env.eosio_assert
      local.get $l3
      i32.load offset=68
      local.set $l2
    end
    local.get $l3
    i32.const 16
    i32.add
    local.get $l2
    i32.const 8
    call $env.memcpy
    drop
    local.get $l3
    i32.const 32
    i32.add
    i32.const 8
    i32.add
    local.tee $l5
    local.get $l3
    i64.load offset=16
    i64.store
    local.get $l3
    local.get $l2
    i32.const 8
    i32.add
    i32.store offset=68
    local.get $l3
    i32.const 0
    i32.store offset=24
    local.get $l3
    i64.const 0
    i64.store offset=16
    local.get $l3
    i32.const 64
    i32.add
    local.get $l3
    i32.const 16
    i32.add
    call $f48
    drop
    local.get $l5
    i64.load
    local.set $l6
    local.get $l3
    local.get $l3
    i32.const 16
    i32.add
    call $f43
    local.set $l2
    block $B8
      block $B9
        block $B10
          block $B11
            block $B12
              local.get $l6
              i64.const 1397703940
              i64.ne
              br_if $B12
              i32.const 1
              local.set $l5
              local.get $l2
              i32.load8_u
              i32.const 1
              i32.and
              br_if $B11
              br $B10
            end
            i32.const 0
            i32.const 8245
            call $env.eosio_assert
            i32.const 1
            local.set $l5
            local.get $l2
            i32.load8_u
            i32.const 1
            i32.and
            i32.eqz
            br_if $B10
          end
          local.get $l2
          i32.load offset=8
          call $f36
          local.get $l3
          i32.load8_u offset=16
          local.get $l5
          i32.and
          i32.eqz
          br_if $B9
          br $B8
        end
        local.get $l3
        i32.load8_u offset=16
        local.get $l5
        i32.and
        br_if $B8
      end
      local.get $l3
      i32.const 80
      i32.add
      global.set $g0
      return
    end
    local.get $l3
    i32.const 24
    i32.add
    i32.load
    call $f36
    local.get $l3
    i32.const 80
    i32.add
    global.set $g0)
  (func $f48 (type $t4) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32)
    global.get $g0
    i32.const 32
    i32.sub
    local.tee $l2
    global.set $g0
    local.get $l2
    i32.const 0
    i32.store offset=24
    local.get $l2
    i64.const 0
    i64.store offset=16
    local.get $p0
    local.get $l2
    i32.const 16
    i32.add
    call $f49
    drop
    block $B0
      block $B1
        block $B2
          block $B3
            block $B4
              block $B5
                block $B6
                  block $B7
                    local.get $l2
                    i32.load offset=20
                    local.get $l2
                    i32.load offset=16
                    local.tee $l3
                    i32.sub
                    local.tee $l4
                    i32.eqz
                    br_if $B7
                    local.get $l2
                    i32.const 8
                    i32.add
                    i32.const 0
                    i32.store
                    local.get $l2
                    i64.const 0
                    i64.store
                    local.get $l4
                    i32.const -16
                    i32.ge_u
                    br_if $B2
                    local.get $l4
                    i32.const 10
                    i32.gt_u
                    br_if $B6
                    local.get $l2
                    local.get $l4
                    i32.const 1
                    i32.shl
                    i32.store8
                    local.get $l2
                    i32.const 1
                    i32.or
                    local.set $l5
                    br $B5
                  end
                  local.get $p1
                  i32.load8_u
                  i32.const 1
                  i32.and
                  br_if $B4
                  local.get $p1
                  i32.const 0
                  i32.store16
                  local.get $p1
                  i32.const 8
                  i32.add
                  local.set $l3
                  br $B3
                end
                local.get $l4
                i32.const 16
                i32.add
                i32.const -16
                i32.and
                local.tee $l6
                call $f34
                local.set $l5
                local.get $l2
                local.get $l6
                i32.const 1
                i32.or
                i32.store
                local.get $l2
                local.get $l5
                i32.store offset=8
                local.get $l2
                local.get $l4
                i32.store offset=4
              end
              local.get $l4
              local.set $l7
              local.get $l5
              local.set $l6
              loop $L8
                local.get $l6
                local.get $l3
                i32.load8_u
                i32.store8
                local.get $l6
                i32.const 1
                i32.add
                local.set $l6
                local.get $l3
                i32.const 1
                i32.add
                local.set $l3
                local.get $l7
                i32.const -1
                i32.add
                local.tee $l7
                br_if $L8
              end
              local.get $l5
              local.get $l4
              i32.add
              i32.const 0
              i32.store8
              block $B9
                block $B10
                  local.get $p1
                  i32.load8_u
                  i32.const 1
                  i32.and
                  br_if $B10
                  local.get $p1
                  i32.const 0
                  i32.store16
                  br $B9
                end
                local.get $p1
                i32.load offset=8
                i32.const 0
                i32.store8
                local.get $p1
                i32.const 0
                i32.store offset=4
              end
              local.get $p1
              i32.const 0
              call $f44
              local.get $p1
              i32.const 8
              i32.add
              local.get $l2
              i32.const 8
              i32.add
              i32.load
              i32.store
              local.get $p1
              local.get $l2
              i64.load
              i64.store align=4
              local.get $l2
              i32.load offset=16
              local.tee $l3
              i32.eqz
              br_if $B0
              br $B1
            end
            local.get $p1
            i32.load offset=8
            i32.const 0
            i32.store8
            local.get $p1
            i32.const 0
            i32.store offset=4
            local.get $p1
            i32.const 8
            i32.add
            local.set $l3
          end
          local.get $p1
          i32.const 0
          call $f44
          local.get $l3
          i32.const 0
          i32.store
          local.get $p1
          i64.const 0
          i64.store align=4
          local.get $l2
          i32.load offset=16
          local.tee $l3
          br_if $B1
          br $B0
        end
        local.get $l2
        call $f42
        unreachable
      end
      local.get $l2
      local.get $l3
      i32.store offset=20
      local.get $l3
      call $f36
    end
    local.get $l2
    i32.const 32
    i32.add
    global.set $g0
    local.get $p0)
  (func $f49 (type $t4) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32) (local $l3 i64) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i32)
    local.get $p0
    i32.load offset=4
    local.set $l2
    i64.const 0
    local.set $l3
    local.get $p0
    i32.const 8
    i32.add
    local.set $l4
    local.get $p0
    i32.const 4
    i32.add
    local.set $l5
    i32.const 0
    local.set $l6
    loop $L0
      block $B1
        local.get $l2
        local.get $l4
        i32.load
        i32.lt_u
        br_if $B1
        i32.const 0
        i32.const 8268
        call $env.eosio_assert
        local.get $l5
        i32.load
        local.set $l2
      end
      local.get $l2
      i32.load8_u
      local.set $l7
      local.get $l5
      local.get $l2
      i32.const 1
      i32.add
      local.tee $l8
      i32.store
      local.get $l3
      local.get $l7
      i32.const 127
      i32.and
      local.get $l6
      i32.const 255
      i32.and
      local.tee $l2
      i32.shl
      i64.extend_i32_u
      i64.or
      local.set $l3
      local.get $l2
      i32.const 7
      i32.add
      local.set $l6
      local.get $l8
      local.set $l2
      local.get $l7
      i32.const 128
      i32.and
      br_if $L0
    end
    block $B2
      block $B3
        local.get $p1
        i32.load offset=4
        local.tee $l7
        local.get $p1
        i32.load
        local.tee $l2
        i32.sub
        local.tee $l5
        local.get $l3
        i32.wrap_i64
        local.tee $l6
        i32.ge_u
        br_if $B3
        local.get $p1
        local.get $l6
        local.get $l5
        i32.sub
        call $f50
        local.get $p0
        i32.const 4
        i32.add
        i32.load
        local.set $l8
        local.get $p1
        i32.const 4
        i32.add
        i32.load
        local.set $l7
        local.get $p1
        i32.load
        local.set $l2
        br $B2
      end
      local.get $l5
      local.get $l6
      i32.le_u
      br_if $B2
      local.get $p1
      i32.const 4
      i32.add
      local.get $l2
      local.get $l6
      i32.add
      local.tee $l7
      i32.store
    end
    block $B4
      local.get $p0
      i32.const 8
      i32.add
      i32.load
      local.get $l8
      i32.sub
      local.get $l7
      local.get $l2
      i32.sub
      local.tee $l7
      i32.ge_u
      br_if $B4
      i32.const 0
      i32.const 8263
      call $env.eosio_assert
      local.get $p0
      i32.const 4
      i32.add
      i32.load
      local.set $l8
    end
    local.get $l2
    local.get $l8
    local.get $l7
    call $env.memcpy
    drop
    local.get $p0
    i32.const 4
    i32.add
    local.tee $l2
    local.get $l2
    i32.load
    local.get $l7
    i32.add
    i32.store
    local.get $p0)
  (func $f50 (type $t2) (param $p0 i32) (param $p1 i32)
    (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32)
    block $B0
      block $B1
        block $B2
          block $B3
            block $B4
              local.get $p0
              i32.load offset=8
              local.tee $l2
              local.get $p0
              i32.load offset=4
              local.tee $l3
              i32.sub
              local.get $p1
              i32.ge_u
              br_if $B4
              local.get $l3
              local.get $p0
              i32.load
              local.tee $l4
              i32.sub
              local.tee $l5
              local.get $p1
              i32.add
              local.tee $l6
              i32.const -1
              i32.le_s
              br_if $B2
              i32.const 2147483647
              local.set $l7
              block $B5
                local.get $l2
                local.get $l4
                i32.sub
                local.tee $l2
                i32.const 1073741822
                i32.gt_u
                br_if $B5
                local.get $l6
                local.get $l2
                i32.const 1
                i32.shl
                local.tee $l2
                local.get $l2
                local.get $l6
                i32.lt_u
                select
                local.tee $l7
                i32.eqz
                br_if $B3
              end
              local.get $l7
              call $f34
              local.set $l2
              br $B1
            end
            local.get $p0
            i32.const 4
            i32.add
            local.set $p0
            loop $L6
              local.get $l3
              i32.const 0
              i32.store8
              local.get $p0
              local.get $p0
              i32.load
              i32.const 1
              i32.add
              local.tee $l3
              i32.store
              local.get $p1
              i32.const -1
              i32.add
              local.tee $p1
              br_if $L6
              br $B0
            end
          end
          i32.const 0
          local.set $l7
          i32.const 0
          local.set $l2
          br $B1
        end
        local.get $p0
        call $f46
        unreachable
      end
      local.get $l2
      local.get $l7
      i32.add
      local.set $l7
      local.get $l3
      local.get $p1
      i32.add
      local.get $l4
      i32.sub
      local.set $l4
      local.get $l2
      local.get $l5
      i32.add
      local.tee $l5
      local.set $l3
      loop $L7
        local.get $l3
        i32.const 0
        i32.store8
        local.get $l3
        i32.const 1
        i32.add
        local.set $l3
        local.get $p1
        i32.const -1
        i32.add
        local.tee $p1
        br_if $L7
      end
      local.get $l2
      local.get $l4
      i32.add
      local.set $l4
      local.get $l5
      local.get $p0
      i32.const 4
      i32.add
      local.tee $l6
      i32.load
      local.get $p0
      i32.load
      local.tee $p1
      i32.sub
      local.tee $l3
      i32.sub
      local.set $l2
      block $B8
        local.get $l3
        i32.const 1
        i32.lt_s
        br_if $B8
        local.get $l2
        local.get $p1
        local.get $l3
        call $env.memcpy
        drop
        local.get $p0
        i32.load
        local.set $p1
      end
      local.get $p0
      local.get $l2
      i32.store
      local.get $l6
      local.get $l4
      i32.store
      local.get $p0
      i32.const 8
      i32.add
      local.get $l7
      i32.store
      local.get $p1
      i32.eqz
      br_if $B0
      local.get $p1
      call $f36
      return
    end)
  (table $T0 1 1 funcref)
  (memory $M0 1)
  (global $g0 (mut i32) (i32.const 8192))
  (global $g1 i32 (i32.const 8272))
  (global $g2 i32 (i32.const 8272))
  (export "apply" (func $apply))
  (data $d0 (i32.const 8220) "failed to allocate pages\00wrong EOS symbol!\00")
  (data $d1 (i32.const 8263) "read\00")
  (data $d2 (i32.const 8268) "get\00")
  (data $d3 (i32.const 0) "P \00\00"))
