# Orders

**Description**

Orders are instructions to buy or sell assets on Switcheo Exchange.

At the moment, only Limit orders are available. Market, Fill-Or-Cancel, Make-Or-Cancel, etc. strategies are not available yet.

As such, orders will contain a combination of zero or one **make** and/or zero or more **fills**.

Once an order is placed, the funds required for the order is removed from the user's balance
 and placed on hold until the order is filled or the order is cancelled.

## List Orders

> Example request

```js
{
  "address": "87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f",
  "contract_hash": "<contract hash>"
}
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
    "fills": [...],
    "makes": [...]
  }
]
```

Retrieves orders from a specific address filtered by the given parameters.

### HTTP Request

`GET /v2/orders`

### Request Parameters

 Parameter      | Type       | Required | Description
--------------- | ---------- | -------- | -------------
 address        | **string** | yes       | Only returns orders made by this [address](#address).
 pair           | **string** | no      | The pair to buy or sell on.
 contract_hash  | **string** | yes       | Only returns orders from this [contract hash](#contract-hash).

### Example

[Full list orders example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/listOrdersExample.js)


## Create Order

This endpoint creates an order which can be executed through [Broadcast Order](#broadcast-order).
Orders can only be created after sufficient funds have been [deposited](#deposits) into the user's contract balance.
A successful order will have zero or one **make** and/or zero or more **fills**.

<aside class="notice">
  IMPORTANT: After calling this endpoint, the Broadcast Order endpoint has to be called for the order to be executed.
</aside>

### HTTP Request

`POST /v2/orders`

### Request Parameters

For the below descriptions, the `order maker` refers to your API user.

> Create an order

```js
function createOrder({ pair, blockchain, side, price,
                       wantAmount, useNativeTokens, orderType,
                       privateKey, address }) {
  const signableParams = { pair, blockchain, side, price, wantAmount,
                           useNativeTokens, orderType, timestamp: getTimestamp(),
                           contractHash: CONTRACT_HASH }

  const signature = signParams(signableParams, privateKey)
  const apiParams = { ...signableParams, address, signature }
  return api.post(API_URL + '/orders', apiParams)
}

createOrder({
  pair: 'SWTH_NEO',
  blockchain: 'neo',
  address: user.address,
  side: 'buy',
  price: (0.001).toFixed(8),
  wantAmount: toNeoAssetAmount(20.5),
  useNativeTokens: true,
  orderType: 'limit',
  privateKey: user.privateKey
})
```

> Example request

```js
{
  "pair": "SWTH_NEO",
  "blockchain": "neo",
  "side": "buy",
  "price": "0.00100000",
  "want_amount": "2050000000",
  "use_native_tokens": true,
  "order_type": "limit",
  "timestamp": 1531541888559,
  "contract_hash": "<contract hash>",
  "address": "87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f",
  "signature": "<signature>"
}
```

> Example response

```js
{
  "id": "cfd3805c-50e1-4786-a81f-a60ffba33434",
  "blockchain": "neo",
  "contract_hash": "eed0d2e14b0027f5f30ade45f2b23dc57dd54ad2",
  "address": "87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f",
  "side": "buy",
  "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "want_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
  "offer_amount": "2050000",
  "want_amount": "2050000000",
  "transfer_amount": "0",
  "priority_gas_amount": "0",
  "use_native_token": true,
  "native_fee_transfer_amount": 0,
  "deposit_txn": null,
  "created_at": "2018-07-13T07:58:11.340Z",
  "status": "pending",
  "fills": [
    {
      "id": "2eaa3621-0e7e-4b3d-9c8c-454427f20949",
      "offer_hash": "bb70a40e8465596bf63dbddf9862a009246e3ca27a4cf5140d70f01bdd107277",
      "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
      "want_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
      "fill_amount": "1031498",
      "want_amount": "2050000000",
      "filled_amount": "",
      "fee_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
      "fee_amount": "1537500",
      "price": "0.00050317",
      "txn": [Object],
      "status": "pending",
      "created_at": "2018-07-13T07:58:11.353Z",
      "transaction_hash": "97ad8c0af68d22304e7f2d09d04f3beed29a845fe57de53444fff1507b752b99"
    }
  ],
  "makes": []
}
```

 Parameter         | Type        | Required   | Description
------------------ | ----------- | ---------- | -----------
 pair              | **string**  | yes         | Pair to trade, e.g. `RPX_NEO`.
 blockchain        | **string**  | yes         | Blockchain that the `pair` is on. Possible values are: `neo`.
 side              | **string**  | yes         | Whether to buy or sell on this pair. Possible values are: `buy`, `sell`.
 price             | **string**  | yes         | Buy or sell price to 8 decimal places precision.
 want_amount       | **string**  | yes         | [Amount](#amounts) of tokens offered in the order.
 use_native_tokens | **boolean** | yes         | Whether to use SWTH as fees or not. Possible values are: `true` or `false`.
 order_type        | **string**  | yes         | Order type, possible values are: `limit`.
 timestamp         | **int**     | yes         | The current time in epoch **milliseconds**.
 signature         | **string**  | yes         | Signature of the request payload. See [Authentication](#authentication) for more details.
 address           | **string**  | yes         | [Address](#address) of the order maker. Do not include this in the parameters to be signed.
 contract_hash     | **string**  | yes         | Switcheo Exchange [contract hash](#contract-hash) to execute the order on.

### Example
[Full create order example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/createOrderExample.js)

## Broadcast Order

This is the second endpoint required to execute an order.
After using the [Create Order](#create-order) endpoint, you will receive a response which needs to be signed.

> Format of signatures parameter

```js
{
  makes: {
    <make_id>: <signature>
  },
  fills: {
    <fill_id_1>: <signature_1>,
    <fill_id_2>: <signature_2>
  }
}
```

Every `txn` of the `fills` and `makes` in the Create Order response should be [signed](#authentication),
and structured in the `signatures` format shown on the right.


### HTTP Request

`POST /v2/orders/:id/broadcast`

### Request Parameters

> Broadcast an order

```js
function signArray(array, privateKey) {
  return array.reduce((map, item) => {
    map[item.id] = signTransaction(item.txn, privateKey)
    return map
  }, {})
}

function broadcastOrder({ order, privateKey }) {
  const { fills, makes } = order
  const signatures = {
    fills: signArray(order.fills, privateKey),
    makes: signArray(order.makes, privateKey)
  }
  const url = `${API_URL}/orders/${order.id}/broadcast`
  return api.post(url, { signatures })
}
```

> Example request

```js
{
  "signatures": {
    "fills": {
      "c821c814-d4a3-475b-b461-e909d8c8a59a": "<signature_1>"
    },
    "makes": {
      "d034djb1-9sd8-5b6k-1f9g-40fd9jntk86k": "<signature_2>",
      "ufdh03kt-23jg-h6k5-45fd-56dfy7ks0g9a": "<signature_3>"
    }
  }
}
```

 Parameter  | Type       | Required | Description
 ---------- | ---------- | -------- | -----------
 signatures | **hash**   | yes       | See the section description and example for the format.

### Example
[Full broadcast order example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/broadcastOrderExample.js)

## Create Cancellation

> Create a cancellation

```js
function createCancellation({ order, address, privateKey }) {
  const signableParams = { orderId: order.id, timestamp: getTimestamp() }
  const signature = signParams(signableParams, privateKey)
  const apiParams = { ...signableParams, signature, address }
  return api.post(API_URL + '/cancellations', apiParams)
}
```

This is the first API call required to cancel an order.
Only orders **with makes** and with an `available_amount` of **more than 0** can be cancelled.

<aside class="notice">
  IMPORTANT: After calling this endpoint, the Execute Cancellation endpoint has to be called for the cancellation to be executed.
</aside>

### HTTP Request

`POST /v2/cancellations`

### URL Parameters

> Example request

```js
{
  "order_id": "69c60da5-5832-4705-8390-de4bb4ed62c5",
  "timestamp": 1531471743957,
  "signature": "<signature>",
  "address": "87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f"
}
```

> Example response

```js
{
  "id": "e4cf0472-59e3-4887-b2d3-720b98da0de6",
  "transaction": {
    "hash": "b4013bdfde6370198f043f2a5fb235242d20280361241d85ee0774c63856f65b",
    "sha256": "f760aaa9efe99059af46a2a9640e91527119e78f18322729ab620e20116b3cf8",
    "type": 209,
    "version": 1,
    "attributes": [
      [
        null
      ]
    ],
    "inputs": [
      [
        null
      ]
    ],
    "outputs": [
      [
        null
      ]
    ],
    "scripts": [],
    "script": "206e62f9555edc1f791d36f6f081d44b249e8696ab73f41cc809db73316eff6e65349b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc532e125258b7db0a0dffde5bd03b2b859253538ab52c10b63616e63656c4f6666657267d24ad57dc53db2f245de0af3f527004be1d2d0ee",
    "gas": 0
  },
  "script_params": {
    "scriptHash": "eed0d2e14b0027f5f30ade45f2b23dc57dd54ad2",
    "operation": "cancelOffer",
    "args": [
      "9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc532e125258b7db0a0dffde5bd03b2b859253538ab",
      "6e62f9555edc1f791d36f6f081d44b249e8696ab73f41cc809db73316eff6e65"
    ]
  }
}
```

 Parameter  | Type       | Required | Description
----------- | ---------- | -------- | ------------------------------
 order_id   | **string** | yes       | The ID of the order to cancel.
 timestamp  | **int**    | yes       | The current time in epoch **milliseconds**.
 signature  | **string** | yes       | Signature of the request payload. See [Authentication](#authentication) for more details.
 address    | **string** | yes       | [Address](#address) of the order maker. Do not include this in the parameters to be signed.

### Example

[Full create cancellation example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/createCancellationExample.js)

## Execute Cancellation

> Execute a cancellation

```js
function executeCancellation({ cancellation, privateKey }) {
  const signature = signTransaction(cancellation.transaction, privateKey)
  const url = `${API_URL}/cancellations/${cancellation.id}/broadcast`
  return api.post(url, { signature })
}
```

This is the second endpoint that must be called to cancel an order.
After calling the [Create Cancellation](#create-cancellation) endpoint, you will receive
a transaction in the response which must be signed.

Note that a `sha256` parameter is provided for convenience to be used directly as part of the ECDSA signature process.

*In production mode, this should be recalculated for additional security.*

> Example request

```js
{
  "signature": "<signature>"
}
```

### HTTP Request

`POST /v2/cancellations/:id/broadcast`

### URL Parameters

 Parameter | Type       | Required | Description
---------- | ---------- | -------- | ------------
 signature | **string** | yes       | Signature of the transaction. See [Authentication](#authentication) for more details.

### Example

[Full execute cancellation example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/executeCancellationExample.js)
