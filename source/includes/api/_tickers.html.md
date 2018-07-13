# Tickers

The tickers section consists of endpoints that allow retrieval of market data on Switcheo Exchange.
Authentication is not required for these endpoints.


## Candlesticks

> Example Request

```shell
curl "https://test-api.switcheo.network/v2/tickers/candlesticks?pair=SWTH_NEO&start_time=1531213200&end_time=1531220400&interval=1"
```

> Example Response

```json
[
  {
    "time": "1531215240",
    "open": "0.00049408",
    "close": "0.00049238",
    "high": "0.000497",
    "low": "0.00048919",
    "volume": "110169445.0",
    "quote_volume": "222900002152.0"
  },
  {
    "time": "1531219800",
    "open": "0.00050366",
    "close": "0.00049408",
    "high": "0.00050366",
    "low": "0.00049408",
    "volume": "102398958.0",
    "quote_volume": "205800003323.0"
  },
  ...
]

```

Returns candlestick chart data filtered by url parameters.

### HTTP Request

`GET /v2/tickers/candlesticks`

### Request parameters

 Parameter      | Type        | Optional  | Description
--------------- | ----------- | --------- | ------------------------------------
 pair           | **string**  | no       | Only show chart data of this [trading pair](#pair)
 start_time     | **integer** | no       | Start of time range for data returned (unix epoch)
 end_time       | **integer** | no       | End of time range for data returned (unix epoch)
 interval       | **integer** | no       | Candlestick period in minutes Possible values are `1, 5, 30, 60, 360, and 1440`


## Last 24 hours

> Example Request

```shell
curl "https://test-api.switcheo.network/v2/tickers/last_24_hours"
```

> Example Response

```json
[
  {
    "pair": "SWTH_NEO",
    "open": "0.00047221",
    "close": "0.00049769",
    "high": "1.2",
    "low": "0.0004563",
    "volume": "11897236125.0",
    "quote_volume": "19927606119564.0"
  },
  {
    "pair": "GAS_NEO",
    "open": "0.0",
    "close": "0.0",
    "high": "0.0",
    "low": "0.0",
    "volume": "0.0",
    "quote_volume": "0.0"
  }
]

```

Returns 24-hour data for all pairs and markets.

### HTTP Request

`GET /v2/tickers/last_24_hours`


## Last price

> Example request

```shell
curl "https://test-api.switcheo.network/v2/tickers/last_price"

```

> Example response

```json
{
  "GAS":
   {
      "NEO": "0.1"
   },
  "SWTH":
   {
      "NEO": "0.00050369"
   }
}

```

Returns last price of given symbol(s). Defaults to all symbols.

### HTTP Request

`GET v2/tickers/last_price`

### Request parameters

 Parameter      | Type      | Optional  | Description
--------------- | --------- | --------- | -----------
 symbols        | **array** | yes | Return the price for these symbols.
 bases          | **array** | yes | Return the price for pairs of these bases. Possible values are `NEO, GAS, SWTH, USD`.


## Pairs

> Example request

```shell
curl "https://test-api.switcheo.network/v2/tickers/pairs"

```

> Example response

```json
[
"GAS_NEO",
"SWTH_NEO",
]

```

Returns available currency [pairs](#currency_pairs) on Switcheo Exchange filtered by the `base` parameter. Defaults to all pairs.

### HTTP Request

`GET /v2/tickers/pairs`

### Request parameters

 Parameter      | Type      | Optional  | Description
--------------- | --------- | --------- | -----------
 bases          | **array** | yes | Provides pairs for these base symbols. Possible values are `NEO, GAS, SWTH, USD`.

## Contracts

> Example request

```shell
curl "https://test-api.switcheo.network/v2/tickers/contracts"

```

> Example response

```json
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

`GET /v2/tickers/contracts`
