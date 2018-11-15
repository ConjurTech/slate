## Deposits

Deposits are a transfer of tokens from your wallet into the Switcheo smart contract.

### Overview

Trading on Switcheo Exchange can only be done using funds that have been successfully deposited into the smart contract.

Deposits are not instantaneous.
Once a deposit has been executed, funds in your wallet balance would be deducted by the amount of tokens you chose to deposit.

Funds deducted from your wallet balance will be added to your contract balance but put on hold until
Switcheo has determined that it has been successfully broadcasted to the blockchain.

### Testing with TestNet Faucet

For the convenience of testing API endpoints, tokens can be received through our TestNet faucet.
To use the faucet:

1. Go to [https://legacy.switcheo.exchange/](https://legacy.switcheo.exchange/)
2. Click on the TestNet/MainNet selector at the bottom of the page
3. Select TestNet V2
4. Click on **WALLET LOGIN** to login
5. Click on the **FAUCET** button to receive tokens for testing

### Create Deposit

> Create a deposit

```js
function createDeposit ({ blockchain, address, assetID, amount, privateKey }) {
  const signableParams = { blockchain, assetID, amount, timestamp: getTimestamp(),
                           contractHash: CONTRACT_HASH }
  const signature = signParams(signableParams, privateKey)
  const apiParams = { ...signableParams, address, signature }
  return api.post(API_URL + '/deposits', apiParams)
}

// NOTE: in this example, the parameters can be in camel case because
// the `signParams` and `api.post` method automatically convert param keys
// to snake case
createDeposit({
  blockchain: 'neo',
  address: user.address,
  assetID: 'SWTH',
  amount: toNeoAssetAmount(7),
  privateKey: user.privateKey
})
```

> Example request

```js
{
  "blockchain": "neo",
  "asset_id": "SWTH",
  "amount": "100000000",
  "timestamp": 1531543361074,
  "contract_hash": "<contract hash>",
  "address": "87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f",
  "signature": "<signature>"
}
```

> Example response

```js
{
  "id": "ad5a6e05-d992-47c0-9f52-79ca173dccd1",
  "transaction": {
    "hash": "a53f26b21f2ede25909e8ac3bf094ac3318e31d5cd654bde4ba734478f1368b2",
    "sha256": "caa6727a795ef2dba75c7ea143b6020ffc0d2d4164d7be9639ebb9a1bbd7a6d1",
    "type": 209,
    "version": 1,
    "attributes": [
      [
        null
      ]
    ],
    "inputs": [
      [
        null
      ]
    ],
    "outputs": [
      [
        null
      ]
    ],
    "scripts": [],
    "script": "0800e1f505000000001432e125258b7db0a0dffde5bd03b2b859253538ab145f8e3fcb095b55f53c44a1cab6e9c1a0da67cf8753c1076465706f73697467d24ad57dc53db2f245de0af3f527004be1d2d0ee",
    "gas": 0
  },
  "script_params": {
    "scriptHash": "eed0d2e14b0027f5f30ade45f2b23dc57dd54ad2",
    "operation": "deposit",
    "args": [
      "5f8e3fcb095b55f53c44a1cab6e9c1a0da67cf87",
      "32e125258b7db0a0dffde5bd03b2b859253538ab",
      100000000
    ]
  }
}
```

This endpoint creates a deposit which can be executed through [Execute Deposit](#execute-deposit).
To be able to make a deposit, sufficient funds are required in the depositing wallet.

<aside class="notice">
  IMPORTANT: After calling this endpoint, the Execute Deposit endpoint has to be called for the deposit to be executed.
</aside>

#### HTTP Request

`POST /v2/deposits`

#### Request Parameters

 Parameter         | Type       | Required | Description
------------------ | ---------- | -------- | ------------
 blockchain        | **string** | yes       | Blockchain that the token to deposit is on. Possible values are: `neo`.
 asset_id          | **string** | yes       | The [asset symbol or ID](#supported-assets) to deposit.
 amount            | [amount](#amounts) | yes       | [Amount](#amounts) of tokens to deposit.
 contract_hash     | **string** | yes       | Switcheo Exchange [contract hash](#contracts) to execute the deposit on.
 timestamp         | [timestamp](#timestamp)    | yes       | The exchange's timestamp to be used as a nonce.
 signature         | **string** | yes       | Signature of the request payload. See [Authentication](#authentication) for more details.
 address           | [address](#addresses) | yes       | The depositer's [address](#addresses). **Do not include this in the parameters to be signed.**


#### Example

[Full create deposit example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/deposits/createDepositExample.js)

### Execute Deposit for ETH

> Execute a deposit

```js
const Web3 = require('web3')
const provider = new Web3.providers.HttpProvider('https://mainnet.infura.io')
const web3 = new Web3(provider)

function executeDeposit ({ deposit, privateKey }) {
  const { rawTransaction } = await web3.eth.accounts.signTransaction(deposit.transaction, privateKey)
  const transactionHash = web3.utils.keccak256(rawTransaction)

  web3.eth.sendSignedTransaction(rawTransaction)

  const url = `${API_URL}/deposits/${deposit.id}/broadcast`
  return api.post(url, { transactionHash })
}
```

> Example request

```js
{
  "transaction_hash": "<transaction_hash>"
}
```

This is the second endpoint required to execute a deposit.
After using the [Create Deposit](#create-deposit) endpoint,
you will receive a response which contains a `transaction`.

The `transaction` in the response should be signed and directly broadcasted by the client,
the transaction hash of the broadcasted transaction should then be sent to the broadcast endpoint.

#### HTTP Request

`POST /v2/deposits/:id/broadcast`

#### Request Parameters

 Parameter  | Type       | Description
 ---------- | ---------- | -----------
 transaction_hash | **string** | The transaction hash of the broadcasted transaction

 [Full execute deposit example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/deposits/executeDepositExample.js)

### Execute Deposit for NEO

> Execute a deposit

```js
function executeDeposit ({ deposit, privateKey }) {
  const signature = signTransaction(deposit.transaction, privateKey)
  const url = `${API_URL}/deposits/${deposit.id}/broadcast`
  return api.post(url, { signature })
}
```

> Example request

```js
{
  "signature": "<signature>"
}
```

This is the second endpoint required to execute a deposit.
After using the [Create Deposit](#create-deposit) endpoint,
you will receive a response which requires additional signing.

The signature should then be attached as the `signature` parameter in the request payload.

Note that a `sha256` parameter is provided for convenience to be used directly as part of the ECDSA signature process.
 *In production mode, this should be recalculated for additional security.*

#### HTTP Request

`POST /v2/deposits/:id/broadcast`

#### Request Parameters

 Parameter  | Type       | Description
 ---------- | ---------- | -----------
 signature | **string** | Signed response from create deposit endpoint. (See how and what to sign for different blockchains above)

 [Full execute deposit example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/deposits/executeDepositExample.js)
