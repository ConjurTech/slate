# Authentication

As a decentralised exchange, Switcheo does not use any sort of password or API key.
Instead, authentication is done by signing the **request payload** _or_ **blockchain transaction** using the **blockchain-specific**
digital signature with the user's private key.

## Action Authentication
Two steps are required to perform an action.

1. In the first step:
  - Sign the parameters of the request using the user's private key
  - Send both the raw parameters and the signed parameters to the first API endpoint
  - A response with either a message or transaction will be returned
2. In the second step:
  - Sign the returned message or transaction with the user's private key
  - Send the signed message or transaction to the second API endpoint

## Signing Messages for NEO

> **Signing a message for NEO**

```js
const { wallet } = require('@cityofzion/neon-js')
function signMessage(message, privateKey) {
  return wallet.generateSignature(message, privateKey)
}
signMessage('Hello', 'b9609de8610cf33d832efaf9cd1e3f2c7601bbd7824fa109659e36be15a7a2ad')

```
[neon-js](https://github.com/CityOfZion/neon-js) can be used to sign messages for NEO.

[View implementation details](https://github.com/CityOfZion/neon-js/blob/cf5f92e4124c45a154449bf5852bcab28ddc1b32/src/wallet/core.js#L126)

## Signing Request Parameters

> **Signing parameters for API requests**

```js
// 1. Serialize parameters into a string, with parameters ordered alphanumerically
const rawParams = { blockchain: 'neo', timestamp: 1529380859, apple: 'Z', }
const stringify = require('json-stable-stringify')
const parameterString = stringify(rawParams)
// parameterString is '{"apple":"Z","blockchain":"neo","timestamp":1529380859}'

// 2. Serialize the parameter string into a hex string
const Neon = require('@cityofzion/neon-js')
const parameterHexString = Neon.u.str2hexstring(parameterString)
// parameterHexString is 7b226170706c65223a225a222c22626c6f636b636861696e223a226e656f222c2274696d657374616d70223a313532393338303835397d

// 3. Zero pad parameterHexString.length to a 2 digit hex string
const lengthHex = (parameterHexString.length / 2).toString(16).padStart(2, '0')
// lengthHex is 37

// 4. Concat lengthHex and parameterHexString
const concatenatedString = lengthHex + parameterHexString

// 5. Wrap concatenatedString in ledger compatible bytecode
const ledgerCompatibleString = '010001f0' + concatenatedString + '0000'

// 6. Sign ledgerCompatibleString with the user's privateKey
const signature = signMessage(ledgerCompatibleString, 'b9609de8610cf33d832efaf9cd1e3f2c7601bbd7824fa109659e36be15a7a2ad')

// 7. Combine the raw parameters with the signature to get the final parameters to send
const parametersToSend = { ...rawParams, signature }
```
Actions require request parameters to be signed using the below process:

1. Convert the API parameters into a string, with parameters ordered alphanumerically
2. Serialize the parameter string into a hex string
3. Zero pad the **length** of the result from (2) to a 2 digit hex string
4. Concat the result of (3) and (2)
5. Wrap the result of (4) in ledger compatible bytecode
6. Sign the result of (5) with the user's private key
7. Send the result of (6) together with the raw parameters to the API endpoint

## Signing Transactions

> **Signing a transaction for NEO**

```js
const { tx } = require('@cityofzion/neon-js')

function signTransaction(transaction, privateKey) {
  const txnSerialized = tx.serializeTransaction(transaction, false)
  return signMessage(txnSerialized, privateKey)
}

const response = ... // Send the parameters for the first step of an action and retrieve the response
const { transaction } = response

... // verify the transaction data to ensure that it matches the user's intention

signTransaction(transaction, 'b9609de8610cf33d832efaf9cd1e3f2c7601bbd7824fa109659e36be15a7a2ad')
```

The second step of an action may require a transaction to be signed, this is done by:

1. Checking the transaction data to ensure it matches the user's intention
2. Serializing the transaction, this can be done with [neon-js](https://github.com/CityOfZion/neon-js)
([View implementation details](https://github.com/CityOfZion/neon-js/blob/c6a169a82a4d037e00dccd424f53cdc818d6b3ae/src/transactions/core.js#L79))
3. Signing the serialized transaction with the user's private key
