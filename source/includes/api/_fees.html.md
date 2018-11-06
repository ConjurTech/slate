# Fees

This section consists of endpoints which allow the retrieval of fee data on Switcheo Exchange.

Authentication is not required for these endpoints.


## Fees

> Example response

```js
[
{
    "eth_address": "0x3be1f07cdb14d7a19a150dba525b09a6caefde97",
    "maker": {
        "default": 0
    },
    "taker": {
        "default": 0.0015
    },
    "native_fee_discount": 0.5,
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
    }
}
]

```

Returns fee data for various blockchains and pairs

### HTTP Request

`GET /v2/fees`

### Response parameters

Parameter                 | Description
------------------------- | ----------
eth_address               | Address of the Ethereum  Exchange Contract owner ????.
maker / default           | Default rate for maker orders, before discount (%)
taker / default           | Default rate for taker orders, before discount (%)
native_fee_discount       | Discount applied to fee for use of native token.
native_fee_asset_id       | NEO Contract hash of the Native Token (SWTH)
enforce_native_fee        | List of Asset tickers where fee must be paid in Native Tokens
native_fee_exchange_rates | List of Asset:Value tuples, containing the exchange rate in Native Token 
