## Exchange Information

This section consists of endpoints that allows retrieval of Switcheo Exchange information.

Authentication is not required for these endpoints.

### GET Timestamp
Retrieve the current epoch [timestamp](#timestamp) in the exchange.

#### HTTP Request

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


### GET Contracts

#### HTTP Request

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

Returns the current deployed contract hashes by Switcheo Exchange.

Please note that a different set of contract hashes should be used
depending on the network you intend to interact with.

Network  | URL
-------- | ----------
TestNet  | Retrieve contract hashes from [TestNet_URL]/v2/exchange/contracts
MainNet  | Retrieve contract hashes from [MainNet_URL]/v2/exchange/contracts

ETH contract hashes should always include a `0x` prefix, while NEO contract hashes should never
includes a `0x` prefix.

### GET Pairs

Retrieve available trading pairs on Switcheo Exchange filtered by the `base` parameter. Defaults to all pairs.

#### HTTP Request

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

```js
// GET /v2/exchange/pairs?bases=["NEO"]&show_details=1
[
    {
        "name": "GAS_NEO",
        "price_precision": 3
    },
    {
        "name": "SWTH_NEO",
        "price_precision": 6,
    },
    ...
]

```


#### Request parameters

 Parameter              | Type            | Required  | Description
---------------         | -----------     | --------- | -----------
 bases                  | Array\<string\> | no        | Provides pairs for these base symbols.
 show_details           | Boolean         | no        | Show further details for token. Defaults to `0`


#### Response parameters for `show_details=0`

Parameter        | Description
------------     | ----------
Array            | List of token pairings (ticker) `<QUOTE>_<BASE>` where `<QUOTE>` is the trading token symbol (e.g. `SWTH`), while `<BASE>` is the base token symbol (e.g. `NEO`)

#### Response parameters for `show_details=1`

Parameter        | Description
------------     | ----------
name             | The ticker name as `<QUOTE>_<BASE>` where `<QUOTE>` is the trading token symbol (e.g. `SWTH`), while `<BASE>` is the base token symbol (e.g. `NEO`)
precision        | The maximum price precision that can be submitted (e.g. if precision is `2`, an order on this pair for `1.99` or `1.90000000` price is valid, but `1.999` is not)


### GET Tokens

Retrieve a list of supported tokens on Switcheo.

#### HTTP Request

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

#### Request parameters

 Parameter              | Type      | Required  | Description
---------------         | --------- | --------- | -----------
 show_listing_details   | Boolean   | no        | Show all details for each token. If `false`, only `hash` & `decimals` are returned, otherwise all parameters below are returned. Defaults to `false`
 show_inactive          | Boolean   | no        | Show inactive tokens. Default to `false`)

#### Response parameters

Parameter         | Description
----------------- | ----------
hash              | Contract hash of the token
decimals          | Number of decimal places to use when submitting order amounts (e.g. if a token has `8` `decimals`, then an order for `1.2` tokens should be submitted as `120000000`)
precision         | The maximum amount precision that can be submitted in orders (e.g. if a token has `8` `decimals` and `2` precision, `123000000` would be a valid order amount to submit, but not `12340000`)
minimum_quantity  | The minimum order amount for any orders submitted involving this token. Note that this applies to both the order `want_amount` and `offer_amount` (or `quantity`, if using new format).
trading_active    | Whether this token is currently actively trading
active            | Whether this token is currently visible on the Switcheo Exchange UI
listing_info      | Status of the token for trading activities `["deposits", "trading", "cancellations", "withdrawals"]`  (only returned if `show_listing_details` is truthy)
start             | Starting time for the activity (in epoch seconds)
end               | Ending time for the activity (in epoch seconds)
paused            | Whether the trading of the token is temporarily paused

### GET Fees

> Example response

```js
[
  {
    "maker": {
      "default": 0
    },
    "taker": {
      "default": 0.002
    },
    "network_fee_subsidy_threshold": {
      "neo": 0.1,
      "eth": 0.1
    },
    "max_taker_fee_ratio": {
      "neo": 0.005,
      "eth": 0.1
    },
    "native_fee_discount": 0.75,
    "native_fee_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
    "enforce_native_fees": [
      "RHT",
      "RHTC"
    ],
    "native_fee_exchange_rates": {
        "NEO": "952.38095238",
        "GAS": "297.14285714",
        ...
        "ETH": "0",
        "JRC": "0",
        "SWC": "0"
    },
    "network_fees": {
      "eth": "2466000000000000",
      "neo": "200000"
    },
    "network_fees_for_wdl": {
      "eth": "873000000000000",
      "neo": "0"
    }
  }
]

```

Returns fee data for various blockchains and pairs

#### HTTP Request

`GET /v2/fees`

#### Response parameters

Parameter                 | Description
------------------------- | ----------
maker / default           | Default trading fee rate for maker orders, before any discount and network fees
taker / default           | Default trading rate for taker orders, before any discount and network fees
network_fee_subsidy_threshold | The rate used against your trade proceeds at which network fees will be capped at. (E.g. Assuming `network_fee_subsidy_threshold` is 0.1 and the your total trade proceeds is 0.2 ETH, the payable network fee will not exceed 0.02 ETH.)
native_fee_discount       | Discount applied to fee for use of native token (as a multiplier). Discount Rate is 1 - `native_fee_discount`
native_fee_asset_id       | NEO contract hash of the Native Token (i.e. `SWTH`)
enforce_native_fee        | List of asset tickers where fee **must** be paid in Native Tokens
native_fee_exchange_rates | List of token:value tuples, containing the exchange rate in Native Token
network_fees              | Network Trading fee in the smallest denomination of the native network token
network_fees_for_wdl      | Network Withdrawal fee in the smallest denomination of the native network token

### GET Announcements

Retrieve the currently active Switcheo Exchange Announcement

#### HTTP Request

`GET /v2/exchange/announcement_message`

> Example response

```js
{
  "messages": [
    {
      "message": "<span>Welcome onboard to <a href=\"https://medium.com/switcheo/callisto-is-now-live-de940a62f1a4\" target=\\\"blank\\\">Switcheo</a>, the first decentralized exchange on Ethereum and NEO.</span>",
      "message_type": "alert"
    },
    {
      "message": "<span>To access the legacy UI, please visit: <a href=\"https://legacy.switcheo.exchange\" target=\\\"blank\\\">https://legacy.switcheo.exchange/</a></span>",
      "message_type": "info"
    }
  ],
  "updated_at": "20181203"
}
```

#### Response parameters

Parameter    | Description
------------ | ----------
messages     | A list of messages
updated_at   | Last updated date in `YYYYMMDD` format

### GET Lockups Stats

Retrieve the currently active Switcheo Exchange Lockup statistics

#### HTTP Request

`GET /v2/lockups/stats`

> Example request

```js
// GET /v2/lockups/stats?asset_id=<Token Hash>&contract_hash=<Smart Contract Hash>&lockup_type=0
{
  "asset_id": "0x9f235d23354857efe6c541db92a9ef1877689bcb",
  "contract_hash": "0xba3ed686cc32ffa8664628b1e96d8022e40543de",
  "lockup_type": 0
}
```

> Example response

```js
{
  "name": "Bolt HODL Campaign",
  "lockup_type": 0,
  "blockchain": "eth",
  "asset_id": "0x9f235d23354857efe6c541db92a9ef1877689bcb",
  "max_distribution": "10000000000000000000000000",
  "start_time": 1554120000,
  "end_time": 1559217600,
  "minimum_lockup": "20000000000000000000000",
  "total_amount": "11499118670000000000000000",
  "total_commitment": "58034155069021810000000000000000"
}
```

#### Request parameters

 Parameter      | Type       | Required | Description
--------------- | ---------- | -------- | -----------
asset_id        | **string** | yes      | Only return lockups for this [asset ID](#supported-assets).
contract_hash   | **string** | yes      | Only return lockups for this [contract hash](#contracts).
lockup_type     | **string** | yes      | Only return lockup information for this lockup campaign (0 = Bolt, 1 = SWTH Lite, 2 = SWTH Premium).

#### Response parameters

Parameter        | Description
------------     | ----------
name             | Lockup chest campaign name
lockup_type      | Indicator for the campaign being run (0 = Bolt, 1 = SWTH Lite, 2 = SWTH Premium).
blockchain       | Blockchain that the lockup chest campaign is running on.
asset_id         | Asset hash for the token the lockup chest campaign is running for.
max_distribution | The maximum amount of tokens to be shared amount lockup chest participants.
start_time       | Start time of the lockup chest campaign.
end_time         | End time of the lockup chest campaign.
minimum_lockup   | The minimum amount of tokens required to participate in the lockup chest campaign.
total_amount     | The total amount of tokens locked up by all participants during the lockup chest campaign.
total_commitment | TO DO

### GET Lockups by Account

Retrieve the currently active Switcheo Exchange Lockup statistics for a specific wallet address.

#### HTTP Request

`GET /v2/lockups/history`

> Example request

```js
// GET /v2/lockups/history?address=<Wallet Hash>&asset_id=<Token Hash>&blockchain=<Network Name>&contract_hash=<Smart Contract Hash>&lockup_type=0
{
  "address": "0x0",
  "asset_id": "0x9f235d23354857efe6c541db92a9ef1877689bcb",
  "blockchain": "eth",
  "contract_hash": "0xba3ed686cc32ffa8664628b1e96d8022e40543de",
  "lockup_type": 0
}
```

> Example response

```js
[
  {
    "id": "38202e02-727f-1953-4c8e-47ac66c0d06e",
    "lockup_type": 0,
    "address": "0xba3Ed686cC32FfA8664628b1E96D8022e40543dE",
    "asset_id": "0x9f235d23354857efe6c541db92a9ef1877689bcb",
    "contract_hash": "0xba3ed686cc32ffa8664628b1e96d8022e40543de",
    "blockchain": "eth",
    "lock_balance_id": "fce7660e-b323-4e12-a6fa-3e2b2353c411",
    "unlock_balance_id": null,
    "status": "locked",
    "amount": "20000000000000000000000",
    "remaining_seconds": 4812231,
    "created_at": "2019-04-04T19:16:09.246Z",
    "updated_at": "2019-04-04T19:16:09.246Z",
    "can_withdraw": false
  }
]
```

#### Request parameters

 Parameter      | Type       | Required | Description
--------------- | ---------- | -------- | -----------
address         | **string** | yes      | The lockup campaigns address [address](#addresses).
asset_id        | **string** | yes      | Only return lockups for this [asset ID](#supported-assets).
blockchain      | **string** | yes      | Blockchain that the lockup campaign is on. Possible values are: `neo` and `eth`.
contract_hash   | **string** | yes      | Only return lockups for this [contract hash](#contracts).
lockup_type     | **string** | yes      | Only return lockup information for this lockup campaign (0 = Bolt, 1 = SWTH Lite, 2 = SWTH Premium).

#### Response parameters

Parameter         | Description
------------      | ----------
id                | Lockup transaction ID.
lockup_type       | Indicator for the campaign being run (0 = Bolt, 1 = SWTH Lite, 2 = SWTH Premium).
address           | The wallet address for the lockup events.
asset_id          | Asset hash for the token the lockup chest campaign is running for.
contract_hash     | The contract hash for the Switcheo smart contract on the requested blockchain.
blockchain        | Blockchain that the lockup chest campaign is running on.
lock_balance_id   | The transaction identifier for the balance lockup event.
unlock_balance_id | The transaction identifier for the balance unlock event.
status            | The current lockup status of the balance.
amount            | Total amount of tokens locked up on this request.
remaining_seconds | The amount of time left until the lockup period ends.
created_at        | The time the lockup was created.
updated_at        | The time the lockup was updated.
can_withdraw      | Indicator for the ability to withdraw from the lockup campaign.
