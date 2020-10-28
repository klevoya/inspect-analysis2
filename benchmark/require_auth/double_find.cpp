#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT double_find : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer1(name user) {
        people_index people(get_first_receiver(), get_first_receiver().value);

        auto itr = people.find(user.value);
        people.erase( itr );
      }

      [[eosio::action]]
      void transfer2(name user) {
        people_index people(get_first_receiver(), get_first_receiver().value);

        auto itr = people.find(user.value);
      }

  private:
  	  struct [[eosio::table]] person {
  	    name key;
  	    uint64_t primary_key() const { return key.value; }
  	  };
  	  using people_index = eosio::multi_index<"people"_n, person>;
};

