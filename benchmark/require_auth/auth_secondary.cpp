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
    uint128_t id_i128;

    uint64_t primary_key() const { return username.value; }
    uint64_t secondary_key_i64() const { return username.value + 1; }
    uint128_t secondary_key_i128() const { return id_i128; }
    checksum256 secondary_key_i256() const {
      return checksum256::make_from_word_sequence<uint64_t>(
          username.value, username.value, username.value, username.value);
    }
    checksum256 secondary_key_i256_alt() const {
      auto checksum = checksum256::make_from_word_sequence<uint64_t>(
          username.value, username.value, username.value, username.value);
      checksum.data()[0]++;
      return checksum;
    }
  };

  typedef eosio::multi_index<
      "users"_n, user,
      indexed_by<"seci12"_n,
                 const_mem_fun<user, uint128_t, &user::secondary_key_i128>>,
      indexed_by<"seci12.1"_n,
                 const_mem_fun<user, uint64_t, &user::secondary_key_i64>>,
      indexed_by<"seci12.2"_n,
                 const_mem_fun<user, uint128_t, &user::secondary_key_i128>>,
      indexed_by<"seci25"_n,
                 const_mem_fun<user, checksum256, &user::secondary_key_i256>>,
      indexed_by<"seci25.2"_n,
                 const_mem_fun<user, checksum256, &user::secondary_key_i256_alt>>>
      users_t;
  users_t _users;

  ACTION emplacemiss(name username, const std::string &display_name) {
    auto it = _users.emplace(username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
    _users.erase(it);
  }

  ACTION emplaceself(name username, const std::string &display_name) {
    require_auth(_self);
    _users.emplace(username, [&](auto &new_user) {
      new_user.username = username;
      new_user.display_name = display_name;
    });
  }

  ACTION emplaceself2(name username, const std::string &display_name) {
    check(get_self() == name("test"), "wrong account");

    auto user_itr = _users.find(username.value);
    if (user_itr != _users.end()) {
      _users.emplace(username, [&](auto &new_user) {
        new_user.username = username;
        new_user.display_name = display_name;
      });
    }
  }

  ACTION emplaceself3(name username, const std::string &display_name) {
    check(get_self() == name("test"), "wrong account");

    emplace_helper(username, display_name);
  }

  ACTION emplaceconst(name username, const std::string &display_name) {
    require_auth(name("peter"));
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

  ACTION emplaceuser2(name username, const std::string &display_name) {
    // safe
    check(get_self() == name("test"), "wrong account");
    require_auth(username);
    auto user_itr = _users.find(username.value);
    if (user_itr != _users.end()) {
      _users.emplace(username, [&](auto &new_user) {
        new_user.username = username;
        new_user.display_name = display_name;
      });
    }
  }

  __attribute__((noinline)) void emplace_helper(name username,
                                                std::string display_name) {
    auto user_itr = _users.find(username.value);
    if (user_itr != _users.end()) {
      _users.emplace(username, [&](auto &new_user) {
        new_user.username = username;
        new_user.display_name = display_name;
      });
    }
  }
};
