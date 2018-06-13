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

 Parameter      | Type                  | Description
--------------- | --------------------- | -----------
 address        | **string**            | Order maker's wallet address. Only returns orders from this address.
 contract_hash  | **string** (optional) | Switcheo [contract hash](#contract-hash). Only returns orders from this contract hash.
 trade_asset_id | **string** (optional) | Hash of an asset. Only returns orders with this trade asset.
 base_asset_id  | **string** (optional) | Hash of an asset. Only returns orders with this base asset.

## Create an order

> Example of message to sign:

```
{
  "blockchain": "neo",
  "contract_hash": "add0fccaaa65a5d2835012a96e73a443bc8343ef",
  "address": "ede2491ec91f3beb24778572c97b1c1dd6495df8",
  "pair": "SWTH_NEO",
  "side": "buy",
  "price": "0.41234200",
  "offer_amount": "100000000",
  "use_native_tokens": false,
}
```

This is the first api call required to create an order.
  Orders can only be created after sufficient funds have been [deposited](#deposits) into the order maker's contract balance.

A [signature](#authentication) has to be provided for this api call. An example of the message required to be signed 
  can be seen on the right.
  
<aside class="notice">
  Note: After calling this endpoint, do remember to call the second api (broadcast order) for the order to be created. 
</aside>

> Example Request:

```shell
curl https://test-api.switcheo.network/v2/orders \ 
  -d blockchain=neo \
  -d contract_hash=9c9d2fac35987621e252981e06762895b09eb035 \
  -d address=1b7bc3c02fd9503d4896b24729513430162799d4 \
  -d pair=SWTH_NEO \
  -d side=buy \
  -d price=0.44999997 \
  -d offer_asset=NEO \
  -d offer_amount=44999997 \
  -d use_native_tokens=false \
  -d timestamp=1528879294321 \
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

 Parameter         | Type        | Description
------------------ | ------------| -----------
 blockchain        | **string**  | Blockchain (in lowercase) that the offer is on. Possible values are: `neo`
 contract_hash     | **string**  | Switcheo [contract hash](#contract-hash) to execute the order on.
 address           | **string**  | Hash of the order maker's wallet public address.
 pair              | **string**  | Pair to trade, e.g. `RPX_NEO` 
 side              | **string**  | Possible values are: `buy`, `sell`
 price             | **string**  | Order price to 8 decimal places
 offer_amount      | **string**  | Number of assets offered in the order.
 use_native_tokens | **boolean** | `true` if SWTH is used as fees. `false` if SWTH is not used for fees.
 timestamp         | **int**     | Current timestamp (epoch milliseconds)
 public_key        | **string**  | Public key of the order maker in hex format
 signature         | **string**  | Message hash signed with order maker's private key.
 
## Broadcast an order

> 1.Example response from first api call:

```json
{
	"id": "8d2cce86-98b3-49a0-b3e7-3660b2073458",
	"blockchain": "neo",
	"contract_hash": "bdfab1bf3f214dc433a6d08c2202471ed220ae24",
	"address": "ede2491ec91f3beb24778572c97b1c1dd6495df8",
	"side": "buy",
	"offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
	"want_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
	"offer_amount": "15000000",
	"want_amount": "500000000",
	"transfer_amount": "0",
	"priority_gas_amount": "0",
	"use_native_token": false,
	"native_fee_transfer_amount": 0,
	"deposit_txn": null,
	"created_at": "2018-06-13T05:30:21.640Z",
	"status": "pending",
	"fills": [],
	"makes": [
		{
			"id": "b43aee10-d523-4804-9814-7f7e8c53acb0",
			"offer_hash": null,
			"available_amount": null,
			"offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
			"offer_amount": "15000000",
			"want_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
			"want_amount": "500000000",
			"filled_amount": null,
			"txn": {
				"offerHash": "3eda0632d6713dd3aa8e8512ab73c2e9e59151b04916a5350023629e913e36a7",
				"hash": "ffe681b91911ec1217190c89899371abdabf73bf2be4eda8e1c3e3c8d202a038",
				"sha256": "c0356803fd3ce5bb16fab7130d0baeb000eaed125edb4b9d10687e75306d30a0",
				"invoke": {
					"scriptHash": "bdfab1bf3f214dc433a6d08c2202471ed220ae24",
					"operation": "makeOffer",
					"args": [
						"f85d49d61d1c7bc972857724eb3b1fc91e49e2ed",
						"9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5",
						15000000,
						"32e125258b7db0a0dffde5bd03b2b859253538ab",
						500000000,
						"62343361656531302d643532332d343830342d393831342d376637653863353361636230"
					]
				},
				"type": 209,
				"version": 1,
				"attributes": [
					{
						"usage": 32,
						"data": "f85d49d61d1c7bc972857724eb3b1fc91e49e2ed"
					}
				],
				"inputs": [
					{
						"prevHash": "be3b0c15e495e8d051efa528de06a24c69cecda5cd1a8f98a9af2af877988a60",
						"prevIndex": 13
					}
				],
				"outputs": [
					{
						"assetId": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
						"scriptHash": "e707714512577b42f9a011f8b870625429f93573",
						"value": 1e-8
					}
				],
				"scripts": [],
				"script": "2462343361656531302d643532332d343830342d393831342d376637653863353361636230080065cd1d000000001432e125258b7db0a0dffde5bd03b2b859253538ab08c0e1e40000000000209b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc514f85d49d61d1c7bc972857724eb3b1fc91e49e2ed56c1096d616b654f666665726724ae20d21e4702228cd0a633c44d213fbfb1fabd",
				"gas": 0
			},
			"cancel_txn": null,
			"price": "0.03",
			"status": "pending",
			"created_at": "2018-06-13T05:30:21.653Z",
			"transaction_hash": "ffe681b91911ec1217190c89899371abdabf73bf2be4eda8e1c3e3c8d202a038",
			"trades": []
		}
	]
}
```

> 2.Sign make from transaction:

```json
{
  "offerHash": "3eda0632d6713dd3aa8e8512ab73c2e9e59151b04916a5350023629e913e36a7",
  "hash": "ffe681b91911ec1217190c89899371abdabf73bf2be4eda8e1c3e3c8d202a038",
  "sha256": "c0356803fd3ce5bb16fab7130d0baeb000eaed125edb4b9d10687e75306d30a0",
  "invoke": {
    "scriptHash": "bdfab1bf3f214dc433a6d08c2202471ed220ae24",
    "operation": "makeOffer",
    "args": [
      "f85d49d61d1c7bc972857724eb3b1fc91e49e2ed",
      "9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5",
      15000000,
      "32e125258b7db0a0dffde5bd03b2b859253538ab",
      500000000,
      "62343361656531302d643532332d343830342d393831342d376637653863353361636230"
    ]
  },
  "type": 209,
  "version": 1,
  "attributes": [
    {
      "usage": 32,
      "data": "f85d49d61d1c7bc972857724eb3b1fc91e49e2ed"
    }
  ],
  "inputs": [
    {
      "prevHash": "be3b0c15e495e8d051efa528de06a24c69cecda5cd1a8f98a9af2af877988a60",
      "prevIndex": 13
    }
  ],
  "outputs": [
    {
      "assetId": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
      "scriptHash": "e707714512577b42f9a011f8b870625429f93573",
      "value": 1e-8
    }
  ],
  "scripts": [],
  "script": "2462343361656531302d643532332d343830342d393831342d376637653863353361636230080065cd1d000000001432e125258b7db0a0dffde5bd03b2b859253538ab08c0e1e40000000000209b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc514f85d49d61d1c7bc972857724eb3b1fc91e49e2ed56c1096d616b654f666665726724ae20d21e4702228cd0a633c44d213fbfb1fabd",
  "gas": 0
}
```


> 3.Put signature and make id in this format for signature url parameter:

```
{
    fills: {},
    makes: 
      {
        "b43aee10-d523-4804-9814-7f7e8c53acb0": "a294da6f9e5095190194532363051145f538cf2809b874c736e2dc5ca1584e9a848c849dc44077389ddcee5678f7e37ac3602cc69f030453f8c466c96aa2e8c6"
      }
}
```

This is the second api call needed to create an order.
  After using the create order endpoint, you will receive a transaction as the response to be broadcast.

Every [fill](#fills) and [make](#makes) in the response from the first api call has to be [signed](#authentication). 

Looking at the example on the right:
   
1. A response is received from calling the [create order](#create-an-order) endpoint.
2. `fills` returns an empty array, so lets look at `makes`. The message we have to sign will be the value returned by the `txn` key.
3. After signing the make, we will have to include the make id and signature in an object:
 
 `{ makes: { id: <signature> }, fills: { id: <signature> } }`
 
  and use it for the `signature` url parameter.
  
> Example request:
 
 ```shell
 curl https://api.switcheo.network/v2/orders/id/broadcast \
   -d '{"public_key":"034d2ad7cc8a2598dd341271920fd78ea98209cd082aae6a1ef10d51a3b254d822","signatures":{"fills":{},"makes":{"48c908fb-95a6-4646-9484-d01ea509f6cc":"3eab5444213a78d9450505da829ba533071d53e020b9beb266a85032f63f3b7331bb21d2df820e59738534462fc02a4b7cc1bd689918870bcbd7b1fadc1f3aca"}}}' 
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
 
Parameter | Type | Description
--------- | ----------- | -----------
  signature | **string** | The signatures in this format: `{ makes: { id: <signature> }, fills: { id: <signature> } }`
  public_key | **string** | Public key of the order maker in hex format

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

Parameter | Type | Description
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

Parameter | Type | Description
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
