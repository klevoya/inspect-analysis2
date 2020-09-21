#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


class Rollback : public contract {
  public:
      using contract::contract;

      void reveal(std::string memo, name from, asset quantity){
        if(memo == "12345"){
          action(
           permission_level{get_self(), "active"_n},
           "eosio.token"_n, "transfer"_n,
           std::make_tuple(get_self(), from, quantity, std::string(""))
          ).send();
        }
      }


      [[eosio::on_notify("eosio.token::transfer")]] 
      void playgame(name from, name to, asset quantity, std::string memo) {
        if(to != get_self()) return;
        reveal(memo, from, quantity);
      }

};


EOSIO_DISPATCH( Rollback, (playgame));
