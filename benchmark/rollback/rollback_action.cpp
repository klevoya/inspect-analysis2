#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>

using namespace eosio;
using namespace std;

static constexpr extended_symbol EOS_SYMBOL =
    extended_symbol(symbol("EOS", 4), name("eosio.token"));

CONTRACT rollback : public contract {
public:
  using contract::contract;

  ACTION transfer(const name &from, const name &to, const asset &quantity,
                  const string &memo) {
    check(false, "bla");
  }

  using transfer_action =
      eosio::action_wrapper<"transfer"_n, &rollback::transfer>;

  ACTION batchpayout(std::vector<name> tos, asset quantity) {
    require_auth(get_self());

    for (const name &to : tos) {
      transfer_action transfer_act(
          EOS_SYMBOL.get_contract(),
          permission_level{get_self(), name("active")});
      transfer_act.send(get_self(), to, quantity / tos.size(), "payout");
    }
  }

  ACTION log(std::vector<name> tos, asset quantity) {
    require_auth(get_self());
  }
  using log_action = eosio::action_wrapper<"log"_n, &rollback::log>;

  ACTION trade(std::vector<name> tos, asset quantity) {
    require_auth(get_self());

    log_action log_act(get_self(),
                       permission_level{get_self(), name("active")});
    log_act.send(tos, quantity);
  }

  ACTION trade2(std::vector<name> tos, asset quantity) {
    require_auth(get_self());

    log_action log_act(current_receiver(),
                       permission_level{get_self(), name("active")});
    log_act.send(tos, quantity);
  }

  ACTION trade3(std::vector<name> tos, asset quantity) {
    require_auth(get_self());

    log_action log_act(_self, permission_level{get_self(), name("active")});
    log_act.send(tos, quantity);
  }
};
