#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <eosio/asset.hpp>
#include <eosio/symbol.hpp>

using namespace eosio;
using namespace std;

CONTRACT fake_action : public contract {
  public:
      using contract::contract;

      // actions should be ignored
      ACTION transfer(name from, name to, asset quantity, string memo) {
        if(from == get_self()) return;

        check(false, "no optimization please");
      }

};
