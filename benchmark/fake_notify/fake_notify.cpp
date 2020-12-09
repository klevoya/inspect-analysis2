#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <eosio/asset.hpp>
#include <eosio/symbol.hpp>

using namespace eosio;
using namespace std;

CONTRACT fake_notify : public contract {
  public:
      using contract::contract;

      // no checking from or to ?
      [[eosio::on_notify("eosio.token::transfer")]] void playgame(name from, name to, asset quantity, string memo) {
        if(from == get_self()) return;

        check(false, "no optimization please");
      }

};
