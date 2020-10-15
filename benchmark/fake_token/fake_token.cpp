#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace eosio;
using namespace std;

class FakeToken : public contract {
  public:
      using contract::contract;

   //    ACTION emplaceself(name username, const std::string &display_name) {
	  //   // contract is paying for RAM, requires checking get_self() auth, otherwise RAM filling attack
	  //   // should be considered safe as db payer == require_auth authorizer
	  //   // _self is initialized in _contract_ constructor from 'receiver' (apply's first argument) and a contract class member variable, get_self() is a getter for _self 
	  //   require_auth(_self);
	  // }


      [[eosio::on_notify("*::transfer")]] 
      void transfer(name from, name to, asset quantity, string memo) {
        // check(get_first_receiver() == name("eosio.token"), "fake token");
        check(quantity.symbol == symbol("EOS", 2), "wrong symbol");
      }


};


EOSIO_DISPATCH( FakeToken, (transfer));
