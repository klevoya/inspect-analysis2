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
    _users.modify(itr, username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  // safe
  ACTION updateuser(name username, const std::string &display_name) {
    require_auth(username);

    auto itr = --_users.end();
    _users.modify(itr, username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION updateuser2(name username, const std::string &display_name) {
    require_auth(get_self());

    auto itr = --_users.end();
    _users.modify(itr, username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  // safe
  ACTION updateself(name username, const std::string &display_name) {
    require_auth(_self);

    auto itr = _users.lower_bound(username.value);
    _users.modify(itr, _self, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  // safe
  ACTION updateself2(name username, const std::string &display_name) {
    require_auth(get_self());

    auto itr = _users.lower_bound(username.value);
    _users.modify(itr, current_receiver(), [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION updateself3(name username, const std::string &display_name) {
    require_auth(username);

    auto itr = _users.lower_bound(username.value);
    _users.modify(itr, get_self(), [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION updateself4(name dummy, name username, const std::string &display_name) {
    check(get_self() == name("test"), "wrong account");

    upsert_helper(username, display_name);
  }

  // safe
  ACTION updateself5(name dummy, const std::string &display_name, name username) {
    require_auth(username);

    upsert_helper(username, display_name);
  }

  __attribute__((noinline)) void upsert_helper(name username, std::string display_name) {
    auto itr = _users.find(username.value);
    if (itr != _users.end()) {
      _users.emplace(username, [&](auto &new_user) {
        new_user.username = username;
        new_user.display_name = display_name;
      });
    } else {
      _users.modify(itr, username, [&](auto &new_user) {
        new_user.display_name = display_name;
      });
    }
  }
};
