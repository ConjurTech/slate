# Orders

## Get orders

<aside class="notice">
address and contract_hash parameters are required for this API call!
</aside>

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

Parameter | Description
--------- | -----------
address | only return orders from this address
contract_hash | only return orders with this contract hash
trade_asset_id | only returns orders with this asset_id
base_asset_id | only returns orders with this asset_id

## Create orders

```shell
curl -d "https://api.switcheo.network/v2/
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
    
This endpoint prepares an order, reserving required offers
    
### HTTP Request
    
`https://api.switcheo.network/v1/orders`
    
### Url parameters

Parameter | Description
--------- | -----------
 blockchain | the blockchain to execute the order on
 contract_hash | the hash of the smart contract to execute order on
 address | the order maker's address
 price | the order price to 8 decimal places
 side | the side of this trade
 offer_asset | the offered asset symbol
 offer_amount | the offered amount of assets
 want_asset | the wanted asset symbol
 public_key | the public key of the user in hex format
 signature | the params signed with the address' private key
 
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
 
 Parameter | Description
 --------- | -----------
   pair | The market pair to retrieve

## Create order cancellation

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

Parameter | Description
--------- | -----------
  signature | the order id signed with the address' private key
  
## Broadcast order cancellation

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

Parameter | Description
--------- | -----------
  signature | the additional signature to attach
