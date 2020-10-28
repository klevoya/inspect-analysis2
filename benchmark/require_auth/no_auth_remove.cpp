#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT no_auth_remove : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name user) {
        people_index people(get_first_receiver(), get_first_receiver().value);

        // require_auth(user);
        auto itr = people.find(user.value);
        people.erase( itr );
      }
  private:
  	  struct [[eosio::table]] person {
  	    name key;
  	    uint64_t primary_key() const { return key.value; }
  	  };
  	  using people_index = eosio::multi_index<"people"_n, person>;
};
