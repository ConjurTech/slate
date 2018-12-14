## Authentication

As a non-custodian exchange, Switcheo does not use passwords or API keys as we do not have custody of user funds.
Instead, authentication is done by signing the **request payload** _or_ **blockchain transaction** using the **blockchain-specific** digital signature with the user's private key.

### Overview

Currently, all supported blockchains uses the ellipitic curve digital signature algorithim (ECDSA). However, the curves and hashing algorithim used for each blockchain differs slightly.

| Blockchain | Signature Algo | Curve       | Hash Function  |
| ---------- | -------------- | -----       | -------------- |
| NEO        | ECDSA          | NIST P-256  | SHA-256        |
| ETH        | ECDSA          | secp256k1   | SHA-3 (Keccak) |

<aside class="notice">
  IMPORTANT: Two steps are required to perform an authenticated action.
</aside>

1. In the first step:
  - Sign the parameters of the request using the user's private key
  - Send both the raw parameters and the result of signing the parameters to the first API endpoint
  - A response with either a message or transaction will be returned

2. In the second step:
  - Sign the returned message or transaction with the user's private key
  - Send the signed message or transaction to the second API endpoint

### Signing Messages for ETH

> Signing a message for ETH

```js
const Web3 = require('web3')
const web3 = new Web3()

function signMessage(message, privateKey) {
  return web3.eth.accounts.sign(message, privateKey).signature
}
signMessage('Hello', '<private key>')

```

To sign a message for ETH, the message should be hex encoded, and enveloped as
`"\x19Ethereum Signed Message:\n" + message.length + message` before being signed.

[web3.js](https://github.com/ethereum/web3.js/) can be used to sign messages for ETH.

[View documentation](https://web3js.readthedocs.io/en/1.0/web3-eth-accounts.html#sign)

[View implementation details](https://github.com/ethereum/web3.js/blob/1.0/packages/web3-eth-accounts/src/index.js#L255)

#### Signing Request Parameters

> Signing parameters for API requests

```js
// 1. Serialize parameters into a string
// Note that parameters must be ordered alphanumerically
const rawParams = { blockchain: 'neo', timestamp: 1529380859, apple: 'Z', }
const stableStringify = require('json-stable-stringify')
const parameterString = stableStringify(rawParams)
// parameterString: '{"apple":"Z","blockchain":"neo","timestamp":1529380859}'

// 2. Sign the parameterString with the user's privateKey
const signature = signMessage(parameterString, '<private key>')

// 3. Combine the raw parameters with the signature
// to get the final parameters to send
const parametersToSend = { ...rawParams, signature }
```

To perform an action, request parameters have to be signed to generate a signature
parameter. This signature parameter should then be sent together with the other parameters in the request.

1. Convert the API parameters into a string, with parameters **ordered alphanumerically**
2. Sign the result of (1) with the user's private key
3. Send the result of (2) together with the raw parameters to the API endpoint

#### Example

Using the following parameters as an example:

`{ blockchain: 'eth', timestamp: 1529380859, apple: 'Z' }`

1. Convert the parameters into a string with parameters ordered alphanumerically:
`{"apple":"Z","blockchain":"eth","timestamp":1529380859}`
2. Let the user's private key be
<code style=" hyphens: none;">0x98c193239bff9eb53a83e708b63b9c08d6e47900b775402aca2acc3daad06f24</code>
3. Sign the result from (1) with the private key in (2) to get
<code style=" hyphens: none;">
0xbcff177dba964027085b5653a5732a68677a66c581f9c85a18e1dc23892c72d86c0b65336e8a17637fd1fe1def7fa8cbac43bf9a8b98ad9c1e21d00e304e32911c
</code>

### Signing Transactions for ETH

> Signing a transaction for ETH

```js
// Send the parameters for the first step of an action
// and retrieve the response
const response = ...
const { transaction } = response

// verify the transaction data to ensure that it matches the user's intention
...

const Web3 = require('web3')
const web3 = new Web3()

function signTransaction(transaction, privateKey) {
  return web3.eth.accounts.signMessage(transaction.message, user.privateKey)
}

// send the result to the second API endpoint
const signatureToSend = signTransaction(transaction, '<private key>')
```

The second step of an action usually requires the returned transaction to be signed. This is done by:

1. Checking the returned transaction data to ensure it matches the user's intention
2. Signing the `message` in the transaction with the user's private key
3. An exception to this is the deposit endpoint, which requires the client to sign and broadcast the transaction, this is covered in more detail in the [Deposits](#deposits) section.

### Signing Messages for NEO

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

#### Signing Request Parameters

> Signing parameters for API requests

```js
// 1. Serialize parameters into a string
// Note that parameters must be ordered alphanumerically
const rawParams = { blockchain: 'neo', timestamp: 1529380859, apple: 'Z', }
const stableStringify = require('json-stable-stringify')
const parameterString = stableStringify(rawParams)
// parameterString: '{"apple":"Z","blockchain":"neo","timestamp":1529380859}'

// 2. Serialize the parameter string into a hex string
const Neon = require('@cityofzion/neon-js')
const parameterHexString = Neon.u.str2hexstring(parameterString)

// 3. Zero pad (parameterHexString.length / 2) into a two digit hex string
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

To perform an action, request parameters have to be signed to generate a signature
parameter. This signature parameter should then be sent together with the other parameters in the request.

1. Convert the API parameters into a string, with parameters **ordered alphanumerically**
2. Serialize the parameter string into a hex string
3. Zero pad the **length / 2** of the result from (2) into a two digit hex string
4. Concat the result of (3) and (2)
5. Wrap the result of (4) in a neo transaction
6. Sign the result of (5) with the user's private key
7. Send the result of (6) together with the raw parameters to the API endpoint

#### Example

Using the following parameters as an example:

`{ blockchain: 'neo', timestamp: 1529380859, apple: 'Z' }`

1. Convert the parameters into a string with parameters ordered alphanumerically:
`{"apple":"Z","blockchain":"neo","timestamp":1529380859}`
2. Serialize the parameter into a hex string to get:
`7b226170706c65223a225a222c22626c6f636b636861696e223a226e656f222c2274696d657374616d70223a313532393338303835397d`
3. The length of this string is `110`, divide this by 2 to get `55`
4. Convert `55` to hexadecimal to get `37`
5. Zero pad `37` into a two digit string if needed. In this case `37` is already two digits so
no padding is needed, but if the value was something like `8` then it should be padded to become `08`
6. Form a string by concatenating `37`, and the result of (2) to get:
`377b226170706c65223a225a222c22626c6f636b636861696e223a226e656f222c2274696d657374616d70223a313532393338303835397d`
7. Prepend `010001f0` and append `0000` to (6) to get:
`010001f0377b226170706c65223a225a222c22626c6f636b636861696e223a226e656f222c2274696d657374616d70223a313532393338303835397d0000`
8. Let the user's private key be
<code style=" hyphens: none;">cd7b887c29a110e0ce53e81d6dd02805fc7b912718ff8b6659d8da42887342bd</code>
9. Sign the result from (7) with the private key in (8) to get
<code style=" hyphens: none;">
f3831797cbd4244d1ccffafc42739e662e8b06c7a6f98efe5155d0eab1cf5c50fbac6d2a4c4487cbf71498b81e1e9478f06bef02d32da5d8f8bb7fdfc449879a
</code>

[View a full example implementation](https://github.com/ConjurTech/switcheo-api-examples/blob/7f0097ffdab7ce6149d8512d26afc0a0b0a142d6/src/utils.js#L48)

### Signing Transactions for NEO

> Signing a transaction for NEO

```js
// Send the parameters for the first step of an action
// and retrieve the response
const response = ...
const { transaction } = response

// verify the transaction data to ensure that it matches the user's intention
...

const { tx, wallet } = require('@cityofzion/neon-js')

function signTransaction(transaction, privateKey) {
  const serializedTxn = tx.serializeTransaction(transaction, false)
  return wallet.generateSignature(serializedTxn, privateKey)
}

// send the result to the second API endpoint
const signatureToSend = signTransaction(transaction, '<private key>')
```

The second step of an action usually requires the returned transaction to be signed, this is done by:

1. Checking the returned transaction data to ensure it matches the user's intention
2. Serializing the transaction, this can be done with [neon-js](https://github.com/CityOfZion/neon-js)
([View implementation details](https://github.com/CityOfZion/neon-js/blob/c6a169a82a4d037e00dccd424f53cdc818d6b3ae/src/transactions/core.js#L79))
3. Signing the serialized transaction with the user's private key
