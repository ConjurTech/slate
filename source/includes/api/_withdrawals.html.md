# Withdrawals

**Description**

Withdrawals allow free movement of tokens from the Switcheo smart contract into your wallet.
  This movement of tokens is free of charge.

Once a withdrawal has been executed, tokens in your contract balance would be deducted.
  Tokens that are put on hold by orders cannot be withdrawn.

Withdrawals are not instantaneous.
  Tokens deducted from your contract balance will be added to your wallet balance but put on hold until
  the withdrawal has been fully executed.

## Create Withdrawal

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

This endpoint creates a withdrawal which can be executed through [Execute Withdrawal](#execute-withdrawal).
  To be able to make a withdrawal, sufficient funds are required in the contract balance.
  Once a withdrawal is created, it has to be executed for actual movement of funds.

A [signature](#authentication) of the request payload has to be provided for this API call.
  An example of the message required to be signed for a given payload can be seen on the right.


<aside class="notice">
  Reminder: After calling this endpoint, the Execute Withdrawal endpoint has to be called for the withdrawal to be executed.
</aside>

### HTTP Request

`POST /v2/withdrawals`

### Request Parameters

 Parameter         | Type       | optional | Description
------------------ | ---------- | -------- | ------------
 blockchain        | **string** | no       | Blockchain that the token to withdraw is on. Possible values are: `neo`.
 address           | **string** | no       | The depositer's address (do not include in signature!)
 contract_hash     | **string** | no       | Switcheo Exchange [contract hash](#contract-hash) to execute the deposit on.
 asset_id          | **string** | no       | The asset symbol or ID to deposit. Note that this can be either the symbol ie. `SWTH` or the hash of the token ie. `ab38352559b8b203bde5fddfa0b07d8b2525e132` 
 amount            | **string** | no       | [Amount](#amounts) of tokens to deposit.
 timestamp         | **int**    | no       | The current timestamp to be used as a nonce as epoch **milliseconds**.
 signature         | **string** | no       | Signature of the request payload. See [Authentication](#authentication) for more details.

 [View full create withdrawal example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/withdrawals/createWithdrawalExample.js)

## Execute Withdrawal

> Example Withdrawal (NEO)

```json
{ 
  "id": "1bff4e43-6787-484e-b811-1d539e8ec9a3", 
}
```

This is the second endpoint required to execute a withdrawal. After using the [Create Withdrawal](#create-withdrawal) endpoint,
  you will receive a response which requires additional signing. The method for signing depends on the blockchain
  the order is to be executed on.

##### NEO

The id given in the response of [Create Withdrawal](#create-withdrawal) should be put in an object with the timestamp
`{ id: <deposit-id>, timestamp: <current_timestamp> }` and [signed](#authentication).

The signature should then be attached as the `signature` parameter in the request payload.

Consult the [Authentication](#authentication) section to understand how to [sign a NEO transaction](#sign-neo-txn).

### HTTP Request

`POST /v2/deposits/:id/broadcast`

### Request Parameters

 Parameter  | Type       | optional | Description
 ---------- | ---------- | -------- | -----------
 signatures | **string** | no       | Signed response from create withdrawal endpoint. (See how and what to sign for different blockchains above)
 id         | **string** | no       | `id` parameter in the response from create withdrawal endpoint.
 timestamp  | **int**    | no       | The current timestamp to be used as a nonce as epoch **milliseconds**.

[View full execute withdrawal example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/withdrawals/executeWithdrawalExample.js)