#include <eosio/eosio.hpp>

using namespace eosio;


CONTRACT Seperation : public contract {
  public:
      using contract::contract;

      [[eosio::on_notify("eosio.token::transfer")]] 
      void playgame(name from, name to) {
        if(to != get_self()) return;
      }

};



extern "C" {
  void apply(uint64_t receiver, uint64_t code, uint64_t action) {
    if(code == receiver){
     execute_action(name(receiver), name(code), &Seperation::playgame);
    }

    if ( receiver != code && action == name("transfer").value) {
      switch (action) { EOSIO_DISPATCH_HELPER(Seperation, (playgame)) }
    }

   }
}

