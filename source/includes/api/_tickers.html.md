# Tickers

The tickers section consists of endpoints that allow retrieval of market data on Switcheo Exchange.
Authentication is not required for these endpoints.


## Candlesticks

> Example request

```js
{
  "pair": "SWTH_NEO",
  "interval": 1,
  "star_time": 1531213200,
  "end_time": 1531220400
}
```

> Example response

```js
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

 Parameter      | Type        | Required  | Description
--------------- | ----------- | --------- | ------------------------------------
 pair           | **string**  | yes       | Only show chart data of this [trading pair](#pairs)
 start_time     | **integer** | yes       | Start of time range for data in epoch **seconds**
 end_time       | **integer** | yes       | End of time range for data in epoch **seconds**
 interval       | **integer** | yes       | Candlestick period in minutes Possible values are: 1, 5, 30, 60, 360, 1440


## Last 24 hours

> Example response

```js
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

> Example response

```js
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

 Parameter      | Type      | Required  | Description
--------------- | --------- | --------- | -----------
 symbols        | **array** | no       | Return the price for these symbols.
 bases          | **array** | no       | Return the price for pairs of these bases. Possible values are `NEO, GAS, SWTH, USD`.
