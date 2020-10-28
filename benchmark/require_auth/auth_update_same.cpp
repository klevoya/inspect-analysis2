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

  ACTION updatemiss(name username, const std::string &display_name) {
    auto itr = _users.begin();
    _users.modify(itr, eosio::same_payer, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION updatemiss2(name username, const std::string &display_name) {
    auto itr = _users.begin();
    _users.modify(itr, name(0), [&](auto &new_user) {
      new_user.username = name(username.value + 1);
      new_user.display_name = display_name;
    });
  }

  ACTION updatemiss3(name username, const std::string &display_name) {
    auto itr = _users.begin();
    _users.modify(itr, name(""), [&](auto &new_user) {
      new_user.username = name(username.value + 2);
      new_user.display_name = display_name;
    });
  }

  // safe
  ACTION updateuser(name username, const std::string &display_name) {
    require_auth(username);

    auto itr = --_users.end();
    _users.modify(itr, eosio::same_payer, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  // safe
  ACTION updateself(name username, const std::string &display_name) {
    require_auth(get_self());

    auto itr = --_users.end();
    _users.modify(itr, eosio::same_payer, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  // safe
  ACTION updateself2(name username, const std::string &display_name) {
    require_auth(get_self());

    auto itr = --_users.end();
    _users.modify(itr, name(0), [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }
};
