#include <eosio/eosio.hpp>

using namespace eosio;

CONTRACT seperation : public contract {
public:
  using contract::contract;

  // safe
  void playgame(name from, name to) {
    if (to != get_self())
      return;
    check(false, "1");
  }

  // unsafe
  void playgame2(name from, name to) {
    if (to != get_self())
      return;
    check(false, "2");
  }

  // safe
  void playgame3(name from, name to) {
    if (to != get_self())
      return;
    check(false, "3");
  }
};

// custom apply function => any ACTION/on_notify macros are ignored
extern "C" {
void apply(uint64_t receiver, uint64_t code, uint64_t action) {
  // internal action
  if (code == receiver) {
    execute_action(name(receiver), name(code), &seperation::playgame);
  }

  if(action == name("playgame3").value) {
    execute_action(name(receiver), name(code), &seperation::playgame2);
  }

  // notification
  if (receiver != code && action == name("transfer").value) {
    switch (action) { EOSIO_DISPATCH_HELPER(seperation, (playgame3)) }
  }
}
}
