#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/system.hpp>

using namespace eosio;
using namespace std;

CONTRACT separation : public contract {
public:
  using contract::contract;
  separation(eosio::name receiver, eosio::name code, eosio::datastream<const char*> ds)
      : contract(receiver, code, ds) {}

  TABLE ownertable {
    uint64_t id;
    name     owner;

    uint64_t primary_key() const { return id; }
  };
  typedef eosio::multi_index<"ownertable"_n, ownertable> owners_t;

  ACTION dummy(uint64_t value) {}
  using dummy_action = eosio::action_wrapper<"dummy"_n, &separation::dummy>;
  ACTION dummy1(name owner) { require_auth(owner); }
  ACTION dummy2(name owner) { require_auth(owner); }
  ACTION dummy3(name owner) { require_auth(owner); }
  ACTION dummy4(name owner) { require_auth(owner); }

  ACTION hello1(name owner) {
    dummy_action act(get_self(), {get_self(), "active"_n});
    act.send(123456);

    require_auth(get_self());
    owners_t owners_table(get_self(), get_self().value);
    auto     it = owners_table.get(owner.value, "owner table not found");

    owners_table.emplace(get_self(), [&](auto& row) {
      row.id    = owner.value;
      row.owner = owner;
    });
  }

  [[eosio::on_notify("eosio.token::transfer")]] void on_transfer(name from, name to, asset quantity,
                                                                 std::string memo) {
    if (from == get_self())
      return;

    require_auth(from);
    check(memo.size() == 12, "wrong size");
  }

  [[eosio::on_notify("*::any")]] void on_any(name owner) {
    check(owner == name("hellohello12"), "wrong owner");
  }
};

extern "C" {
void apply(uint64_t receiver, uint64_t code, uint64_t action) {
  if (code == receiver) {
    switch (action) { EOSIO_DISPATCH_HELPER(separation, (dummy)(dummy1)(dummy2)(dummy4)) }
  }
  // below is vulnerable
  if (action == name("transfer").value) {
    execute_action(name(receiver), name(code), &separation::on_transfer);
  } else {
    execute_action(name(receiver), name(code), &separation::dummy3);
  }
}
}
