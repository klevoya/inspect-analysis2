#define LINK_PROTOCOL_ETHEREUM true
#define LINK_DEBUG //TO THE DEVELOPER - REMOVE THIS LINE FOR PRODUCTION - DISABLES LIB CHECK
#include "../dappservices/link.hpp"
#define CONTRACT_NAME() ethtokenpeg

#undef MESSAGE_RECEIVED_HOOK
#define MESSAGE_RECEIVED_HOOK(message) message_received(message)

#undef MESSAGE_RECEIPT_HOOK
#define MESSAGE_RECEIPT_HOOK(receipt) receipt_received(receipt)

CONTRACT_START()

  LINK_BOOTSTRAP()

  struct message {
    bool success;
    eosio::name account;            
    int64_t amount;
    eosio::checksum160 address;
  };

  #ifdef LINK_DEBUG 
    TABLE history {
      uint64_t id;
      string type;
      vector<char> data;
      message msg;
      uint64_t primary_key()const { return id; }
    };
    typedef eosio::multi_index<"history"_n, history> history_table;
  #endif

  std::string clean_eth_address(std::string address) {
    // remove initial 0x if there
    if (address[1] == 'x') {
        return address.substr(2);
    }
    return address;
  }

  std::vector<char> HexToBytes(const std::string& hex) {
    std::vector<char> bytes;
    for (unsigned int i = 0; i < hex.length(); i += 2) {
        std::string byteString = hex.substr(i, 2);
        char byte = (char) strtol(byteString.c_str(), NULL, 16);
        bytes.push_back(byte);
    }
    return bytes;
  }

  std::string BytesToHex(vector<char> data)
  {
    std::string s(data.size() * 2, ' ');
    char hexmap[] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
    for (int i = 0; i < data.size(); ++i) {
        s[2 * i]     = hexmap[(data[i] & 0xF0) >> 4];
        s[2 * i + 1] = hexmap[data[i] & 0x0F];
    }
    return s;
  }

  eosio::checksum160 HexToAddress(const std::string& hex) {
    auto bytes = HexToBytes(clean_eth_address(hex));
    std::array<uint8_t, 20> arr;
    std::copy_n(bytes.begin(), 20, arr.begin());
    return eosio::checksum160(arr);
  }

  std::string AddressToHex(const eosio::checksum160& address) {
    std::vector<char> bytes;
    auto arr = address.extract_as_byte_array();
    std::copy_n(arr.begin(), 20, bytes.begin());
    return BytesToHex(bytes);
  }

  int64_t reverse(int64_t value) {
    vector<char> value_v(8);
    vector<char> value_r(8);
    int64_t reversed;

    memcpy(value_v.data(), &value, value_v.size());
    std::reverse_copy(&value_v[0], &value_v[8], &value_r[0]);
    memcpy(&reversed, value_r.data(), value_r.size());
    return reversed;
  }

  message unpack(const vector<char>& data) {
    auto unpacked = eosio::unpack<message>(data);
    auto _amount = unpacked.amount;
    unpacked.amount = reverse(_amount);
    return unpacked;
  }

  vector<char> pack(const message& data) {
    auto _data = data;
    _data.amount = reverse(_data.amount);
    auto packed = eosio::pack(_data);
    return packed;
  }

  TABLE token_settings_t {
    name token_contract;
    symbol token_symbol;
    uint64_t min_transfer;
    bool transfers_enabled;
    bool can_issue; // true if token is being bridged to this chain, else false 
  };
  typedef eosio::singleton<"config"_n, token_settings_t> token_settings_table;
  typedef eosio::multi_index<"config"_n, token_settings_t> token_settings_table_abi;

  [[eosio::action]]
  void init(
    string sister_address,
    string sister_msig_address,
    string sister_chain_name,
    string this_chain_name,
    bool processing_enabled,
    name token_contract,
    symbol token_symbol,
    uint64_t min_transfer,
    bool transfers_enabled,
    bool can_issue // true if token is being bridged to this chain, else false 
  )
  {
      require_auth(_self);
      initlink(
          sister_address,
          sister_msig_address,
          sister_chain_name,
          this_chain_name,
          processing_enabled
      );
      token_settings_table settings_singleton(_self, _self.value);
      token_settings_t settings = settings_singleton.get_or_default();
      settings.token_contract = token_contract;
      settings.token_symbol = token_symbol;
      settings.min_transfer = min_transfer;
      settings.can_issue = can_issue;
      settings.transfers_enabled = transfers_enabled;
      settings_singleton.set(settings, _self);
  }

  [[eosio::action]]
  void enable(bool processing_enabled, bool transfers_enabled)
  {
      require_auth(_self);
      enablelink(processing_enabled);
      token_settings_table settings_singleton(_self, _self.value);
      token_settings_t settings = settings_singleton.get_or_default();
      settings.transfers_enabled = transfers_enabled;
      settings_singleton.set(settings, _self);
  }

  [[eosio::action]]
  void getdest(name from) {
    std::string res = "Destination EOSIO Account Name Value: " + std::to_string(from.value);
    check(false, res);
  }

  void transfer(name from, name to, asset quantity, string memo) {
    token_settings_table settings_singleton(_self, _self.value);
    token_settings_t settings = settings_singleton.get_or_default();
    
    // validate proper transfer
    if (get_first_receiver() != settings.token_contract || from == _self) {
      return;
    }
    check(quantity.symbol == settings.token_symbol, "Incorrect symbol");
    check(quantity.amount >= settings.min_transfer, "Transferred amount is less than minimum required.");
    check(settings.transfers_enabled, "transfers disabled");
    
    // the memo should contain ONLY the eth address.
    message new_transfer = { true, from, quantity.amount, HexToAddress(memo) };
    auto transfer = pack(new_transfer);

    #ifdef LINK_DEBUG    
      history_table histories(_self, _self.value);
      histories.emplace(_self, [&]( auto& a ){
        a.id = histories.available_primary_key();
        a.data = transfer;
        a.msg = new_transfer;
        a.type = "outgoingMessage";
      });
    #endif
    pushMessage(transfer);
  }

  vector<char> message_received(const std::vector<char>& data) {
    token_settings_table settings_singleton(_self, _self.value);
    token_settings_t settings = settings_singleton.get_or_default();
    auto orig_data = data;      
    auto transfer_data = unpack(data);

    std::string memo = "LiquidApps LiquidLink Transfer - Received from Ethereum account 0x";// + AddressToHex(transfer_data.address);

    //TODO: We should check for things like destination account exists, funds are available, a token account exists, etc
    // and then we should be able to return that the message is a failure if those conditions don't pass
    asset quantity = asset(transfer_data.amount, settings.token_symbol);    
    if (settings.can_issue) {
      action(permission_level{_self, "active"_n}, settings.token_contract, "issue"_n,
        std::make_tuple(name(transfer_data.account), quantity, memo))
      .send();
    } else {
      action(permission_level{_self, "active"_n}, settings.token_contract, "transfer"_n,
        std::make_tuple(_self, name(transfer_data.account), quantity, memo))
      .send();
    }

    #ifdef LINK_DEBUG  
      history_table histories(_self, _self.value);
      histories.emplace(_self, [&]( auto& a ){
        a.id = histories.available_primary_key();
        a.data = orig_data;
        a.msg = transfer_data;
        a.type = "incomingMessage";
      });
    #endif

    return orig_data;
  } 

  void receipt_received(const std::vector<char>& data) {
    // deserialize original message to get the quantity and original sender to refund
    token_settings_table settings_singleton(_self, _self.value);
    token_settings_t settings = settings_singleton.get_or_default();
    auto transfer_receipt = unpack(data);

    

    std::string memo = "LiquidApps LiquidLink Transfer Failed - Attempted to send to Ethereum account 0x";// + AddressToHex(transfer_receipt.address);
    asset quantity = asset(transfer_receipt.amount, settings.token_symbol);

    if (!transfer_receipt.success) {
      // return locked tokens in case of failure
      if (settings.can_issue) {
        action(permission_level{_self, "active"_n}, settings.token_contract, "issue"_n,
          std::make_tuple(name(transfer_receipt.account), quantity, memo))
        .send();
      } else {
        action(permission_level{_self, "active"_n}, settings.token_contract, "transfer"_n,
          std::make_tuple(_self, name(transfer_receipt.account), quantity, memo))
        .send();
      }

      #ifdef LINK_DEBUG 
        history_table histories(_self, _self.value);
        histories.emplace(_self, [&]( auto& a ){
          a.id = histories.available_primary_key();
          a.data = data;
          a.msg = transfer_receipt;
          a.type = "receiptFailure";
        });
      #endif
    } else {
      #ifdef LINK_DEBUG 
        //TODO: should we burn the tokens or send them to a "holding account"
        history_table histories(_self, _self.value);
        histories.emplace(_self, [&]( auto& a ){
          a.id = histories.available_primary_key();
          a.data = data;
          a.msg = transfer_receipt;
          a.type = "receiptSuccess";
        });
      #endif  
    }
  }

};//closure for CONTRACT_START
EOSIO_DISPATCH_SVC_TRX(CONTRACT_NAME(), (init)(enable)(getdest))