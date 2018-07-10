# Orders

**Description**

Orders are instructions to buy or sell assets on Switcheo Exchange.

At the moment, only Limit orders are available. Market, Fill-Or-Cancel, Make-Or-Cancel, etc. strategies are not available yet.

As such, orders will contain a combination of zero or one make and/or zero or more fills.

Once an order is placed, the funds required for the order is removed from the user's balance
 and placed on hold until the order is filled or the order is cancelled.

**Overview**

To perform any action, **two** API calls are required. This defers from a traditional exchange API,
 as the order must be co-signed by our off-chain service, and then broadcasted to the appropriate blockchain.

The **first** API call creates an appropriate blockchain transaction (e.g. create order), which will
  be returned in the response.

This transaction must then be signed in the specific way as required by the blockchain. The signature should then
  be returned as the payload in the **second** API call (e.g. broadcast order).

As mentioned above, the message to be signed in the second step of an action is simply the serialized
  blockchain transaction itself.

**Authentication**

The message to be signed in the first step of an action is the request parameters as an ordered JSON **string**.

For additional security, care should be taken to verify that the transaction returned from the API matches that of the
 requested order. An example of validating an order transaction can be found here:

For more details, please consult the [Authentication](#authentication) section.

## List Orders

> Example Request

```shell
curl "https://api.switcheo.network/v2/orders?pair=GAS_NEO&address=20abeefe84e4059f6681bf96d5dcb5ddeffcc377&contract_hash=c41d8b0c30252ce7e8b6d95e9ce13fdd68d2a5a8"
```

> Example Response

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

Retrieves orders from a specific address filtered by the given parameters.

### HTTP Request

`GET https://api.switcheo.network/v2/orders`

### Request Parameters

 Parameter      | Type                  | Description
--------------- | --------------------- | -----------
 address        | **string**            | Only returns orders made by this [address](#address).
 contract_hash  | **string** (optional) | Only returns orders from this [contract hash](#contract-hash).
 pair           | **string** (optional) | The pair to buy or sell on.

## Create Order

> Payload

```json
{
  "blockchain": "neo",
  "contract_hash": "add0fccaaa65a5d2835012a96e73a443bc8343ef",
  "address": "ede2491ec91f3beb24778572c97b1c1dd6495df8",
  "pair": "SWTH_NEO",
  "side": "buy",
  "price": "0.41234200",
  "want_amount": "100000000",
  "use_native_tokens": false
}
```

> Signature

```js
const messageToSign = "{\"address\":\"ede2491ec91f3beb24778572c97b1c1dd6495df8\",\"blockchain\":\"neo\",\"contract_hash\":\"add0fccaaa65a5d2835012a96e73a443bc8343ef\",\"pair\":\"SWTH_NEO\",\"price\":\"0.41234200\",\"side\":\"buy\",\"timestamp\":1529474651000,\"use_native_tokens\":false,\"want_amount\":\"100000000\",}"
sign(messageToSign) // see the Authentication section for an example of the `sign` method
// => 986961707a860eec03fe..
```

This endpoint creates an order which can be executed through [Broadcast Order](#broadcast-order).
  Orders can only be created after sufficient funds have been [deposited](#deposits) into the user's contract balance.
  A successful order will have zero or one make and/or zero or more fills.

A [signature](#authentication) of the request payload has to be provided for this API call.
  An example of the message required to be signed for a given payload can be seen on the right.

> Example Request

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
  -d public_key=03dba309c4493d6fd22.. \
  -d signature=986961707a860eec03fe..
```

> Example Response

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

<aside class="notice">
  Note: After calling this endpoint, the Broadcast Order endpoint has to be called for the order to be exeucted.
</aside>

### HTTP Request

`POST https://api.switcheo.network/v2/orders`

### Request Parameters

For the below descriptions, the `order maker` refers to your API user.

 Parameter         | Type        | Description
------------------ | ------------| -----------
 pair              | **string**  | Pair to trade, e.g. `RPX_NEO`.
 blockchain        | **string**  | Blockchain that the `pair` is on. Possible values are: `neo`.
 contract_hash     | **string**  | Switcheo Exchange [contract hash](#contract-hash) to execute the order on.
 address           | **string**  | Address of the order maker.
 side              | **string**  | Whether to buy or sell on this pair. Possible values are: `buy`, `sell`.
 price             | **string**  | Order price at 8 decimal places precision.
 offer_amount      | **string**  | [Amount](#amounts) of tokens offered in the order as an integer string.
 use_native_tokens | **boolean** | Whether to use SWTH as fees or not. Possible values are: `true` or `false`.
 timestamp         | **int**     | The current timestamp to be used as a nonce as epoch **milliseconds**.
 public_key        | **string**  | Public key of the order maker in hex format (big endian).
 signature         | **string**  | Signature of the request payload. See [Authentication](#authentication) for more details.

## Broadcast Order

> Example Order (NEO)

```json
{
  ...
  "fills": [],
  "makes": [
   {
     ...
     "txn":
     {
       "offerHash": "3eda0...",
       "hash": "ffe681b...",
       "sha256": "c0356803...", // Message digest for signature (neo)
       ...
     },
     ...
   }
  ]
}
```

> Example Request

 ```shell
 curl https://api.switcheo.network/v2/orders/id/broadcast \
   -d '{\"public_key\":\"034d2ad7cc8a2598dd341271920fd78ea98209cd082aae6a1ef10d51a3b254d822\", \
        "signatures":{\"fills\":{},\"makes\":{\"48c908fb-95a6-4646-9484-d01ea509f6cc\":\"3eab5444213a78d9450...\"}}}'
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

This is the second endpoint required to execute an order. After using the [Create Order](#create-order) endpoint,
  you will receive response which requires additional signatures. The method for signing depends on the blockchain
  the order is to be executed on.

##### NEO

Every `fill` and `make` in the Create Order response should be [signed](#authentication).

The signatures should than be put in an object with this format: `{ makes: { [<make_id>]: <signature> }, fills: { [<fill_id>]: <signature> } }`,
 and attached as the `signature` parameter in the request payload.

Consult the [Authentication](#authentication) section to understand how to [sign a NEO transaction](#sign-neo-txn).

Note that a `sha256` parameter is provided for convenience to be used directly as part of the ECDSA signature process.
 *In production mode, this should be recalculated for additional security.*

### HTTP Request

`POST https://api.switcheo.network/v2/orders/:id/broadcast`

### Request Parameters

 Parameter  | Type       | Description
 ---------- | ---------- | -----------
 signatures | **string** | Signed fills and makes in response from create order endpoint. Format: `{ makes: { [<make_id>]: <signature> }, fills: { [<fill_id>]: <signature> } }`
 public_key | **string** | Public key of the order maker in hex format (big endian).

## Create Cancellation

> Payload

```
{ order_id: "474940c6...", timestamp: 1529474651000 }
```

> Example Request

```shell
curl "https://api.switcheo.network/v2/cancellations"
  -d order_id=474940c6... \
  -d signature=986961707a860eec03fe... \
  -d public_key=03dba309c4493d6fd22.. \
  -d timestamp=1529474651000
```

> Example Response

```json
{
	"id": "fa764bc3...",
	"transaction": {
		"hash": "5b542708ee47...",
		"type": 209,
		"version": 1,
		"attributes": [
			{
				"usage": 32,
				"data": "f85d49d61d..."
			}
		],
		"inputs": [
			{
				"prevHash": "1d1f3a631...",
				"prevIndex": 0
			}
		],
		"outputs": [
			{
				"assetId": "602c79718b16e...",
				"scriptHash": "e707714512...",
				"value": 1e-8
			}
		],
		"scripts": [],
		"script": "20a7ce4ae512908ed4150...",
		"gas": 0
	},
	"script_params": {
		"scriptHash": "48756743d524af03aa7...",
		"operation": "cancelOffer",
		"args": [
			"9b7cffdaa674...",
			"a7ce4ae51290..."
		]
	}
}
```

This is the first api call required to cancel an order.
  Only orders with makes with **more than 0** `available_amount` are eligible for cancellation.

A [signature](#authentication) has to be provided for this API call. An example of the payload required to be signed
  can be seen on the right.

<aside class="notice">
  Note: After calling this endpoint, the Execute Cancellation endpoint has to be called for the cancellation to be executed.
</aside>

### HTTP Request

`POST https://api.switcheo.network/v2/cancellations`

### URL Parameters

 Parameter  | Type       | Description
----------- | ---------- | -----------
 order_id   | **string** | Order ID to cancel.
 timestamp  | **int**    | The current timestamp to be used as a nonce as epoch **milliseconds**.
 public_key | **string** | Public key of the order maker in hex format (big endian).
 signature  | **string** | Signature of the request payload. See [Authentication](#authentication) for more details.

## Execute Cancellation

> Example Request

```shell
curl "https://api.switcheo.network/v2/cancellations/:id/broadcast"
```

> Example Response

```json
{
	"id": "a8c5bba2...",
	"blockchain": "neo",
	"contract_hash": "48756743...",
	"address": "ede2491ec91...",
	"side": "buy",
	"offer_asset_id": "c56f33fc6ecfc...",
	"want_asset_id": "ab38352559...",
	"offer_amount": "100000000",
	"want_amount": "10000000000",
	"transfer_amount": "0",
	"priority_gas_amount": "0",
	"use_native_token": true,
	"native_fee_transfer_amount": 0,
	"deposit_txn": null,
	"created_at": "2018-06-19T07:44:38.894Z",
	"status": "processed",
	"fills": [],
	"makes": [
		{
			"id": "fa764bc3-1a6f...",
			"offer_hash": "f4912191f6033c96f...",
			"available_amount": "0",
			"offer_asset_id": "c56f33fc6ecfcd0c...",
			"offer_amount": "100000000",
			"want_asset_id": "ab3835255...",
			"want_amount": "10000000000",
			"filled_amount": "0",
			"txn": null,
			"cancel_txn": null,
			"price": "0.01",
			"status": "cancelling",
			"created_at": "2018-06-19T07:44:38.907Z",
			"transaction_hash": "9c6442e14...",
			"trades": []
		}
	]
}
```

This is the second endpoint that must be called to cancel an order.
  After calling the [Create Cancellation](#create-cancellation) endpoint, you will receive
  a message or transaction in the response which must be signed.

Consult the [Authentication](#authentication) section to understand how to sign the `transaction` (NEO) or `message_to_sign` (Ethereum).

Note that a `sha256` parameter is provided for convenience to be used directly as part of the ECDSA signature process.
 *In production mode, this should be recalculated for additional security.*

### HTTP Request

`POST https://api.switcheo.network/v2/cancellations/:id/broadcast`

### URL Parameters

 Parameter | Type       | Description
---------- | ---------- | -----------
 signature | **string** | Signature of the message or transaction required to execute the cancellation.
