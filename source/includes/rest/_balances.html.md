## Balances

**Description**

There are two types of balances.

Balance          | Description
---------------- | ----------
Wallet balance   | Number of tokens present in your wallet.
Contract balance | Number of tokens present in the Switcheo smart contract.

Trading on Switcheo Exchange can only be done using your contract balance.

### GET Contract Balances

List contract balances of the given address and contract.

The purpose of this endpoint is to allow convenient querying of a user's balance across
multiple blockchains, for example, if you want to retrieve a user's NEO and ethereum balances.

As such, when using this endpoint, balances for the specified addresses and contract hashes
will be merged and summed.

#### HTTP Request

> Example request:

```js
{
  "addresses": [
    "<address 1>"
  ],
  "contract_hashes": [
    "<contract hash 1>",
    "<contract hash 2>"
  ]
}

// The URL should be:
// /v2/balances?addresses[]=address_1&contract_hashes[]=contract_hash_1&contract_hashes[]=contract_hash_2
```

`/v2/balances`

#### URL parameters

 Parameter      | Type       | Required | Description
--------------- | ---------- | -------- | -----------
addresses       | **array** | yes       | Only return balances for these [addresses](#addresses)
contract_hashes | **array**  | yes       | Only return balances from these [contract hashes](#contracts).

#### Example

> Example response:

```js
{
  "confirming": {
    "GAS": [
      {
        "event_type": "withdrawal",
        "asset_id": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
        "amount": -100000000,
        "transaction_hash": null,
        "created_at": "2018-07-12T10:48:48.866Z"
      }
    ]
  },
  "confirmed": {
    "GAS": "47320000000.0",
    "SWTH": "421549852102.0",
    "NEO": "50269113921.0"
  },
  "locked": {
    "GAS": "500000000.0",
    "NEO": "1564605000.0"
  }
}
```

[Full list balances example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/balances/listBalancesExample.js)
