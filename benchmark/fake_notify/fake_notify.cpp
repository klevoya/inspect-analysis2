#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;
using namespace std;

class FakeNotify : public contract {
  public:
      using contract::contract;
      
      void reveal(){

      }

      // no checking from or to
      [[eosio::on_notify("eosio.token::transfer")]] void playgame(name from, name to, asset quantity, string memo) {
        reveal();
      }

};


EOSIO_DISPATCH( FakeNotify, (playgame));
