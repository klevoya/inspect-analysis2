#include <eosio/eosio.hpp>
#include <eosio/permission.hpp>

using namespace eosio;

CONTRACT authcheck : public contract {
public:
  using contract::contract;
  authcheck(eosio::name receiver, eosio::name code,
            eosio::datastream<const char *> ds)
      : contract(receiver, code, ds), _users(receiver, receiver.value) {}

  struct [[eosio::table("users")]] user {
    eosio::name username;
    std::string display_name;

    uint64_t primary_key() const { return username.value; }
  };

  typedef eosio::multi_index<"users"_n, user> users_t;

  users_t _users;

  ACTION emplaceself(name username, const std::string &display_name) {
    // contract is paying for RAM, requires checking get_self() auth, otherwise RAM filling attack
    // should be considered safe as db payer == require_auth authorizer
    // _self is initialized in _contract_ constructor from 'receiver' (apply's first argument) and a contract class member variable, get_self() is a getter for _self 
    // require_auth(_self);
    if(has_auth(_self)){
      _users.emplace(_self, [&](auto &new_user) {
        new_user.username = username;
        new_user.display_name = display_name;
      });
    }

    if(!has_auth(_self)){
      require_auth(_self);
    }
    
    _users.emplace(_self, [&](auto &new_user) {
        new_user.username = username;
        new_user.display_name = display_name;
      });
    }
};
