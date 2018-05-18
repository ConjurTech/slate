---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/lord/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# Introduction

Welcome to ze Switcheo Exchange API.

The Switcheo Exchange API grants access to real-time or historical trade information and also allows execution of orders on the Switcheo Exchange. 
 

You can visit the Switcheo Exchange [here](https://switcheo.exchange)

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


# Trades

## Get trades

```shell
curl "https://api.switcheo.network/v1/trades"
```

> The above command returns JSON structured like this:

```json
[
  {
  "id": "2afddfc8-d49b-49be-8079-4aeea693940c",
  "blockchain": "neo",
  "block_number": 2283025,
  "transaction_hash": "a1716c2906bdd70612159c36f4315544e427738aaae581bc23df0cdeaf907353",
  "contract_hash": "01bafeeafe62e651efc3a530fde170cf2f7b09bd",
  "event_time": "2018-05-18T09:37:18.000Z",
  "address": "58ea964070e60c4c055d549b155b77e56d8db40d",
  "offer_hash": "ed03574d60014e66c881fb459b480aad60c866ad31f42cd30d12c0454cc54b43",
  "offer_asset_id": "45d493a6f73fa5f404244a5fb8472fc014ca5885",
  "want_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "filled_amount": 1883290,
  "offer_amount": 640575043,
  "want_amount": 1883290,
  "created_at": "2018-05-18T09:37:45.876Z",
  "updated_at": "2018-05-18T09:37:45.876Z"
  },
  {
  "id": "81a6bbaf-d33e-4845-a2f1-50c65e5b0f91",
  "blockchain": "neo",
  "block_number": 2283021,
  "transaction_hash": "e8f74d7e7c6d24a47aa7b4f3f8567e3b1b0c49b9142cfedf02263fb9fcca2095",
  "contract_hash": "01bafeeafe62e651efc3a530fde170cf2f7b09bd",
  "event_time": "2018-05-18T09:35:57.000Z",
  "address": "58ea964070e60c4c055d549b155b77e56d8db40d",
  "offer_hash": "43dd97fd90634236f64da66695350bac3d8ea43ef062c3b64a33698e7a0f5266",
  "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "want_asset_id": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
  "filled_amount": 540131095,
  "offer_amount": 500000000,
  "want_amount": 1315789369,
  "created_at": "2018-05-18T09:36:27.618Z",
  "updated_at": "2018-05-18T09:36:27.618Z"
  }
]
```

This endpoint retrieves trades from the Switcheo Exchange filterd by the params provided.

### HTTP Request

`https://api.switcheo.network/v1/trades/tickers`
                     
### URL Parameters

Parameter | Description
--------- | -----------
  limit | Limit number of trades returned
  contract_hash | Only return trades for this contract hash
  transaction_hash | Only return trades with this transaction hash
  block_number | Only return trades after this block number
  from | Only return trades after this time
  to | Only return trades before this time
  last_before | Only return one trade before this time
  blockchain | Only return trades from this blockchain

# Orders

# Offers
