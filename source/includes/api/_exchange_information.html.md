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

Please note that a different set of contract hashes should be used
depending on the Network you intend to work with (TestNet vs the MainNet).

Network  | URL
-------- | ----------
TestNet  | Retrieve contract hashes from [TestNet_URL]/v2/exchange/contracts
MainNet  | Retrieve contract hashes from [MainNet_URL]/v2/exchange/contracts

Note also that, ETH contract hashes always include a `0x` prefix, while NEO never
includes a `0x` prefix.


## Tokens

Retrieve a list of supported tokens on Switcheo.

### HTTP Request

`GET /v2/exchange/tokens`

> Example response

```js
// GET /v2/exchange/tokens?show_listing_details=1&show_inactive=1
{
  "NEO": {
        "hash": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
        "decimals": 8,
        "precision": 3,
        "trading_active": true
        "active": true,
        "listing_info": {
            "deposits": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            },
            "trading": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            },
            "cancellations": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            },
            "withdrawals": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            }
        }

 },
  ...
  "SWC": {
        "hash": "0x00bb907302e508707108cd835621dfd2b44ca7cf",
        "decimals": 18,
        "precision": 1,
        "trading_active": true
        "active": true,
        "listing_info": {
            "deposits": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            },
            "trading": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            },
            "cancellations": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            },
            "withdrawals": {
                "start": 1514764800,
                "end": 7983792000,
                "paused": false
            }
        }
   }
  ...
}
```

### Request parameters

 Parameter              | Type      | Required  | Description
---------------         | --------- | --------- | -----------
 show_listing_details   | Boolean   | no        | Show all details for each token (default is `false`). If `false`, only `hash` & `decimals` are returned, otherwise all parameters below are returned.
 show_inactive          | Boolean   | no        | Show inactive tokens (default is `false`)

### Response parameters

Parameter         | Description
----------------- | ----------
hash              | Contract hash of the token
decimals          | Number of decimal places to use when submitting order amounts (e.g. if a token has `8` `decimals`, then an order for `1.2` tokens should be submitted as `120000000`)
precision         | Minimum amount precision (e.g. if a token has `8` `decimals` and `2` precision, `123000000` would be a valid order amount to submit, but not `12340000`)
minimum_quantity  | The minimum order amount for any orders submitted involving this token. Note that this applies to both the order `want_amount` and `offer_amount` (or `quantity`, if using new format).
trading_active    | Whether this token is currently actively trading
active            | Whether this token is currently visible on the Switcheo Exchange UI
listing_info      | Status of the token for trading activities `["deposits", "trading", "cancellations", "withdrawals"]`  (only returned if `show_listing_details` is truthy)
start             | Starting time for the activity (in epoch seconds)
end               | Ending time for the activity (in epoch seconds)
paused            | Whether the trading of the token is temporarily paused


## Pairs

Retrieve available currency pairs on Switcheo Exchange filtered by the `base` parameter. Defaults to all pairs.

The valid `base` currencies are currently: `NEO`, `GAS`, `SWTH`, `USD`.


### HTTP Request

`GET /v2/exchange/pairs`

> Example response without details

```js
// GET /v2/exchange/pairs?bases=["NEO"]&show_details=0
[
  "GAS_NEO",
  "SWTH_NEO",
  ...
]

```
> Example response with details
// GET /v2/exchange/pairs?bases=["NEO"]&show_details=1
```js
[
    {
        "name": "GAS_NEO",
        "price_precision": 3
        "quantity_precision": 3
    },
    {
        "name": "SWTH_NEO",
        "price_precision": 6,
        "quantity_precision": 2
    },
...
]
```


### Request parameters

 Parameter              | Type            | Required  | Description
---------------         | -----------     | --------- | -----------
 bases                  | Array\<string\> | no        | Provides pairs for these base symbols. Possible values are `NEO, GAS, SWTH, USD`.
 show_details           | Boolean         | no        | Show further details for token
 show_inactive          | Boolean         | no        | Show inactive tokens (default is to not return inactive tokens)


### Response parameters for `show_details=0`

Parameter        | Description
------------     | ----------
Array            | List of token pairings (ticker) `<QUOTE>_<BASE>` where `<QUOTE>` is the trading token symbol (e.g. `SWTH`), while `<BASE>` is the base token symbol (e.g. `NEO`)

### Response parameters for `show_details=1`

Parameter        | Description
------------     | ----------
name             | ticker name as `<QUOTE>_<BASE>` where `<QUOTE>` is the trading token symbol (e.g. `SWTH`), while `<BASE>` is the base token symbol (e.g. `NEO`)
precision        | The price precision that can be submitted (e.g. if precision is `2`,
an order on this pair for `1.99` is valid, but `1.999` is not)


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
message      | HTML formatted message
message_type | Importance of Message - Possible Values: "alert" \| "warning" \| "info"
