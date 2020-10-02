#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


class WithAuth : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void transfer(name user) {
        people_index people(get_self(), get_self().value);

        require_auth(get_self());
        people.emplace(get_self(), [&]( auto& row ) {
          row.key = user;
        });
      }
  private:
  	  struct [[eosio::table]] person {
  	    name key;
  	    uint64_t primary_key() const { return key.value; }
  	  };
  	  using people_index = eosio::multi_index<"people"_n, person>;
};


EOSIO_DISPATCH( WithAuth, (transfer));
