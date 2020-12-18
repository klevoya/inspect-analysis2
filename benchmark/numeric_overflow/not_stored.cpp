#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT not_stored : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name from, name to, uint64_t quantity) {
        people_index people( _self, _self.value );

        // asset from_balance = asset(10, symbol());
        // from_balance.amount -= quantity;

        auto to_itr = people.find(to.value);
        people.modify( to_itr, _self, [&]( auto& row ) {
          row.balance = quantity + 10;
          row.o_balance -= quantity;
          // row.balance += quantity;
          // row.o_balance -= quantity;
        });
      }
  private:
  	  struct [[eosio::table]] person {
  	    name key;
  	    uint64_t balance;
        uint64_t o_balance;
  	    uint64_t primary_key() const { return key.value; }
  	  };
  	  using people_index = eosio::multi_index<"people"_n, person>;
};


