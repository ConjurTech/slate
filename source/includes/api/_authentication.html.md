# Authentication

As a decentralised exchange, Switcheo does not use passwords or API keys.
Instead, authentication is done by signing the **request payload** _or_ **blockchain transaction** using the **blockchain-specific**
digital signature with the user's private key.

Currently, all supported blockchains uses the ellipitic curve digital signature algorithim (ECDSA). However, the curves and hashing algorithim used for each blockchain differ slightly per blockchain.

| Blockchain | Signature Algo | Curve       | Hash Function |
| ---------- | -------------- | -----       | ------------- |
| NEO        | ECDSA          | NIST P-256  | SHA-256       |
| ETH        | ECDSA          | secp256k1   | SHA-3         |

## Action Authentication
Two steps are required to perform an action.

1. In the first step:
  - Sign the parameters of the request using the user's private key
  - Send both the raw parameters and the result of signing the parameters to the first API endpoint
  - A response with either a message or transaction will be returned
2. In the second step:
  - Sign the returned message or transaction with the user's private key
  - Send the signed message or transaction to the second API endpoint

## Signing Messages for NEO

> Signing a message for NEO

```js
const { wallet } = require('@cityofzion/neon-js')
function signMessage(message, privateKey) {
  return wallet.generateSignature(message, privateKey)
}
signMessage('Hello', '<private key>')

```
[neon-js](https://github.com/CityOfZion/neon-js) can be used to sign messages for NEO.

[View implementation details](https://github.com/CityOfZion/neon-js/blob/cf5f92e4124c45a154449bf5852bcab28ddc1b32/src/wallet/core.js#L126)

## Signing Request Parameters

> Signing parameters for API requests

```js
// 1. Serialize parameters into a string
// Note that parameters must be ordered alphanumerically
const rawParams = { blockchain: 'neo', timestamp: 1529380859, apple: 'Z', }
const stringify = require('json-stable-stringify')
const parameterString = stringify(rawParams)
// parameterString: '{"apple":"Z","blockchain":"neo","timestamp":1529380859}'

// 2. Serialize the parameter string into a hex string
const Neon = require('@cityofzion/neon-js')
const parameterHexString = Neon.u.str2hexstring(parameterString)

// 3. Zero pad parameterHexString.length into a two digit hex string
const lengthHex = (parameterHexString.length / 2).toString(16).padStart(2, '0')
// lengthHex: 37

// 4. Concat lengthHex and parameterHexString
const concatenatedString = lengthHex + parameterHexString

// 5. Wrap concatenatedString in an empty neo transaction and serialize it
const serializedTransaction = '010001f0' + concatenatedString + '0000'

// 6. Sign serializedTransaction with the user's privateKey
const signature = signMessage(serializedTransaction, '<private key>')

// 7. Combine the raw parameters with the signature
// to get the final parameters to send
const parametersToSend = { ...rawParams, signature }
```

To perform an action, request parameters have to be signed using the steps outlined below:

1. Convert the API parameters into a string, with parameters **ordered alphanumerically**
2. Serialize the parameter string into a hex string
3. Zero pad the **length** of the result from (2) into a two digit hex string
4. Concat the result of (3) and (2)
5. Wrap the result of (4) in a neo transaction
6. Sign the result of (5) with the user's private key
7. Send the result of (6) together with the raw parameters to the API endpoint

### Example

[View a full example implementation](https://github.com/ConjurTech/switcheo-api-examples/blob/7f0097ffdab7ce6149d8512d26afc0a0b0a142d6/src/utils.js#L48)

## Signing Transactions

> Signing a transaction for NEO

```js
// Send the parameters for the first step of an action
// and retrieve the response
const response = ...
const { transaction } = response

// verify the transaction data to ensure that it matches the user's intention
...

const { tx } = require('@cityofzion/neon-js')

function signTransaction(transaction, privateKey) {
  const serializedTxn = tx.serializeTransaction(transaction, false)
  return signMessage(serializedTxn, privateKey)
}

// send the result to the second API endpoint
const signatureToSend = signTransaction(transaction, '<private key>')
```

The second step of an action usually requires the returned transaction to be signed, this is done by:

1. Checking the returned transaction data to ensure it matches the user's intention
2. Serializing the transaction, this can be done with [neon-js](https://github.com/CityOfZion/neon-js)
([View implementation details](https://github.com/CityOfZion/neon-js/blob/c6a169a82a4d037e00dccd424f53cdc818d6b3ae/src/transactions/core.js#L79))
3. Signing the serialized transaction with the user's private key
