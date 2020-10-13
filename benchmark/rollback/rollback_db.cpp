#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;


class Rollback : public contract {
  public:
      using contract::contract;

      [[eosio::on_notify("eosio.token::transfer")]] 
      void playgame(name from, name to, asset quantity, std::string memo) {

        people_index people(get_first_receiver(), get_first_receiver().value);

        require_auth(_self);
        people.emplace(_self, [&]( auto& row ) {
          row.key = _self;
          row.balance = quantity;
        });

        action(
           permission_level{get_self(), "active"_n},
           "eosio.token"_n, "transfer"_n,
           std::make_tuple(get_self(), from, quantity, std::string(""))
          ).send();

      }

  private:
    struct [[eosio::table]] person {
      name key;
      asset balance;
      uint64_t primary_key() const { return key.value; }
    };
    using people_index = eosio::multi_index<"people"_n, person>;

};


EOSIO_DISPATCH( Rollback, (playgame));
