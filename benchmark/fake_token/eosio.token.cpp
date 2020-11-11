#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>

using namespace eosio;
using namespace std;

class [[eosio::contract("eosio.token")]] token : public contract {
public:
  using contract::contract;

  ACTION transfer(const name &from, const name &to, const asset &quantity,
                  const string &memo) {
    check(from != to, "cannot transfer to self");
    require_auth(from);
    check(is_account(to), "to account does not exist");
    auto sym = quantity.symbol.code();
    stats statstable(get_self(), sym.raw());
    // somehow this DB get decides if it's a fake_token violation or not
    const auto &st = statstable.get(sym.raw());

    // require_recipient(from);
    // require_recipient(to);

    // check(quantity.is_valid(), "invalid quantity");
    // check(quantity.amount > 0, "must transfer positive quantity");
    // check(quantity.symbol == st.supply.symbol, "symbol precision mismatch");
    // check(memo.size() <= 256, "memo has more than 256 bytes");

    // auto payer = has_auth(to) ? to : from;

    // sub_balance(from, quantity);
    // add_balance(to, quantity, payer);
  }

  void sub_balance(const name &owner, const asset &value) {
    accounts from_acnts(get_self(), owner.value);

    const auto &from =
        from_acnts.get(value.symbol.code().raw(), "no balance object found");
    check(from.balance.amount >= value.amount, "overdrawn balance");

    from_acnts.modify(from, owner, [&](auto &a) { a.balance -= value; });
  }

  void add_balance(const name &owner, const asset &value,
                   const name &ram_payer) {
    accounts to_acnts(get_self(), owner.value);
    auto to = to_acnts.find(value.symbol.code().raw());
    if (to == to_acnts.end()) {
      to_acnts.emplace(ram_payer, [&](auto &a) { a.balance = value; });
    } else {
      to_acnts.modify(to, same_payer, [&](auto &a) { a.balance += value; });
    }
  }

private:
  struct [[eosio::table]] account {
    asset balance;

    uint64_t primary_key() const { return balance.symbol.code().raw(); }
  };

  struct [[eosio::table]] currency_stats {
    asset supply;
    asset max_supply;
    name issuer;

    uint64_t primary_key() const { return supply.symbol.code().raw(); }
  };

  typedef eosio::multi_index<"accounts"_n, account> accounts;
  typedef eosio::multi_index<"stat"_n, currency_stats> stats;
};
