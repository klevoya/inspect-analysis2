#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT safe_asset : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name from, name to, asset quantity) {
         asset from_balance = asset(10, symbol());
         from_balance -= quantity;
      }
};

