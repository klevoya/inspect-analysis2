#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <eosio/asset.hpp>
#include <eosio/symbol.hpp>

using namespace eosio;
using namespace std;

CONTRACT check_notify : public contract {
  public:
      using contract::contract;

      [[eosio::on_notify("eosio.token::transfer")]] void playgame(name from, name to, asset quantity, string memo) {
        check(to == get_self(),"contract not involved in this tranfer");

        check(false, "no optimization please");
      }

};
