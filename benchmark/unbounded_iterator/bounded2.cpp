#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


CONTRACT bounded2 : public contract {
  public:
      using contract::contract;
      ACTION total() {
        people_index people( _self, _self.value );
        auto itr = people.begin();
        asset total_balance = asset(0, symbol());
        int i = 0;
        while (itr != people.end() && i < 50) {
          total_balance += itr->balance;
          itr++;
          i++;
        }

        people.modify(itr, _self, [&](auto &new_user) {
          new_user.balance = total_balance;
        });
      }
  private:
      struct [[eosio::table]] person {
        name key;
        asset balance;
        uint64_t primary_key() const { return key.value; }
      };
      using people_index = eosio::multi_index<"people"_n, person>;
};

