# Offers

There are two sides in offers: **buys** and **sells**. </br>
They can be seen in the **ORDER BOOK** column on [Switcheo Exchange](https://switcheo.exchange).


## Get Offers
 
 ```shell
 curl "https://api.switcheo.network/v2/offers?contract_hash=SWITCHEO_CONTRACT_HASH&pair=SWTH_NEO"
 ```
 
 > The above command returns JSON structured like this:
 
 ```json
 [
  {
    "blockchain":"neo",
    "block_number":2321609,
    "transaction_hash":"e645d9e031f336cbc1655c12da7b0396a5a205e3942053192744258f60a9dcba",
    "contract_hash":"01bafeeafe62e651efc3a530fde170cf2f7b09bd",
    "event_time":"2018-05-28T05:49:25.000Z",
    "address":"ac20179d08326a736c08fa40242dd4e70999f492",
    "offer_hash":"e9dc69e0ce63491c36e804eb3cd8ccf2a550415b6e3fabd6881322cd7cb118a7",
    "offer_asset_id":"ab38352559b8b203bde5fddfa0b07d8b2525e132",
    "want_asset_id":"c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
    "available_amount":1561904761905,
    "offer_amount":1561904761905,
    "want_amount":984000000,
    "created_at":"2018-05-28T05:50:09.039Z",
    "updated_at":"2018-05-28T05:50:09.426Z"
  }
 ]
 ```
 
 This endpoint gets the offer book (limited to 30 offers per side).
 
 ### HTTP Request
 
 `https://api.switcheo.network/v2/offers`
 
 ### URL Parameters
 
Parameter | Description
--------- | -----------
  blockchain | Only returns offers from this blockchain `(eg. neo)`
  contract_hash | Only return offers for this contract hash `(Switcheo)`
  pair | Only returns offers from this pair `(eg. SWTH_NEO)`
