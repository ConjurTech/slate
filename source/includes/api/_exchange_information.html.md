# Exchange information

The tickers section consists of endpoints that allow retrieval of basic Switcheo Exchange information.
Authentication is not required for these endpoints.

## Timestamp

> Example response

```js
{
  "timestamp": 1534392760908
}
```

Returns the current timestamp in the exchange, this value should be fetched and used when a
timestamp parameter is required for API requests.

### HTTP Request

`GET /v2/exchange/timestamp`

## Contracts

> Example response

```js
{
  "NEO":
  {
    "V1": "0ec5712e0f7c63e4b0fea31029a28cea5e9d551f",
    "V1_5": "c41d8b0c30252ce7e8b6d95e9ce13fdd68d2a5a8",
    "V2": "48756743d524af03aa75729e911651ffd3cbe7d8"
  }
}

```

Returns updated hashes of contracts deployed by Switcheo.

### HTTP Request

`GET /v2/exchange/contracts`

## Tokens

> Example response

```js
{
  "NEO": {
    "hash": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
    "decimals": 8
  },
  "GAS": {
    "hash": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
    "decimals": 8
  },
  "SWTH": {
    "hash": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
    "decimals": 8
  },
  ...
}
```

Returns updated hashes of contracts deployed by Switcheo.

### HTTP Request

`GET /v2/exchange/tokens`


## Pairs

Retrieve available currency pairs on Switcheo Exchange filtered by the `base` parameter. Defaults to all pairs.

The valid `base` currencies are currently: `NEO`, `GAS`, `SWTH`.


> Example response

```js
[
  "GAS_NEO",
  "SWTH_NEO",
  ...
]

```

### HTTP Request

`GET /v2/exchange/pairs`

### Request parameters

 Parameter      | Type      | Required  | Description
--------------- | --------- | --------- | -----------
 bases          | **array** | no | Provides pairs for these base symbols. Possible values are `NEO, GAS, SWTH, USD`.
