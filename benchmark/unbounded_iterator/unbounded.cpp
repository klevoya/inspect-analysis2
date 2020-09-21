#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


class Unbounded : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void total() {
        people_index people( _self, _self.value );
        auto itr = people.begin();
        asset total_balance = asset(0, symbol());
        while (itr != people.end()) {
          total_balance += itr->balance;
          itr++;
        }
      }
  private:
  	  struct [[eosio::table]] person {
  	    name key;
  	    asset balance;
  	    uint64_t primary_key() const { return key.value; }
  	  };
  	  using people_index = eosio::multi_index<"people"_n, person>;
};


EOSIO_DISPATCH( Unbounded, (total));
