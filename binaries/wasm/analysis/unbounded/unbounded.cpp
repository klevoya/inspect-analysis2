#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/system.hpp>

using namespace eosio;
using namespace std;

CONTRACT unbounded : public contract {
public:
  using contract::contract;
  unbounded(eosio::name receiver, eosio::name code, eosio::datastream<const char*> ds)
      : contract(receiver, code, ds) {}

  TABLE ownertable {
    uint64_t id;
    name     owner;

    uint64_t primary_key() const { return id; }
  };
  typedef eosio::multi_index<"ownertable"_n, ownertable> owners_t;

  // bad
  ACTION killall() {
    require_auth(get_self());
    owners_t owners_table(get_self(), get_self().value);
    auto     it = owners_table.begin();
    while (it != owners_table.end()) {
      it = owners_table.erase(it);
    }
  }

  // should be bad
  ACTION killall2(uint64_t from) {
    require_auth(get_self());
    owners_t owners_table(get_self(), get_self().value);
    auto     it = owners_table.lower_bound(from);
    while (it != owners_table.end()) {
      it = owners_table.erase(it);
    }
  }

  // good
  ACTION killcount(uint64_t count) {
    require_auth(get_self());
    owners_t owners_table(get_self(), get_self().value);
    auto     it      = owners_table.begin();
    uint64_t counter = 0;
    while (it != owners_table.end()) {
      it = owners_table.erase(it);
      counter++;
    }
  }

  // good
  ACTION killconst() {
    require_auth(get_self());
    owners_t owners_table(get_self(), get_self().value);
    auto     it = owners_table.begin();
    for (uint32_t counter = 0; counter < 10 && it != owners_table.end(); counter++) {
      it = owners_table.erase(it);
    }
  }
};
