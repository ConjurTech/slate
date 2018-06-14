# Balances

## Description

There are two types of balances:
 
* Wallet balance represents funds present in your wallet.
* Contract balance represents funds present in contract balance.

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
				"asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
				"amount": 10990729,
				"transaction_hash": "333e3a3c1213f9f4d24ad6283374df55ac4a4d751556cdd634e188221b09e84f",
				"created_at": "2018-06-11T12:07:20.442Z"
			},
			{
				"event_type": "transferred",
				"asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
				"amount": 10990729,
				"transaction_hash": "2877692111cd705934fb8ce54fc09d448688080b08f5d4b1fa3011fb6a4ae854",
				"created_at": "2018-06-12T02:35:01.639Z"
			},
			{
				"event_type": "transferred",
				"asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
				"amount": 11464496,
				"transaction_hash": "b5a93e29b954919640f7c390211a3bf666e7779d32b04000c57e56aaf19bf1a0",
				"created_at": "2018-06-13T07:33:57.984Z"
			},
			{
				"event_type": "transferred",
				"asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
				"amount": 10990729,
				"transaction_hash": "0a41a03cb89e84c9daeae981797aa221d446cec2b6b8002eb2b4e0472f951975",
				"created_at": "2018-06-13T07:33:58.007Z"
			}
		],
		"SWTH": [
			{
				"event_type": "transferred",
				"asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
				"amount": -89489747,
				"transaction_hash": "333e3a3c1213f9f4d24ad6283374df55ac4a4d751556cdd634e188221b09e84f",
				"created_at": "2018-06-11T12:07:20.448Z"
			},
			{
				"event_type": "transferred",
				"asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
				"amount": -89489747,
				"transaction_hash": "2877692111cd705934fb8ce54fc09d448688080b08f5d4b1fa3011fb6a4ae854",
				"created_at": "2018-06-12T02:35:01.645Z"
			},
			{
				"event_type": "transferred",
				"asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
				"amount": -93347300,
				"transaction_hash": "b5a93e29b954919640f7c390211a3bf666e7779d32b04000c57e56aaf19bf1a0",
				"created_at": "2018-06-13T07:33:57.990Z"
			},
			{
				"event_type": "transferred",
				"asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
				"amount": -89489747,
				"transaction_hash": "0a41a03cb89e84c9daeae981797aa221d446cec2b6b8002eb2b4e0472f951975",
				"created_at": "2018-06-13T07:33:58.013Z"
			}
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

