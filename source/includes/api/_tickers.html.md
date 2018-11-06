# Tickers

This tickers section consists of endpoints that allow retrieval of market data on Switcheo Exchange.

Authentication is not required for these endpoints.


## Candlesticks

> Example request

```js
{
  "pair": "SWTH_NEO",
  "interval": 1,
  "start_time": 1531213200,
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

### Response parameters

Parameter    | Description
------------ | ----------
time         | Epoch time for the beginning of the interval (in seconds).
open         | Opening price at the start of the interval.
close        | Closing price at the end of the interval.
high         | Highest price during the interval.
low          | Lowest price during the interval.
volume       | Volume in Base Asset traded during the interval.
quote_volume | Volume in Quoted Asset traded during the interval.

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

### Response parameters

Parameter    | Description
------------ | ----------
time         | Epoch time for the beginning of the interval (in seconds).
open         | Opening price at the start of the interval.
close        | Closing price at the end of the interval.
high         | Highest price during the interval.
low          | Lowest price during the interval.
volume       | Volume in Base Asset traded during the interval.
quote_volume | Volume in Quoted Asset traded during the interval.

## Last price

> Example request

```js
{
  "symbols": ["SWTH","GAS"]
}
```

> Example response

```js
{
    "GAS": {
        "NEO": "0.31200000"
    },
    "SWTH": {
        "GAS": "0.00410000",
        "NEO": "0.00106600"
    }
}

```

Returns last price of the requested symbol(s) / base(s). Defaults to all symbols & bases.

### HTTP Request

`GET v2/tickers/last_price`

### Request parameters

 Parameter      | Type      | Required  | Description
--------------- | --------- | --------- | -----------
 symbols        | **array** | no        | Return the price for only these symbols.
 bases          | **array** | no        | Return the price for only these bases.

### Response parameters

Parameter    | Description
------------ | ----------
*base*       | JSON Object containing a list of *symbol:price* tuples
*symbol*     | Symbol Name
*price*      | Decimal Price of *symbol* in *base* units
