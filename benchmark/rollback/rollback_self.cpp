#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT Rollback : public contract {
  public:
      using contract::contract;

      [[eosio::on_notify("eosio.token::transfer")]] 
      void playgame(name from, name to, asset quantity, std::string memo) {

        action(
           permission_level{get_self(), "active"_n},
           get_self(), "transfer"_n,
           std::make_tuple(get_self(), from, quantity, std::string(""))
          ).send();
      }

};

