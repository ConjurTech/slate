# Exchange information

This section consists of endpoints that allow retrieval of Switcheo Exchange information.
Authentication is not required for these endpoints.

## Timestamp

> Example response

```js
{
  "timestamp": 1534392760908
}
```

Retrieve the current timestamp in the exchange, this value should be fetched and used when a
timestamp parameter is required for API requests.

If the timestamp used for your API request is not within an acceptable range of the exchange's timestamp then an invalid signature error will be returned. The acceptable range might vary, but it should be less than one minute.

### HTTP Request

`GET /v2/exchange/timestamp`

## Contracts

> Example response

```js
{
  "NEO":
  {
    "V1": "<contract hash 1>",
    "V1_5": "<contract hash 1.5>",
    "V2": "<contract hash 2>"
  }
}

```

Retrieve updated contract hashes deployed by Switcheo.

Please note that different contract hashes should be used for the TestNet vs the MainNet.

    | URL
--- | ----------
TestNet  | Retrieve contract hashes from [TestNet_URL]/v2/exchange/contracts
MainNet | Retrieve contract hashes from [MainNet_URL]/v2/exchange/contracts

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

Retrieve a list of supported tokens on Switcheo.

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
