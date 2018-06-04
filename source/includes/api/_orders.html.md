# Orders

* An order is an instruction to buy or sell on a [currency pair](#currency_pairs).
* Orders can comprise of **one** [make](#makes) and/or **multiple** [fill](#fills) transactions on [Switcheo Exchange](https://switcheo.exchange).
* They can only be created if the order maker's wallet balance and/or contract balance has sufficient funds.
* Orders are only persisted on the Blockchain after they are [broadcast](#broadcast-orders). 
* Orders that are not [broadcast](#broadcast-orders) will **expire** after **30 minutes**. 

## Statuses

Represents the state of orders on the [Switcheo Exchange](https://switcheo.exchange).

Status | Description
--------- | -----------
pending | Order has been prepared and is awaiting the user's confirmation.
confirming | Order has been broadcast is being persisted on the blockchain.
confirmed | Order is persisted on the blockchain.
failed | Order has failed to confirm and is not persisted on the blockchain. 
completed | Order has successfully completed.
processed | Order has completed but some part(s) may have been cancelled or failed.
cancelled | [Make](#makes) (only) of the order has been cancelled.

## Get orders

```shell
curl "https://api.switcheo.network/v2/orders?address=PUBLIC_ADDRESS"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": "c415f943-bea8-4dbf-82e3-8460c559d8b7",
    "blockchain": "neo",
    "contract_hash": "c41d8b0c30252ce7e8b6d95e9ce13fdd68d2a5a8",
    "address": "20abeefe84e4059f6681bf96d5dcb5ddeffcc377",
    "side": "buy",
    "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
    "want_asset_id": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
    "offer_amount": "100000000",
    "want_amount": "20000000",
    "transfer_amount": "0",
    "priority_gas_amount": "0",
    "use_native_token": false,
    "native_fee_transfer_amount": 0,
    "deposit_txn": null,
    "created_at": "2018-05-15T10:54:20.054Z",
    "status": "processed",
    "fills": [],
    "makes": [
      {
        "id": "c498527c-07c1-4c4c-b58f-a45fc2836d84",
        "offer_hash": "9b4ed49835383dd6e5e47305579b6d6c4f36c88ca9edfe92ebe55b93f684e35d",
        "available_amount": "0.0",
        "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
        "offer_amount": "100000000",
        "want_asset_id": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
        "want_amount": "20000000",
        "filled_amount": "100000000",
        "txn": null,
        "cancel_txn": null,
        "price": "5.0",
        "status": "success",
        "created_at": "2018-05-15T10:54:20.059Z",
        "transaction_hash": "bed7147ce3027c2b70251ef365d2d524f480be3284dc0239e4ddc248cbbf68b5",
        "trades": [
          {
          "id": "47ea819e-db34-4dad-8dde-45f776867ec7",
          "status": "success",
          "want_amount": "15970480",
          "filled_amount": "3194096",
          "price": "5.0",
          "created_at": "2018-05-17T05:14:55.828Z"
          }
        ]
      }
    ]
  }
]
```

This endpoint retrieves orders from a specific address filtered by the params provided.

### HTTP Request

`https://api.switcheo.network/v2/orders`

### Url parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
address | yes | Only return orders from this address `(wallet address of user)`.
contract_hash | no | Only return orders with this contract hash `(Switcheo)`.
trade_asset_id | no  | Only returns orders with this asset_id.
base_asset_id | no  | Only returns orders with this asset_id.

## Create an order

```shell
curl -d 
{
  blockchain: "neo", 
  contract_hash: "c11c3fa32f9def4159cfdb0b2bb657406b7579b4",
  offer_amount: "100000000",
  offer_asset: "NEO",
  price: "1"
  public_key: "023100f3245da41ee962c560aeaedf2cc1eddbaca45d3a066992487a7bf8c0822f"
  side: "buy"
  signature: "7fde6119bee2a3dd96f0c997127601851856b107c3524db278ea7126f086eeed1649e83b6d61bb82111f675af5bf61409ca65050359916a2d3f5a81e7dc8377d"
  use_native_tokens: false
  want_asset: "GAS"
  want_decimals: 8
 } -X POST "https://api.switcheo.network/v2/
```

> The above command returns JSON structured like this:

```json
{ 
  "id":"474940c6-2be4-43a8-aa71-0f9b2bc8908c",
  "blockchain":"neo",
  "contract_hash":"06118464b88a1049f38abac013347ca9039fb8b0",
  "address":"20abeefe84e4059f6681bf96d5dcb5ddeffcc377",
  "side":"sell",
  "offer_asset_id":"602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
  "want_asset_id":"c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "offer_amount":"100000",
  "want_amount":"143253",
  "transfer_amount":"0",
  "priority_gas_amount":"0",
  "use_native_token":false,
  "native_fee_transfer_amount":0,
  "deposit_txn":null,
  "created_at":"2018-05-23T03:20:19.481Z",
  "status":"pending",
  "fills":[
  {
    "id":"fe9f8d09-aeb6-43cd-9028-5a22ba1f8015",
    "offer_hash":"2b440b036fb5538d617d7a98ecba3b44480e1e7c60ea19a67eb60d67e38c75ff",
    "offer_asset_id":"602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
    "want_asset_id":"c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
    "fill_amount":"100000",
    "want_amount":"143253",
    "filled_amount":"",
    "fee_asset_id":"c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
    "fee_amount":"214",
    "price":"1.4325345067412557",
    "txn":
      {
        "hash":"fadf3daf53ab829e0b87223cb04c3e569e5dbffe438aa117ab90b9d1570d31ce",
        "sha256":"0f981d64b406ac0b62c27fce121abf4175aa52d923a6ddef9994a18e9e4efafb",
        "invoke":
        {
          "scriptHash":"06118464b88a1049f38abac013347ca9039fb8b0",
          "operation":"fillOffer",
          "args":
            [
              "77c3fcefddb5dcd596bf81669f05e484feeeab20",
              "9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5e72d286979ee6cb1b7e65dfddfb2e384100b8d148e7758de42e4168b71792c60",
              "ff758ce3670db67ea619ea607c1e0e48443bbaec987a7d618d53b56f030b442b",
              143253,
              "9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5",
              214
            ]
         },
      "type":209,
      "version":1,
      "attributes":[{"usage":32,"data":"77c3fcefddb5dcd596bf81669f05e484feeeab20"}],"inputs":[{"prevHash":"44f184aab330393908c15349a7be3af38c9e3b0280248e34b875715ba656cdf9","prevIndex":16}],"outputs":[{"assetId":"602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7","scriptHash":"e707714512577b42f9a011f8b870625429f93573","value":1e-08}],"scripts":[],"script":"08d600000000000000209b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc508952f02000000000020ff758ce3670db67ea619ea607c1e0e48443bbaec987a7d618d53b56f030b442b409b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5e72d286979ee6cb1b7e65dfddfb2e384100b8d148e7758de42e4168b71792c601477c3fcefddb5dcd596bf81669f05e484feeeab2056c10966696c6c4f6666657267b0b89f03a97c3413c0ba8af349108ab864841106","gas":0},"status":"pending","created_at":"2018-05-23T03:20:19.493Z","transaction_hash":"fadf3daf53ab829e0b87223cb04c3e569e5dbffe438aa117ab90b9d1570d31ce"}],"makes":[]}
```
    
This endpoint prepares an order, reserving required offers
    
### HTTP Request (POST)

`https://api.switcheo.network/v2/orders`
    
### Url parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
  blockchain | yes | The blockchain to execute the order on
  contract_hash | yes | The hash of the smart contract to execute order on
  address | yes | The order maker's address # TODO: derive this?
  side | yes | The side of this trade TODO: derive this?
  price | yes | The order price to 8 decimal places
  offer_asset | yes | The offered asset symbol
  offer_amount | yes | The offered amount of assets
  want_asset | yes | The wanted asset symbol
  want_decimals | yes | The number of decimals for the wanted asset
  use_native_tokens | yes | Whether to use SWTH as fees or not
  public_key | yes | The public key of the user in hex format
  signature | yes | The params signed with the address' private key
 
## Cancel create

```shell
curl "https://api.switcheo.network/v2/orders/ORDER_ID/create_cancel"
```

> The above command returns JSON structured like this:

```json
{
    "symbol": "SWTH_NEO",
    "price_change": "0.00006001",
    "percentage_price_change": "6.384",
    "last_price": "0.00100000",
    "last_quantity": "1.77051096",
    "bid_price": "0.00100000",
    "bid_quantity": "3098.92243065",
    "ask_price": "0.00102099",
    "ask_quantity": "26012.13923092",
    "high_price": "0.00103344",
    "low_price": "0.00088115",
    "open_price": "0.00095300",
    "volume": "6141.83147280",
    "quote_volume": "6615989.55286128",
    "open_time": 1526531482,
    "close_time": 1526617882,
    "count": 966
   }
```

This endpoint retrieves a specific ticker from the Switcheo Exchange.


### HTTP Request

`https://api.switcheo.network/v1/trades/tickers?pair=SWTH_NEO`

### URL Parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
  signature | yes | the order id signed with the address' private key 
 
## Broadcast orders
 
 ```shell
 curl "https://api.switcheo.network/v2/orders/id/create_cancel"
 ```
 
 > The above command returns JSON structured like this:
 
 ```json
 {
     "symbol": "SWTH_NEO",
     "price_change": "0.00006001",
     "percentage_price_change": "6.384",
     "last_price": "0.00100000",
     "last_quantity": "1.77051096",
     "bid_price": "0.00100000",
     "bid_quantity": "3098.92243065",
     "ask_price": "0.00102099",
     "ask_quantity": "26012.13923092",
     "high_price": "0.00103344",
     "low_price": "0.00088115",
     "open_price": "0.00095300",
     "volume": "6141.83147280",
     "quote_volume": "6615989.55286128",
     "open_time": 1526531482,
     "close_time": 1526617882,
     "count": 966
    }
 ```
 
 This endpoint broadcasts a created order.
 
 
### HTTP Request
 
 `https://api.switcheo.network/v1/trades/tickers?pair=SWTH_NEO`
 
### URL Parameters
 
Parameter | Mandatory | Description
--------- | ----------- | -----------
pair | yes | The market pair to retrieve
  
## Cancel broadcast

```shell
curl "https://api.switcheo.network/v1/trades/tickers/SWTH_NEO"
```

> The above command returns JSON structured like this:

```json
{
    "symbol": "SWTH_NEO",
    "price_change": "0.00006001",
    "percentage_price_change": "6.384",
    "last_price": "0.00100000",
    "last_quantity": "1.77051096",
    "bid_price": "0.00100000",
    "bid_quantity": "3098.92243065",
    "ask_price": "0.00102099",
    "ask_quantity": "26012.13923092",
    "high_price": "0.00103344",
    "low_price": "0.00088115",
    "open_price": "0.00095300",
    "volume": "6141.83147280",
    "quote_volume": "6615989.55286128",
    "open_time": 1526531482,
    "close_time": 1526617882,
    "count": 966
   }
```

This endpoint retrieves a specific ticker from the Switcheo Exchange.


### HTTP Request

`https://api.switcheo.network/v1/trades/tickers?pair=SWTH_NEO`

### URL Parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
  signature | yes | the additional signature to attach
