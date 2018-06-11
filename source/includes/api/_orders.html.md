# Orders

## Description

Orders are instructions to buy or sell assets on Switcheo Exchange.

At the moment, only Limit orders are available. Market, Fill-Or-Cancel, Make-Or-Cancel, etc. strategies are not available yet.

Orders will therefore contain a combination of zero or one [make](#makes) and/or zero or more [fills](#fills).

Once an order is placed, the funds required for the order is removed from the user's balance
 and placed on hold until the order is filled or the order is cancelled.

### Overview

To perform any action, **two** API calls are required. This defers from a traditional exchange API,
 as the order must be co-signed by our off-chain service, and then broadcasted to the appropriate blockchain.
 
The **first** API call creates an appropriate blockchain transaction (e.g. [create order](#create-an-order)), which will 
  be returned in the response.

This transaction must then be signed in the specific way as required as by the blockchain; The signature should then
  be returned as the payload in the **second** API call (e.g. [broadcast order](#broadcast-an-order)).
  
As mentioned above, the message to be signed in the second step of an action is simply the serialized 
  blockchain transaction itself. 
  
As there is no transaction to be signed in the first step of an action, in general, the message 
  to be signed in the first step of an action is the request parameters as an ordered JSON **string**.  

For additional security, care should be taken to verify that the transaction returned from the API matches that of the
 requested order. An example of validating an order transaction can be found here:
 
 TODO: finish this.
 
 NEO example:
   first step (message prefix, sign)
  
 NEO example:
   second step (serialize txn, sign)

## Structure

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

 Params                     | Description
--------------------------- | -----------
 id                         | **string** containing the order id.
 blockchain                 | **string** containing the name of a blockchain in lowercase. eg. "neo".
 contract_hash              | **string** containing a Switcheo [contract hash](#contract_hash).
 address                    | **string** containing a hash of the order maker's wallet public address.
 side                       | "buy" or "sell" **string**.
 offer_asset_id             | **string** containing the hash of the asset offered in the order.
 want_asset_id              | **string** containing the hash of the asset wanted in the order.
 offer_amount               | **string** containing the number of assets offered in the order.
 want_amount                | **string** containing the number of assets wanted in the order.
 transfer_amount            | **string** containing the number of offered assets that needs to be transferred to contract
 priority_gas_amount        | **string** containing the number of amount of gas to pay for priority
 use_native_token           | **boolean** `true` if you are using Switcheo tokens to pay fees
 native_fee_transfer_amount | **string** containing amount of Switcheo tokens transferred to contract for fees TODO: why do i see a number
 deposit_txn                | TODO: This is V1? Remove if it is.
 created_at                 | **string** containing the time when order is created.
 status                     | **string** containing the [status](#orderstatuses) of order
 fills                      | **array** containing the [Fills](#fills) of order
 makes                      | **array** containing the [Makes](#makes) of order

## List orders

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

 Parameter      | Mandatory | Description
--------------- | --------- | -----------
 address        | yes       | A **string** containing a wallet address. Only returns orders from this address.
 contract_hash  | no        | A **string** containing a Switcheo [contract hash](#contract-hash). Only returns orders from this contract hash.
 trade_asset_id | no        | A **string** containing the hash of a trade asset. Only returns orders with this trade_asset_id.
 base_asset_id  | no        | A **string** containing the hash of a base asset. Only returns orders with this base_asset_id.

## Create an order

> Example of message to sign:

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

This is the first api call required to create an order.
  Orders can only be created after sufficient funds have been [deposited](#deposits) into the order maker's contract balance.

A [signature](#authentication) has to be provided for this api call. An example of the message required to be signed 
  can be seen on the right.
  
<aside class="notice">
  Note: After calling this endpoint, remember to do the second api call (broadcast order) for the order to be created. 
</aside>

> Example Request:

```shell
curl https://test-api.switcheo.network/v2/orders \ 
  -d blockchain=neo \
  -d contract_hash=9c9d2fac35987621e252981e06762895b09eb035 \
  -d address=1b7bc3c02fd9503d4896b24729513430162799d4 \
  -d side=buy \
  -d price=0.44999997 \
  -d offer_asset=NEO \
  -d offer_amount=44999997 \
  -d want_asset=SWTH \
  -d want_decimals=8 \
  -d use_native_tokens=false \
  -d public_key=03dba309c4493d6fd2215b94f2abd1f8b5758361bf9eb0332ec8c0193884953955 \
  -d signature=986961707a860eec03fecdba596fb171d64fe8d0c66277d19a32965c51d88abfc1b55c67f7bff0c95df20aa82b849b5e1c60a6d645a55ee466d594ee8da0b902
```

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
    
### HTTP Request (POST)

`https://api.switcheo.network/v2/orders`
    
### Url parameters

 Parameter         | Mandatory | Description
------------------ | --------- | -----------
 blockchain        | yes       | **string** containing the name of a blockchain in lowercase. eg. "neo".
 contract_hash     | yes       | **string** containing a Switcheo [contract hash](#contract-hash) to execute the order on.
 address           | yes       | **string** containing a hash of the order maker's wallet public address.
 side              | yes       | "buy" or "sell" **string**.
 price             | yes       | **string** containing the order price to 8 decimal places
 offer_asset       | yes       | **string** containing the hash of the asset offered in the order.
 offer_amount      | yes       | **string** containing the number of assets offered in the order.
 want_asset        | yes       | **string** containing the hash of the asset wanted in the order.
 want_decimals     | yes       | **string** containing the number of decimals for the wanted asset.
 use_native_tokens | yes       | **boolean** `true` if using SWTH as fees.
 public_key        | yes       | **string** containing the public key of the order maker in hex format
 signature         | yes       | **string** containing the message hash signed with order maker's private key
 
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

###Message to sign
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

This endpoint prepares the cancellation of an order that has been [broadcast](#broadcast-an-order). <br/>
Only orders that have 

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

### HTTP Request

`https://api.switcheo.network/v2/cancellations/:id/broadcast`

### URL Parameters

Parameter | Mandatory | Description
--------- | ----------- | -----------
  signature | yes | the additional signature to attach


## Order Statuses

(TODO: confirm properly)

Represents the state of orders on Switcheo.

Status | Description
--------- | ----------
open | Order is waiting to be filled
failed | Order has failed to confirm and is not persisted on the blockchain.
cancelled | [Make](#makes) (only) of the order has been cancelled.
processed | Order has completed but some part(s) may have been cancelled or failed.
complete | Order has successfully completed.
