#include <eosio/eosio.hpp>
// #include <eosio/asset.hpp>

// #include <eosio/print.hpp>


using namespace eosio;


class hello : public contract {
  public:
      using contract::contract;


      [[eosio::on_notify("eosio.token::transfer")]]
      void hi( name user) {
         
      }

     //  [[eosio::action]]
     //  void something(name user){
     //  	action(
	    //   permission_level{get_self(),"active"_n},
	    //   get_self(),
	    //   "hi"_n,
	    //   std::make_tuple(user)
	    // ).send();
     //  }
};


EOSIO_DISPATCH( hello, (hi));
