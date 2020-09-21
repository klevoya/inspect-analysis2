#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


class UnsafeAsset : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name from, name to, asset quantity) {
         asset from_balance = asset(10, symbol());
         from_balance.amount -= quantity.amount;
      }
};


EOSIO_DISPATCH( UnsafeAsset, (transfer));
