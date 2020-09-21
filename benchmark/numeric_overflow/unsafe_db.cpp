#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


class UnsafeDb : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name from, name to, uint64_t quantity) {
        people_index people( _self, _self.value );
        auto from_itr = people.find(from.value);
        people.modify( from_itr, _self, [&]( auto& row ) {
        row.balance = row.balance - quantity;
        });

        auto to_itr = people.find(to.value);
        people.modify( to_itr, _self, [&]( auto& row ) {
        row.balance = row.balance + quantity;
        });
      }
  private:
  	  struct [[eosio::table]] person {
  	    name key;
  	    uint64_t balance;
  	    uint64_t primary_key() const { return key.value; }
  	  };
  	  using people_index = eosio::multi_index<"people"_n, person>;
};


EOSIO_DISPATCH( UnsafeDb, (transfer));
