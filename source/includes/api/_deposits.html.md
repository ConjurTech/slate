# Deposits

**Description**

Deposits allows movement of funds from your wallet into the Switcheo smart contract.
  This movement of funds is free of charge.
  Trading on Switcheo Exchange can only be done using funds that have been successfully deposited into the smart contract.

Deposits are not instantaneous.
  Once a deposit has been executed, funds in your wallet balance would be deducted by the amount of tokens you chose to deposit.
  Funds deducted from your wallet balance will be added to your contract balance but put on hold until
  Switcheo has determined that it has been successfully broadcast to the blockchain.
  
## List Deposits

> Example Request

```shell
TODO: complete this
```

> Example Response

```json
TODO: complete this
```

Retrieves all deposits made by the wallet address given in request parameters.

### HTTP Request

`GET /v2/deposits`

### Request Parameters

 Parameter      | Type       | optional | Description
--------------- | ---------- | -------- | ------------
 address        | **string** | no       |Only returns deposits made by this [address](#address).

## Create Deposit

> Payload

```json
{
  "blockchain": "neo",
  "asset_id": "SWTH",
  "amount": "100000000",
  "timestamp": 1531454353,
  "contract_hash": "eed0d2e14b0027f5f30ade45f2b23dc57dd54ad2",
}
```

> Signature

```js
 const messageToSign = "{\"blockchain\":\"neo\",
                         \"asset_id\":\"SWTH\",
                         \"amount\":\"100000000\",
                         \"timestamp\":1531454353,
                         \"contract_hash\":\"eed0d2e14b0027f5f30ade45f2b23dc57dd54ad2\",}"
sign(messageToSign) // see the Authentication section for an example of the `sign` method
// => 986961707a860eec03fe..
```

This endpoint creates a deposit which can be executed through [Execute Deposit](#execute-deposit).
  To be able to make a deposit, sufficient funds are required in the depositing wallet.
  Once a deposit is created, it has to be executed for actual movement of funds.

A [signature](#authentication) of the request payload has to be provided for this API call.
  An example of the message required to be signed for a given payload can be seen on the right.


<aside class="notice">
  Reminder: After calling this endpoint, the Execute Deposit endpoint has to be called for the deposit to be executed.
</aside>

### HTTP Request

`POST /v2/deposits`

### Request Parameters

 Parameter         | Type       | optional | Description
------------------ | ---------- | -------- | ------------
 blockchain        | **string** | no       | Blockchain that the token to deposit is on. Possible values are: `neo`.
 contract_hash     | **string** | no       | Switcheo Exchange [contract hash](#contract-hash) to execute the deposit on.
 asset_id          | **string** | no       | The asset symbol or ID to deposit. Note that this can be either the symbol ie. `SWTH` or the hash of the token ie. `ab38352559b8b203bde5fddfa0b07d8b2525e132` 
 amount            | **string** | no       | [Amount](#amounts) of tokens to deposit.
 address           | **string** | no       | The depositer's address (do not include in signature!)
 user_balance      | **string** | yes      | NEO exclusive parameter! The balances of this user - do not include in signature!
 timestamp         | **int**    | no       | The current timestamp to be used as a nonce as epoch **milliseconds**.
 signature         | **string** | no       | Signature of the request payload. See [Authentication](#authentication) for more details.

## Execute Deposit

> Example Deposit (NEO)

```json
{ 
  "id": "000583bf-4335-4244-885c-e0919d517786",
  "transaction": // Sign this and verify with provided sha256 parameter (below)
  { 
    "hash": "73506bc2e...",
    "sha256": "20a3011...", // Message digest for signature (neo)
    ...
  },
  ...
}
```

This is the second endpoint required to execute a deposit. After using the [Create Deposit](#create-deposit) endpoint,
  you will receive a response which requires additional signing. The method for signing depends on the blockchain
  the order is to be executed on.

##### NEO

The transaction included in the response of [Create Deposit](#create-deposit) should be [signed](#authentication).

The signature should then be attached as the `signature` parameter in the request payload.

Consult the [Authentication](#authentication) section to understand how to [sign a NEO transaction](#sign-neo-txn).

Note that a `sha256` parameter is provided for convenience to be used directly as part of the ECDSA signature process.
 *In production mode, this should be recalculated for additional security.*  

### HTTP Request

`POST /v2/deposits/:id/broadcast`

### Request Parameters

 Parameter  | Type       | Description
 ---------- | ---------- | -----------
 signatures | **string** | Signed response from create deposit endpoint. (See how and what to sign for different blockchains above)