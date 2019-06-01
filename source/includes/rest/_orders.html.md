## Orders

Orders are instructions to trade tokens on Switcheo Exchange.

### Overview

`limit`, `market` and `otc` type orders are available. Fill-Or-Kill, Post-Only, etc. strategies are not yet available.

Orders will contain a combination of zero or one **make** and/or zero or more **fills** once matched.

When an order is executed, the funds required to fulfill the order is debited from the user's [confirmed balance](#balances)
 and will be locked up in their locked balance until the order is filled or cancelled.

### The Order Model

A breakdown of attributes in an order object returned from our API is described below.

#### Order Object

> Example order

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
    "order_status": "completed",
    "fills": [...],
    "fill_groups": [...],
    "makes": [...]
  }
]
```

Attribute                  | Description
-------------------------- | ----------
id                         | Unique identifier for the order object.
blockchain                 | The blockchain that the order exists on.
contract_hash              | Switcheo Exchange [contract hash](#contracts) that the order is on.
address                    | Wallet [Address](#addresses) of the order maker.
side                       | Whether the order maker is buying or selling.
offer_asset_id             | [Asset ID](#supported-assets) of the token that the order maker is offering.
want_asset_id              | [Asset ID](#supported-assets) of the token that the order maker wants.
offer_amount               | Total [amount](#amounts) of the token that the order maker is offering.
want_amount                | Total [amount](#amounts) of the token that the order maker wants.
use_native_token           | Whether SWTH tokens was used by the order maker to pay taker fees.
order_status               | Status of the order in the context of the exchange. Possible values are `open` (on orderbook waiting to be filled),`cancelled` (cancelled open order), `completed` (maker order that is entirely filled or broadcasted filler order)
txn                        | Serialized blockchain transaction that will execute this order. <strong>Used for EOS only.</strong>
fills                      | Refer to the [fills](#the-fill-object) section for more details.
fill groups                | Refer to the [fills groups](#the-fill-group-object) section for more details.
makes                      | Refer to the [makes](#the-make-object) section for more details.
created_at                 | Time when the order was created.
transfer_amount            | DEPRECATED. [Amount](#amounts) (out of the `offer_amount`) that was deposited into the contract in order to create the order.
native_fee_transfer_amount | DEPRECATED. Amount of SWTH that was deposited into the contract in order to pay the taker fees of the order.
priority_gas_amount        | DEPRECATED. Amount of gas paid by the order maker as priority.
status                     | DEPRECATED. Status of the order in the context of the blockchain. Possible values are `pending` (after creation), `processed` (after broadcast), `expired` (created but not broadcasted for a long time)
deposit_txn                | DEPRECATED. Transaction that was used for deposits related to the order creation.

##### Fill Object

> Example fill

```json
{
  "id": "6531a67c-6b2e-49b6-8a33-20dfb32b5d8e",
  "offer_hash": "fcc8ef7fa17cd540b2e0cbbed9e231db9994279b08618208a4dee292370b38b9",
  "offer_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
  "want_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "fill_amount": "100000000",
  "want_amount": "1000000",
  "filled_amount": "100000000",
  "fee_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "fee_amount": "1500",
  "price": "0.01",
  "txn": [Object],
  "status": "success",
  "created_at": "2018-06-08T07:23:32.299Z",
  "transaction_hash": "c51232abf42935a52d6c27122e5de5f92b33ffc43f9a85c5ee6353009c81f80c"
}
```

When an order is created, the order matching engine will match the order against existing offers.

If any matching offers are found, then `fills` are created.
These `fills` represent the filling of the order by the matching offers.

Attribute                  | Description
-------------------------- | ----------
id                         | Unique identifier for the fill object.
offer_hash                 | The hash of the corresponding offer for this fill object.
offer_asset_id             | [Asset ID](#supported-assets) of the token that the order maker is offering.
want_asset_id              | [Asset ID](#supported-assets) of the token that the order maker wants.
fill_amount                | [Amount](#amounts) of tokens that the target offer wants.
want_amount                | [Amount](#amounts) of tokens that is being taken from the target offer.
filled_amount              | [Amount](#amounts) of tokens that is given to the target offer.
fee_asset_id               | [Asset id](#supported-assets) of the token used for fees.
fee_amount                 | [Amount](#amounts) of fees paid for the fill.
price                      | The buy or sell price of order.
txn                        | The transaction representing this fill.
status                     | Status of the fill. Possible values are `pending` (after order creation), `confirming` (after order broadcast), `success` (after broadcast success), `expired` (after order creation but not broadcasted for a long while)
created_at                 | Time when the fill was created.
transaction_hash           | Transaction hash of the transaction representing this fill.

##### Fill Group Object

> Example fill group

```json
{
  "id": "7193c1e3-c9ab-429c-881c-429169880cfc",
  "address": "0x0f936dce97a9a5c50becc3f58a4842b4c607e722",
  "fill_ids": [
    "dd08787b-242c-4eb5-8c53-3e9d2f4be4cd"
  ],
  "txn": [Object],
  "fee_amount": "4242000000000000",
  "fee_asset_id": "0x0000000000000000000000000000000000000000"
}
```

Fills are grouped into sets for ETH.

This reduces the number of signature requests needed for an order, instead of signing
multiple fills individually, a group of fills can be signed with one signature request.

This feature also minimizes ETH network gas costs.

Attribute                  | Description
-------------------------- | ----------
id                         | Unique identifier for the fill group object.
address                    | [Address](#addresses) of the filler.
fill_ids                   | The IDs grouped under this fill group.
txn                        | The transaction representing this fill group.
fee_amount                 | [Amount](#amounts) of fees paid for this fill group.
fee_asset_id               | [Asset id](#supported-assets) of the token used for the fee.

##### Make Object

> Example make

```json
{
  "id": "dc8a36dd-c405-4999-875a-ce619aecbb5c",
  "offer_hash": "3423bd82c6e2ec36ccba7a949d5732905e5c6b179517c8aebd9caf72977d817d",
  "available_amount": "1000",
  "offer_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
  "offer_amount": "1234567800",
  "want_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "want_amount": "111111102",
  "filled_amount": "1234567800",
  "txn": [Object],
  "cancel_txn": [Object],
  "price": "0.09",
  "status": "success",
  "created_at": "2018-06-08T07:21:19.988Z",
  "transaction_hash": "ff6e73805aed42d445ec0e8d47375e024a7d8c99cd5b8c375d607fec61b80567"
}
```

When an order is created, the order matching engine will match the order against existing offers.

If the order is not fully filled by existing offers, a `make` is created.
This `make` represents the unfilled amount of the order.

Attribute                  | Description
-------------------------- | ----------
id                         | Unique identifier for the make object.
offer_hash                 | The hash of the corresponding offer for this make object.
available_amount           | Remaining [amount](#amounts) of the offered tokens in the make that has not been filled by other offers.
offer_asset_id             | [Asset ID](#supported-assets) of the token that the make is offering.
offer_amount               | [Amount](#amounts) of tokens that the make is offering.
want_asset_id              | [Asset ID](#supported-assets) of the token that the make wants.
want_amount                | [Amount](#amounts) of tokens that the make wants.
filled_amount              | [Amount](#amounts) of tokens out of the make's `offer_amount` that has been taken by other orders.
txn                        | The transaction representing this make.
cancel_txn                 | If this make was cancelled, this parameter would be the transaction that represents the cancellation.
price                      | Buy or sell price of order.
status                     | Status of the make. Possible values are `pending` (after order creation), `confirming` (after order broadcast), `success` (after broadcast success), `cancelling` (after cancellation broadcasted), `cancelled` (after cancellation broadcast success), `expired` (after order creation but not broadcasted for a long while)
created_at                 | Time when the make was created.
transaction_hash           | Transaction hash of the transaction representing this make.

### GET Order

> Example request

```js
{
  "order": "995cfc34-8fb8-41e6-bccd-1695086267d1",
}
```

> Example Response

```json
{
  "id": "995cfc34-8fb8-41e6-bccd-1695086267d1",
  "blockchain": "eth",
  "contract_hash": "0xba3ed686cc32ffa8664628b1e96d8022e40543de",
  "address": "0x7c819b61b3a35ab718f66508d31e2cf3c25eb624",
  "pair": "DAI_ETH",
  "side": "buy",
  "price": "0.00662",
  "quantity": "62000000000000000000",
  "use_native_token": false,
  "created_at": "2018-11-20T03:43:48.035Z",
  "order_status": "cancelled",
  "offer_asset_id": "0x0000000000000000000000000000000000000000",
  "want_asset_id": "0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359",
  "offer_amount": "410440000000000000",
  "want_amount": "62000000000000000000",
  "status": "processed",
  "deposit_txn": null,
  "transfer_amount": "0",
  "priority_gas_amount": "0",
  "native_fee_transfer_amount": 0,
  "fill_groups": [...],
  "fills": [...],
  "makes": [...]
}
```

Retrieves a specific order

#### HTTP Request

`GET /v2/orders/:order_id`

#### Request Parameters

 Parameter      | Type                  | Required | Description
--------------- | --------------------- | -------- | -------------
 order_id       | **string**            | yes      | Return order details for a specific order id

### GET Orders

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
    "order_status": "processed",
    "fills": [...],
    "makes": [...]
  }
]
```

Retrieves orders from a specific address filtered by the given parameters.

#### HTTP Request

`GET /v2/orders`

#### Request Parameters

 Parameter      | Type                  | Required | Description
--------------- | --------------------- | -------- | -------------
 address        | [address](#addresses) | yes      | Only return orders made by this [address](#addresses).
 pair           | **string**            | no       | Only return orders from this [pair](#pair).
 contract_hash  | **string**            | yes      | Only return orders from this [contract hash](#contracts).
 from           | **integer**           | no       | Only return orders that are last updated at or after this time in UNIX timestamp format
 order_status   | **string**            | no       | Only return orders have this status. Possible values are `open`, `cancelled`, `completed`
 before_id      | **string**            | no       | Only return orders that are created before the order with this id
 limit          | **integer**           | no       | Only return up to this number of orders (min: `1`, max: `200`, default: `50`).

#### Example

[Full list orders example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/listOrdersExample.js)


### POST Create Order

This endpoint creates an order which can be executed through [Broadcast Order](#execute-order).
Orders can only be created after sufficient funds have been [deposited](#deposits) into the user's contract balance.
A successful order will have zero or one **make** and/or zero or more **fills**.

<aside class="notice">
  IMPORTANT: After calling this endpoint, the Broadcast Order endpoint has to be called for the order to be executed.
</aside>

#### Atomic Swap Orders

Atomic Swap orders can be created through this endpoint,
the Atomic Swap contract needs to be approved if the offer_asset is on the ETH blockchain.
Refer to the [Approved Spenders](#approved-spenders) section for more information.

#### HTTP Request

`POST /v2/orders`

#### Request Parameters

For the below descriptions, the `order maker` refers to your API user.

> Create an order

```js
function createOrder({ pair, blockchain, side, price,
                       quantity, useNativeTokens, orderType,
                       privateKey, address }) {
  const signableParams = { pair, blockchain, side, price, quantity,
                           useNativeTokens, orderType, timestamp: getTimestamp(),
                           contractHash: CONTRACT_HASH }

  const signature = signParams(signableParams, privateKey)
  const apiParams = { ...signableParams, address, signature }
  return api.post(API_URL + '/orders', apiParams)
}

// NOTE: in this example, the parameters can be in camel case because
// the `signParams` and `api.post` method automatically convert param keys
// to snake case
createOrder({
  pair: 'SWTH_NEO',
  blockchain: 'neo',
  address: user.address,
  side: 'buy',
  price: (0.001).toFixed(8),
  quantity: toAssetAmount(1000, 'SWTH'),
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
  "quantity": "100000000000",
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
  "price": "0.00100000",
  "quantity": "100000000000",
  "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "want_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
  "offer_amount": "100000000",
  "want_amount": "100000000000",
  "transfer_amount": "0",
  "priority_gas_amount": "0",
  "use_native_token": true,
  "native_fee_transfer_amount": 0,
  "deposit_txn": null,
  "created_at": "2018-07-13T07:58:11.340Z",
  "status": "pending",
  "order_status": "nil",
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

 Parameter              | Type                    | Required   | Description
----------------------- | ----------------------- | ---------- | -----------
 blockchain             | **string**              | yes | Blockchain that the `pair` is on. Possible values are: `neo`, `eth`. This should be the blockchain of the offer_asset for Atomic Swap orders.
 contract_hash          | **string**              | yes | Switcheo Exchange [contract hash](#get-contracts) to execute the order on. For Atomic Swap orders, this should be the contract_hash for the blockchain of the `offer_asset`.
 pair                   | **string**              | yes | Pair to trade, e.g. `SWTH_NEO`.
 side                   | **string**              | yes | Whether to buy or sell on this pair. Possible values are: `buy`, `sell`. If the pair is `SWTH_NEO` and the side is `buy` then the order is to buy `SWTH` using `NEO`. If the side is `sell` then the order is to sell `SWTH` for `NEO`.
 price                  | **string**              | yes | Buy or sell price rounded to the pair's price precision, found on [Get Pairs](#get-pairs). Set value to `null` for market type and Atomic Swap orders.
 quantity               | [amount](#amounts)      | yes | The [amount](#amounts) of tokens you wish to trade. Set value to `null` for Atomic Swap orders.
 offer_amount           | [amount](#amounts)      | no  | The [amount](#amounts) of tokens to offer for an Atomic Swap. Must be provided if and only if the order pair is an Atomic Swap pair.
 use_native_tokens      | **boolean**             | yes | `true` if you wish to pay fees in SWTH. Use only `false` for orders on the Ethereum network.
 order_type             | **string**              | yes | Order type, possible values are: `limit`, `market`, `otc`. This type must be set as `market` for Atomic Swap orders.
 otc_address            | [address](#addresses)   | no  | Address of the counterparty in OTC trades. Must be provided if and only if `order_type` is `otc`.
 timestamp              | [timestamp](#timestamp) | yes | The exchange's timestamp to be used as a nonce.
 signature              | **string**              | yes | Signature of the request payload. See [Authentication](#authentication) for more details.
 address                | [address](#addresses)   | yes | [Address](#addresses) of the order maker. **Do not include this in the parameters to be signed.**
 receiving_address      | [address](#addresses)   | no | Address to receive the `want_asset`. Must be provided if and only if the order pair is an Atomic Swap pair.
 worst_acceptable_price | **string**              | no | The worst acceptable price of an Atomic Swap. If the [Atomic Swap pricing](#get-swap-pricing) changes to be worse than this, then the order will not be created. Must be provided if and only if the order pair is an Atomic Swap pair.

#### Example
[Full create order example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/createOrderExample.js)

### POST Execute Order

This is the second endpoint required to execute an order.
After using the [Create Order](#create-order) endpoint, you will receive a response which needs to be signed.

> Format of signatures parameter

```js
{
  // NEO & ETH:
  makes: {
    <make_id>: <signature>
  },
  // NEO only:
  fills: {
    <fill_id_1>: <signature_1>,
    <fill_id_2>: <signature_2>
  },
  // ETH only:
  fill_groups: {
    <fill_group_id_1>: <signature_3>,
    <fill_group_id_2>: <signature_4>
  },
  // EOS only:
  order: {
    <id>: <order_signature>,
  }
}
```

Every `txn` in the `fills`, `fill_groups` and `makes` of the Create Order response should be [signed](#authentication),
and structured in the `signatures` format shown on the right.

<strong>NOTE:</strong> The `txn` of `fills` for ETH will be empty, only the `txn` of the `fill_groups` need to be signed for ETH-based orders. Please see [Fill Groups](#fill-group-object) for more details.

<strong>NOTE:</strong> The `makes`, `fills` and `fill_groups` arrays for EOS will initially be empty as orders are matched on-chain.
Only the root `txn` needs to be signed for EOS-based orders.

Please see the [Authentication](#authentication) section on how to perform the `signTransaction` operation.

#### HTTP Request

`POST /v2/orders/:id/broadcast`

#### Request Parameters

> Broadcast an order

```js
function signArray(array, privateKey) {
  return array.reduce((map, item) => {
    if (item.txn) {
      map[item.id] = signTransaction(item.txn, privateKey)
    }
    return map
  }, {})
}

function broadcastOrder({ order, privateKey }) {
  const { fills, makes } = order
  const signatures = {
    makes: signArray(order.makes, privateKey),
    fills: signArray(order.fills, privateKey),
    fill_groups: signArray(order.fill_groups, privateKey),
    order: signArray([order], privateKey)
  }
  const url = `${API_URL}/orders/${order.id}/broadcast`
  return api.post(url, { signatures })
}
```

> Example request

```js
{
  "signatures": {
    "makes": {
      "ufdh03kt-23jg-h6k5-45fd-56dfy7ks0g9a": "<signature_3>"
    },
    // NEO only:
    "fills": {
      "c821c814-d4a3-475b-b461-e909d8c8a59a": "<signature_1>",
      "d034djb1-9sd8-5b6k-1f9g-40fd9jntk86k": "<signature_2>",
    },
    // ETH only:
    "fill_groups": {
      "6f9afaeb-1866-47d5-b7d8-061eab1b5fbc": "<signature_4>",
      "94a282ed-bf89-40e2-b0ea-7d3a0dac3c68": "<signature_5>"
    },
    // EOS only:
    "order": {
      "cfd3805c-50e1-4786-a81f-a60ffba33434": "<order_signature>"
    }
  }
}
```

 Parameter  | Type       | Required | Description
 ---------- | ---------- | -------- | -----------
 signatures | **hash**   | yes       | See the section description and example for the format.

#### Example
[Full broadcast order example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/broadcastOrderExample.js)

### POST Create Cancellation

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

#### HTTP Request

`POST /v2/cancellations`

#### URL Parameters

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
 timestamp  | [timestamp](#timestamp)    | yes       | The exchange's timestamp to be used as a nonce.
 signature  | **string** | yes       | Signature of the request payload. See [Authentication](#authentication) for more details.
 address    | [address](#addresses) | yes       | [Address](#addresses) of the order maker. **Do not include this in the parameters to be signed.**

#### Example

[Full create cancellation example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/createCancellationExample.js)

### POST Execute Cancellation

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

#### HTTP Request

`POST /v2/cancellations/:id/broadcast`

#### URL Parameters

 Parameter | Type       | Required | Description
---------- | ---------- | -------- | ------------
 signature | **string** | yes       | Signature of the transaction. See [Authentication](#authentication) for more details.

#### Example

[Full execute cancellation example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/orders/executeCancellationExample.js)

### Computing Offer Hash (NEO)


> Computing the offer_hash

```js
const invoke = {
    scriptHash: contractHash,
    operation: 'makeOffer',
    args: [
      u.reverseHex(userHash),
      u.reverseHex(offerAssetID), new BigNumber(offerAmount).toNumber(),
      u.reverseHex(wantAssetID), new BigNumber(wantAmount).toNumber(),
      u.str2hexstring(uuid),
    ],
  }

const offerKeyBytes = invoke.args[0] + invoke.args[1] + invoke.args[3] +
  numToHex(invoke.args[2]) + numToHex(invoke.args[4]) + invoke.args[5]
const offerHash = u.reverseHex(u.hash256(offerKeyBytes))

const numToHex = (num) => {
  if (typeof num !== 'number') throw new Error('numToHex received a non-number')
  if (num < 0) throw Error.new(`numToHex received a negative number (${num})!`)
  if (num <= 16) {
    return u.num2hexstring(num)
  }
  return u.num2hexstring(num, 8, true)
}

```

In the previous sections,
  you may have noticed that offer_hashes are generated for fills and makes right after creation.

To compute the offer_hash, please take reference from the sample code snippet that is shown on the right.
  You can find the `u` library from [neon-js](https://github.com/CityOfZion/neon-js/tree/31600a3cb9c38b9a0d961e98475e4cc81c908cd8/packages/neon-core/src/u).
