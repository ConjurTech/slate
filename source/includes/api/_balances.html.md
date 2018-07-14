# Balances

**Description**

There are two types of balances.

Balance          | Description
---------------- | ----------
Wallet balance   | Number of tokens present in your wallet.
Contract balance | Number of tokens present in the Switcheo smart contract.

Trading on Switcheo Exchange can only be done using your contract balance.

## List balances

> Example request:

```js
{
  "addresses": [
    "87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f"
  ],
  "contract_hashes": [
    "<contract hash 1>",
    "<contract hash 2>"
  ]
}
```

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


List contract balances of the given address and contract.

### HTTP Request
`/v2/balances`

### URL parameters

 Parameter      | Type       | Required | Description
--------------- | ---------- | -------- | -----------
addresses       | **string** | yes       | Only return balances for these [addresses](#address)
contract_hashes | **array**  | yes       | Only return balances from these [contract hashes](#contract-hash).

### Example

[Full list balances example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/balances/listBalancesExample.js)
