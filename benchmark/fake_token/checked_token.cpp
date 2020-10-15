#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;
using namespace std;

class FakeToken : public contract {
  public:
      using contract::contract;

      [[eosio::on_notify("*::transfer")]]
      void transfer(name from, name to, asset quantity, string memo) {
      	check(get_first_receiver() == name("eosio.token"), "fake token");
        check(quantity.symbol == symbol("EOS", 2), "wrong symbol");
      }

};


EOSIO_DISPATCH( FakeToken, (transfer));
