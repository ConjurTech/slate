# Authentication

As a decentralised exchange, Switcheo does not use any sort of password or API key.
Authentication is done by signing the **request payload** _or_ **blockchain transaction** using the **blockchain-specific**
digital signature with the user's private key.

Currently, all supported blockchains use the ellipitic curve digital signature algorithim (ECDSA). However, the curves
and hashing algorithim used for each blockchain differ slightly per blockchain.

| Blockchain | Signature Algo | Curve       | Hash Function |
| ---------- | -------------- | -----       | ------------- |
| NEO        | ECDSA          | NIST P-256  | SHA-256       |
| ETH        | ECDSA          | secp256k1   | SHA-3         |

In general, each action requires **two endpoints** to be called. The first endpoint returns a blockchain transaction (e.g. create order),
  while the second endpoint broadcasts the transaction (e.g. broadcast order).

As there is no transaction to be signed in the first step of an action, the message
  to be signed in the first step of an action is typically the request parameters as an **ordered** JSON **string**.

The message to be signed in the second step of an action is either a serialized blockchain transaction, or a blockchain
  message (e.g. `\x19Ethereum Signed Message:...`).


## Signing Messages

> **Signing a message**

```js
import { ec as EC } from 'elliptic'
import SHA256 from 'crypto-js/sha256'

export const sign = (message, privateKey) => {
  const messageHash = SHA256(message).toString()
  const elliptic = new EC('p256')
  const sig = elliptic.sign(messageHash, privateKey, null)
  const signature = Buffer.concat([
    sig.r.toArrayLike(Buffer, 'be', 32),
    sig.s.toArrayLike(Buffer, 'be', 32),
  ])
  return signature.toString('hex')
}
```

Each blockchain has a different method of signing arbitrary messages. Therefore, when signing messages as a form of
authentication, care must be taken to use the correct signing strategy.

## Signing Messages for NEO

> **Signing a message for NEO**

```js
const signNeoMessage = (message, privateKey) => {
  const hexedString = hexEncode(message)
  const messageLengthInHexString = `00${(message.length).toString(16)}`.slice(-2)
  // wrap string in required bytes (this will form a hex string which is also ledger compatible)
  const signableString = `010001f0${messageLengthInHexString}${hexedMessage}0000`
  return sign(signableString, privateKey) // this uses the `sign` method in the "Signing Messages" example
}

// Changes a string into it's hex equivalent
const hexEncode = (rawMessage) => {
  let result = ''
  for (let i = 0; i < rawMessage.length; i++) {
    const hex = rawMessage.charCodeAt(i).toString(16)
    result += `0${hex}`.slice(-2)
  }
  return result
}
```


To sign a message on the NEO blockchain:

1. Serialize the message as a hex string.
2. 0 pad the length of the message to a 2 digit hex string
3. Wrap the hex string and length of message in ledger compatible bytecode
4. Sign the transaction hash with your private key using ECDSA.

## Signing Request Parameters

> **Signing parameters in API requests**

```js
// API parameters to be signed
{
   "blockchain": "switcheochain",
   "apple": "Z",
   "zombies": "cool",
   "timestamp": 1529380859 // must be the current time
}

// note the serialization order
const message = "{\"apple\":\"Z\",\"blockchain\":\"switcheochain\",\"timestamp\":1529380859,\"zombies\":\"cool\"}"
const signature = sign(message, "<user's private key>") // this uses the `sign` method in the "Signing Messages" example
// => <signature> (e.g. "034d2ad7cc8a2598dd34...")

// Payload for the request
// Note that the public_key is only included here and not in `message`
{
   "blockchain": "switcheochain",
   "apple": "Z",
   "zombies": "cool",
   "timestamp": 1529380859,
   "signature": signature,
   "public_key": "3eab5444213a78d9450..."
}
```

When signing request parameters as a form of authentication, care must be taken that the message is serialized properly
before passing it to the signing function.

In particular,

1. While the JSON format is unordered, the stringified JSON that is passed to the signing function must be ordered **alphanumerically**
to ensure that both client and server can arrive at a deterministic hash.
2. The timestamp passed to the server is used as a nonce and must be within 1 minute of the server's time.

For example, the JSON request on the right should be serialized as shown. Both the public key and the signature of the
 serialized message should then be appended to the JSON request payload.

## Signing Transactions

Each blockchain serializes their transactions differently. Some blockchains may not require signing of transactions directly at all,
  and signing messages will suffice.

Where signing of transactions is neccessary, the blockchain specific serialization should be used. Where signing of blockchain
  messages are neccessary, the blockchain specific prefix should be used.

The transaction data should also be checked that it is in accordance with the intent of the user before
  serialization and signing. See each endpoint for more detail on how this can be done.

### NEO

To sign a transaction for the NEO blockchain, see [neon-js](https://github.com/CityOfZion/neon-js/blob/master/docs/api-transactions.md)
for an example.

### ETHEREUM

Prefix messages with: `\x19Ethereum Signed Message:`.
