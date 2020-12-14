#include <eosio/eosio.hpp>
#include <eosio/permission.hpp>

using namespace eosio;

CONTRACT authcheck1 : public contract {
public:
  using contract::contract;
  authcheck1(eosio::name receiver, eosio::name code,
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

};
