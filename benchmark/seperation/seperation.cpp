#include <eosio/eosio.hpp>

using namespace eosio;


class Seperation : public contract {
  public:
      using contract::contract;

      [[eosio::on_notify("eosio.token::transfer")]] 
      void playgame(name from, name to) {
        if(to != get_self()) return;
      }

};



extern "C" {
  [[eosio::wasm_entry]]
  void apply( uint64_t receiver, uint64_t code, uint64_t action ) {
     auto self = receiver;
 
     if( code == self || code == "eosio.token"_n.value) {
        switch( action ) {
           EOSIO_DISPATCH_HELPER( Seperation, (playgame))
        }
     }
  }
}

