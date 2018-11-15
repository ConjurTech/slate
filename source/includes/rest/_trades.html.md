## Trades

A trade represents a fill of an offer.

This happens when an incoming order matches an offer on the opposite side of the order book in price.

Trades can be seen on the Trade History column on [Switcheo Exchange](https://switcheo.exchange).

### List Trades

> Example request

```js
{
  "blockchain": "neo",
  "pair": "SWTH_NEO",
  "limit": 3,
  "contract_hash": "<contract hash>"
}
```

> Example response

```js
[
  {
    "id": "712a5019-3a23-463e-b0e1-80e9f0ad4f91",
    "fill_amount": 9122032316,
    "take_amount": 20921746,
    "event_time": "2018-06-08T11:32:03.219Z",
    "is_buy": false
  },
  {
    "id": "5d7e42a2-a8f3-40a9-bce5-7304921ff691",
    "fill_amount": 280477933,
    "take_amount": 4207169,
    "event_time": "2018-06-08T11:31:42.200Z",
    "is_buy": false
  },
  ...
]
```

Retrieves raw trades that occurred on Switcheo Exchange, filtered by the request parameters.

#### HTTP Request

`GET /v2/trades`

#### Request Parameters

Parameter     | Type         | Required | Description
------------- | ------------ | -------- | -----------
contract_hash | **string**   | yes      | Only return trades for this [contract hash](#contracts).
pair          | **string**   | yes      | Only return trades for this [pair](#pairs).
from          | **integer**  | no       | Only return trades after this time in epoch seconds.
to            | **integer**  | no       | Only return trades before this time in epoch seconds.
limit         | **integer**  | no       | Only return this number of trades (min: `1`, max: `10000`, default: `5000`).

#### Response parameters

Parameter   | Description
----------- | ----------
id          | Unique identifier for the trade object.
fill_amount | Amount of tokens that is given by the trade to the [offer](#offers) that it is filling.
take_amount | Amount of tokens that the trade takes from the [offer's](#offers) `available_amount` that it is filling.
event_time  | Datetime that the trade occurs in Zulu Time (UDT+0)
is_buy      | Whether the side of the trade is a buy.

#### Example
[Full list trades example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/trades/listTradesExample.js)


### Get Recent Trades

Returns `20` most recent formatted trades on the selected pair sorted by executed time in descending order (most recent first).

#### HTTP Request

`GET /v2/trades/recent`

#### Request Parameters

Parameter     | Type         | Required | Description
------------- | ------------ | -------- | -----------
pair          | **string**   | yes      | Only return trades for this [pair](#pairs).

#### Response parameters

> Example response

```js
[
  {
  "id": "dc1c8926-dda1-4f39-afae-0872da950340",
  "pair": "SWTH_NEO",
  "side": "sell",
  "price": "0.00046835",
  "quantity": "84.0",
  "total": "0.0393414",
  "timestamp": 1537924944
  },
  ...
]
```

Parameter   | Description
----------- | ----------
id          | Unique identifier for the trade object.
pair        | The [pair](#pairs) on which the trade occurred.
side        | Whether the trade was a buy or sell on this pair. Possible values are: `buy`, `sell`. If the pair is `SWTH_NEO` and the side is `buy` then the trade bought `SWTH` using `NEO`. If the side is `sell` then the trade sold `SWTH` for `NEO`.
price       | Buy or sell price to 8 decimal places precision.
quantity    | If `buy` side, returns amount of tokens that the trade takes from the [offer's](#offers) `available_amount` that it is filling. If `sell` side, returns amount of tokens that the trade gives the [offer](#offers) that it is filling
total       | If `buy` side, returns amount of tokens that the trade gives the [offer](#offers) that it is filling. If `sell` side, returns amount of tokens that the trade takes from the [offer's](#offers) `available_amount` that it is filling
timestamp   | Time that trade was broadcasted in epoch **seconds**
