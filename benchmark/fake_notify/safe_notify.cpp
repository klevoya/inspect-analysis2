#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;
using namespace std;

class FakeNotify : public contract {
  public:
      using contract::contract;

      // no checking from or to
      [[eosio::on_notify("eosio.token::transfer")]] void playgame(name from, name to, asset quantity, string memo) {
        if(from == get_self()) return;
        if(to != _self) return;
      }

};


EOSIO_DISPATCH( FakeNotify, (playgame));
