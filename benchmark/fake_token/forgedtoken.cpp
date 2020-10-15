#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <eosio/symbol.hpp>
#include <eosio/asset.hpp>

using namespace eosio;

static constexpr symbol EOS_SYMBOL = symbol("EOS", 4);

CONTRACT forgedtoken : public contract {
public:
  using contract::contract;
  forgedtoken(eosio::name receiver, eosio::name code, eosio::datastream<const char*> ds)
      : contract(receiver, code, ds) {}

  [[eosio::on_notify("eosio.token::transfer")]] void on_transfer(
      name from, name to, eosio::asset quantity, std::string memo) {
    // code parameter already checked
    check(quantity.symbol == EOS_SYMBOL, "wrong EOS symbol!");
    // ...
  }
};
