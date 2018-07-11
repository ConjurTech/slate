# Trades

A trade represents a fill of an offer.

This happens when an incoming order matches an offer on the opposite side of the order book in price.

Trades can be seen on the Trade History column on [Switcheo Exchange](https://switcheo.exchange).

## List Trades

> Example Request

```shell
curl "https://test-api.switcheo.network/v2/trades?contract_hash=9c9d2fac35987621e252981e06762895b09eb035&pair=SWTH_NEO"
```

> Example Response

```json
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

Retrieves trades that have already occurred on Switcheo Exchange filtered by the request parameters.

### HTTP Request

`GET /v2/trades`

### Request Parameters

Parameter     | Type                   | Description
------------- | ---------------------- | ----------- 
contract_hash | **String**             | Only return trades for this [contract hash](#contracts).
pair          | **String**             | Only return trades for this [pair](#pairs).
from          | **Integer** (optional) | Only return trades after this time (unix epoch).
to            | **Integer** (optional) | Only return trades before this time (unix epoch).
limit         | **Integer** (optional) | Only return this number of trades (min: `1`, max: `10000`, default: `5000`).
