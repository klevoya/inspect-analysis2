#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT unsafe_store2 : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name from, name to, uint64_t quantity) {
        people_index people( _self, _self.value );

        require_auth(_self);
        people.emplace(_self, [&]( auto& row ) {
          row.key = to;
          row.balance = quantity + 10;
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


