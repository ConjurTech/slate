# Exchange information

This section consists of endpoints that allow retrieval of Switcheo Exchange information.

Authentication is not required for these endpoints.

## Timestamp
Retrieve the current epoch timestamp in the exchange.

### HTTP Request

`GET /v2/exchange/timestamp`

> Example response

```js
{
  "timestamp": 1534392760908
}
```

#### Notes

This value should be fetched and used when a timestamp parameter is required for API requests.

If the timestamp used for your API request is not within an acceptable range of the exchange's timestamp then an invalid signature error will be returned. The acceptable range might vary, but it should be less than one minute.


## Contracts

### HTTP Request

`GET /v2/exchange/contracts`

> Example response

```js
{
    "NEO": {
        "V1": "<contract hash NEO 1>",
        "V1_5": "<contract hash NEO 1.5>",
        "V2": "<contract hash NEO 2>"
    },
    "ETH": {
        "V1": "<contract address ETH V1>"
    }
}
```

Retrieve the currently deployed contract hashes by Switcheo.

Please note that different contract hashes should be used for the TestNet vs the MainNet.

Network  | URL
-------- | ----------
TestNet  | Retrieve contract hashes from [TestNet_URL]/v2/exchange/contracts
MainNet  | Retrieve contract hashes from [MainNet_URL]/v2/exchange/contracts

Note also that, unlike NEO, ETH Contract addresses always include a "0x" prefex.


## Tokens

Retrieve a list of supported tokens on Switcheo.

### HTTP Request

`GET /v2/exchange/tokens`

> Example response

```js
{
  "NEO": {
        "hash": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
        "decimals": 8,
        "minimum_precision": 3,
        "trading_active": true
  },
  "SWC": {
        "hash": "0x00bb907302e508707108cd835621dfd2b44ca7cf",
        "decimals": 18,
        "minimum_precision": 1,
        "trading_active": true
  }
  ...
}
```

### Request parameters

 Parameter      | Type      | Required  | Description
--------------- | --------- | --------- | -----------
 bases          | **array** | no        | Return pairs for these base symbols. Possible values are `NEO, GAS, SWTH, USD`.
 show_details   | String    | no        | Show all details for token (default is *hash* & *decimals* )
 show_inactive  | String    | no        | Show inactive tokens (default is to not return inactive tokens)

### Response parameters

Parameter         | Description
----------------- | ----------
hash              | Contract hash of the Symbol
decimals          | Number of implied Decimal Places in price values
minimum_precision | Minimum Display/Trading Precision (Digits right of decimal point)
trading_active    | Trading in this Symbol is activ on the Exchange **true / false**


## Pairs

Retrieve available currency pairs on Switcheo Exchange filtered by the `base` parameter. Defaults to all pairs.

The valid `base` currencies are currently: `NEO`, `GAS`, `SWTH`, `USD`.


### HTTP Request

`GET /v2/exchange/pairs?bases=["NEO"]`

> Example response

```js
[
  "GAS_NEO",
  "SWTH_NEO",
  ...
]

```

### Request parameters

 Parameter      | Type      | Required  | Description
--------------- | --------- | --------- | -----------
 bases          | **array** | no        | Provides pairs for these base symbols. Possible values are `NEO, GAS, SWTH, USD`.

### Response parameters

Parameter    | Description
------------ | ----------
*symbol*\_*base*     | list of *Symbol / Base* Name concatenations


## Announcement Message

Retrieve the currently active Switcheo Exchange Announcement

### HTTP Request

`GET /v2/exchange/announcement_message`

> Example response

```js
{
    "message": "Welcome to Switcheo Exchange!!",
    "message_type": "info"
}
```

### Response parameters

Parameter    | Description
------------ | ----------
message      | list of *Symbol / Base* Name concatenations
message_type | Importance of Message - Possible Values: alert | warning | info
