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

  ACTION emplacemiss(name username, const std::string &display_name) {
    _users.emplace(username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION emplaceuser(name username, const std::string &display_name) {
    // safe
    require_auth(username);
    _users.emplace(username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION emplaceself(name username, const std::string &display_name) {
    require_auth(_self);
    _users.emplace(username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION emplaceconst(name username, const std::string &display_name) {
    require_auth(name("peter"));
    _users.emplace(username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }
};
