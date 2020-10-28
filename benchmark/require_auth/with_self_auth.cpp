#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT with_self_auth : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name user, uint64_t quantity) {
        people_index people(get_first_receiver(), get_first_receiver().value);

        require_auth(user);
        people.emplace(get_self(), [&]( auto& row ) {
          row.key = user;
          row.balance = quantity;
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


