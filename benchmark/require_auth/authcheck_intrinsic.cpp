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

  ACTION emplaceself2(name username, const std::string &display_name) {
    require_auth(current_receiver());
    // safe
    // contract is paying for RAM, requires checking get_self() auth, otherwise RAM filling attack
    _users.emplace(_self, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION emplaceself3(name username, const std::string &display_name) {
    require_auth(get_self());
    // safe
    // contract is paying for RAM, requires checking get_self() auth, otherwise RAM filling attack
    _users.emplace(current_receiver(), [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION emplaceself4(name username, const std::string &display_name) {
    require_auth(current_receiver());
    // safe
    // contract is paying for RAM, requires checking get_self() auth, otherwise RAM filling attack
    _users.emplace(current_receiver(), [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION emplaceself5(name username, const std::string &display_name) {
    // unsafe
    require_auth(username);
    // contract is paying for RAM, requires checking get_self() auth, otherwise RAM filling attack
    _users.emplace(current_receiver(), [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }
}; 
