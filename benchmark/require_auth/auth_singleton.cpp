#include <eosio/eosio.hpp>
#include <eosio/permission.hpp>
#include <eosio/singleton.hpp>

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
    uint128_t id_i128;
  };

  using users_t = eosio::singleton<"users"_n, user>;
  users_t _users;

  ACTION emplacemiss(name username, const std::string &display_name) {
    _users.set({username, display_name}, username);
  }

  ACTION emplaceself(name username, const std::string &display_name) {
    require_auth(_self);
    _users.set({username, display_name}, username);
  }

  ACTION emplaceself2(name username, const std::string &display_name) {
    check(get_self() == name("test"), "wrong account");

    auto user = _users.get_or_default();
    if (user.username.value != 0) {
      _users.set({username, display_name}, username);
    }
  }

  ACTION emplaceself3(name username, const std::string &display_name) {
    check(get_self() == name("test"), "wrong account");

    emplace_helper(username, display_name);
  }

  ACTION emplaceconst(name username, const std::string &display_name) {
    require_auth(name("peter"));
    _users.set({username, display_name}, username);
  }

  ACTION emplaceuser(name username, const std::string &display_name) {
    // safe
    require_auth(username);
    _users.set({username, display_name}, username);
  }

  ACTION emplaceuser2(name username, const std::string &display_name) {
    // safe
    check(get_self() == name("test"), "wrong account");
    require_auth(username);
    auto user = _users.get_or_default();
    if (user.username.value != 0) {
      _users.set({username, display_name}, username);
    }
  }

  __attribute__((noinline)) void emplace_helper(name username,
                                                std::string display_name) {
    auto user = _users.get_or_default();
    if (user.username.value != 0) {
      _users.set({username, display_name}, username);
    }
  }
};
