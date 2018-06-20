# Balances

**Description**

There are two types of balances.
  Wallet balance represents tokens present in your wallet.
  Contract balance represents tokens present in the Switcheo smart contract.
  
Trading on Switcheo Exchange can only be done using your contract balance.

## Get the balance of an address

> Example request:

```shell
curl https://test-api.switcheo.network/v2/orders \ 
  -d address=ede2491ec91f3beb24778572c97b1c1dd6495df8 \
  -d contract_hashes[]=9c9d2fac35987621e252981e06762895b09eb035 \
```

> Example response:

```json
{
	"confirming": {
		"NEO": [
			{
				"event_type": "transferred",
				"asset_id": "c56f33fc6ecfcd0...",
				"amount": 10990729,
				"transaction_hash": "333e3a3c12...",
				"created_at": "2018-06-11T12:07:20.442Z"
			},
			...
		],
		"SWTH": [
			{
				"event_type": "transferred",
				"asset_id": "ab383525...",
				"amount": -89489747,
				"transaction_hash": "333e3a3c1213f9...",
				"created_at": "2018-06-11T12:07:20.448Z"
			},
			...
		]
	},
	"confirmed": {
		"GAS": "100000000.0",
		"SWTH": "7761229601.0",
		"NEO": "230808652.0"
	}
}
```


This endpoint gets contract balances of the given address and contract.

### HTTP Request
`https://api.switcheo.network/v2/balances`

### Url parameters

 Parameter      | Type                  | Description
--------------- | --------------------- | -----------
address         | **string**            | The address to get balances for
contract_hashes | **array**             | Switcheo [contract hash](#contract-hash). Only returns balances from this contract hash.

