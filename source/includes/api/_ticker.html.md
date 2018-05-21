# Ticker

## Get all tickers

```shell
curl "https://api.switcheo.network/v1/trades/tickers"
```

> The above command returns JSON structured like this:

```json
[
  {
    "symbol": "SWTH_NEO",
    "price_change": "0.00006001",
    "percentage_price_change": "6.384",
    "last_price": "0.00100000",
    "last_quantity": "1.77051096",
    "bid_price": "0.00100000",
    "bid_quantity": "3098.92243065",
    "ask_price": "0.00102099",
    "ask_quantity": "26012.13923092",
    "high_price": "0.00103344",
    "low_price": "0.00088115",
    "open_price": "0.00095300",
    "volume": "6141.83147280",
    "quote_volume": "6615989.55286128",
    "open_time": 1526531482,
    "close_time": 1526617882,
    "count": 966
   },
  {
    "symbol": "SWTH_GAS",
    "price_change": "0.00000025",
    "percentage_price_change": "0.009",
    "last_price": "0.00270000",
    "last_quantity": "565.50000322",
    "bid_price": "0.00265000",
    "bid_quantity": "1849.05660377",
    "ask_price": "0.00290900",
    "ask_quantity": "1997.22548719",
    "high_price": "0.00300000",
    "low_price": "0.00223900",
    "open_price": "0.00255666",
    "volume": "410.79460840",
    "quote_volume": "160170.15157377",
    "open_time": 1526531482,
    "close_time": 1526617882,
    "count": 174
    }
]
```

This endpoint retrieves all tickers from the Switcheo Exchange.

### HTTP Request

`https://api.switcheo.network/v1/trades/tickers`

### Query Parameters

None

## Get a Specific Ticker

```shell
curl "https://api.switcheo.network/v1/trades/tickers/SWTH_NEO"
```

> The above command returns JSON structured like this:

```json
{
    "symbol": "SWTH_NEO",
    "price_change": "0.00006001",
    "percentage_price_change": "6.384",
    "last_price": "0.00100000",
    "last_quantity": "1.77051096",
    "bid_price": "0.00100000",
    "bid_quantity": "3098.92243065",
    "ask_price": "0.00102099",
    "ask_quantity": "26012.13923092",
    "high_price": "0.00103344",
    "low_price": "0.00088115",
    "open_price": "0.00095300",
    "volume": "6141.83147280",
    "quote_volume": "6615989.55286128",
    "open_time": 1526531482,
    "close_time": 1526617882,
    "count": 966
   }
```

This endpoint retrieves a specific ticker from the Switcheo Exchange.


### HTTP Request

`https://api.switcheo.network/v1/trades/tickers?pair=SWTH_NEO`

### URL Parameters

Parameter | Description
--------- | -----------
  pair | The market pair to retrieve
