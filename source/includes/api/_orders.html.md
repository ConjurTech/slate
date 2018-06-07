# Orders

An order is an instruction to buy or sell on a [currency pair](#currency_pairs). <br/>
Orders can only be created if the order maker's contract balance has sufficient funds.

Order instructions consist of two steps:

1. Create instruction
2. Broadcast instruction

### The order object

> Order example:

```json
{
  "id": "be62c616-9185-4523-a630-caf71e91cd90",
  "blockchain": "neo",
  "contract_hash": "dec966baae02856d4ea183969f80eba7e7199b6d",
  "address": "f990c80f9b29de244f61a79b428977fee8d63b12",
  "side": "sell",
  "offer_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
  "want_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "offer_amount": "45773785950",
  "want_amount": "1941723",
  "transfer_amount": "0",
  "priority_gas_amount": "0",
  "use_native_token": false,
  "native_fee_transfer_amount": 0,
  "deposit_txn": null,
  "created_at": "2018-06-05T10:07:35.051Z",
  "status": "processed",
  "fills": [],
  "makes": []
},
```

Look to the right for an example of an order

Params | Description
--------- | -----------
id | Order id
blockchain | Name of blockchain eg. "neo"
contract_hash | Switcheo Contract Hash
address | Order maker's public address
side | "buy" or "sell"
offer_asset_id | Hash ID of offer asset TODO: endian
want_asset_id | Hash ID of want asset TODO: endian
offer_amount | Amount offered
want_amount | Amount wanted
transfer_amount | Amount of offered assets that needs to be transferred to contract
priority_gas_amount | Amount of gas to pay for priority
use_native_token | Use Switcheo tokens for paying fees
native_fee_transfer_amount | Amount of Switcheo tokens transferred to contract for fees
deposit_txn | TODO: Find out what is this
created_at | Order created time
status | [Status](#Order Statuses) of order
fills | [Fills](#fills) of order
makes | [Makes](#makes) of order


### Order Statuses

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

> Example response:

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
    "makes": []
  }
]
```

This endpoint retrieves orders from a specific address filtered by the params provided.

### HTTP Request

`https://api.switcheo.network/v2/orders`

### Url parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
address | yes | Only return orders from this `user` address.
contract_hash | no | Only return orders with this `Switcheo` contract hash.
trade_asset_id | no  | Only returns orders with this asset_id.
base_asset_id | no  | Only returns orders with this asset_id.

## Create an order

> Message hash example (For signature):


```
{
  "blockchain": "neo",
  "contractHash": "SwitcheoContractHash",
  "address": "OrderMakerPublicAddress",
  "side": "buy",
  "price": """,
  "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "offer_amount": "100000000",
  "want_asset_id": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
  "wantDecimals": 8,
  "useNativeTokens": false,
}
```

This endpoint prepares an order.

###Generating a signature:

* As Switcheo is a dex, we need to sign as a form of authentication ([Click here for more information](#signatures))
* The signature(s) must be provided in the url parameters.
* Please look to the right for an example of the message hash

<aside class="notice">
 While signing, make sure that the keys of the message hash are in the same order as our example. 
</aside>

> TODO: example request
> Example Response:

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
  "fills":[],
  "makes":[]
}
```

###After receiving the response:

* Creating an order is a two step process.
* First, you will have to create the order.
* After creating the order, you will receive a transaction as the response.
* This transaction needs to be signed and broadcast for it to persist in the blockchain.

([Click here for next step](#broadcast-an-order))
    
### HTTP Request (POST)

`https://api.switcheo.network/v2/orders`
    
### Url parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
  blockchain | yes | The blockchain to execute the order on
  contract_hash | yes | The hash of the smart contract to execute order on
  address | yes | The order maker's address
  side | yes | The side of this trade
  price | yes | The order price to 8 decimal places
  offer_asset | yes | The offered asset symbol
  offer_amount | yes | The offered amount of assets
  want_asset | yes | The wanted asset symbol
  want_decimals | yes | The number of decimals for the wanted asset
  use_native_tokens | yes | Whether to use SWTH as fees or not
  public_key | yes | The public key of the user in hex format
  signature | yes | Signed with the address's private key
 
## Broadcast an order

> Message hash example (For signature):


```
{
    fills:
      {
        "FILL_ID": "FILL_SIGNATURE", ... 
      },
    makes: 
      {
        "MAKE_ID": "MAKE_SIGNATURE", ...
      }
}
```

This endpoint broadcasts a created order. <br/>
After using the create order endpoint, you will receive a transaction as the response to be broadcast. <br/>
<aside class="notice">
  Every make and fill contained in the transaction needs to be signed.
</aside>

###Generating a signature:

* As Switcheo is a dex, we need to sign as a form of authentication ([Click here for more information](#signatures))
* The signature(s) must be provided in the url parameters.
* Please look to the right for an example of the message hash

<aside class="notice">
 While signing, make sure that the keys of the message hash are in the same order as our example. 
</aside>
 
 ```shell
 curl "https://api.switcheo.network/v2/orders/id/broadcast"
 ```
 
 > Example response:
 
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
  "fills":[],
  "makes":[]
}
 ```
 
### HTTP Request
 
`https://api.switcheo.network/v2/orders/id/broadcast`
 
### URL Parameters
 
Parameter | Mandatory | Description
--------- | ----------- | -----------
  signature | yes | Signed with the address's private key
  public_key | yes | The public key of the user in hex format

## Cancel an order

> Message hash example (For signature):


```
TODO: Find out message hash format
"hash_to_sign":"c9684604e5b6963499ae8a4abfe6c8e7657648f8a1ed8e7528d4ba9d64e41638"
```

This endpoint prepares the cancellation of an order that has been [broadcast](#broadcast-an-order).

###Generating a signature:

* As Switcheo is a DEX, we need to sign as a form of authentication ([Click here for more information](#signatures))
* The signature(s) must be provided in the url parameters.
* Please look to the right for an example of the message hash\

<aside class="notice">
 While signing, make sure that the keys of the message hash are in the same order as our example. 
</aside>

```shell
curl "https://api.switcheo.network/v2/orders/ORDER_ID/create_cancel"
```

> Example response:

```json
{ "id": "cancel-id",
  "transaction": "cancel_txn",
  "hash_to_sign": "hash_to_sign",
  "script_params": "script_params",
}
```

### After receiving the response:

* Cancelling an order is a two step process.

* First, you will have to create the cancellation.

* After cancelling the order, you will receive a transaction as the response.

* This transaction needs to be signed and broadcast for it to persist in the blockchain.

([Click here for next step](#broadcast-a-cancellation))


### HTTP Request

`https://api.switcheo.network/v2/cancellations`

### URL Parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
  order_id | yes |  the order id
  signature | yes | Signed with the order maker's private key 
  
## Broadcast a cancellation

```shell
curl "https://api.switcheo.network/v2/cancellations/:id/broadcast"
```

> Example response:

```json
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
  "makes": []
}
```

This endpoint broadcasts a cancellation.

###Generating a signature:

* As Switcheo is a dex, we need to sign as a form of authentication ([Click here for more information](#signatures))
* The signature(s) must be provided in the url parameters.
* Please look to the right for an example of the message hash\

TODO: Find out message hash format
"hash_to_sign":"c9684604e5b6963499ae8a4abfe6c8e7657648f8a1ed8e7528d4ba9d64e41638"

<aside class="notice">
 While signing, make sure that the keys of the message hash are in the same order as our example. 
</aside>

### HTTP Request

`https://api.switcheo.network/v2/cancellations/:id/broadcast`

### URL Parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
  signature | yes | the additional signature to attach
