# Authentication

As a decentralised exchange, Switcheo does not use any sort of password or api key.
  Authentication is done in the form of signing the appropriate request or transaction using the blockchain 
  specific digital signature with the user's private key.

> Code example (neo)

```ReactJS
var EC = require('elliptic').ec;
export const sign = (hashedMsg, privateKey) => {
  const msgBuffer = Buffer.from(hashedMsg, 'hex')

  const elliptic = new EC('p256')
  const sig = elliptic.sign(msgBuffer, privateKey, null)
  const signature = Buffer.concat([
    sig.r.toArrayLike(Buffer, 'be', 32),
    sig.s.toArrayLike(Buffer, 'be', 32),
  ])

  return signature.toString('hex')
}
```
Eg Neo:
 
Neo uses [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm)
with [NIST P-256](http://safecurves.cr.yp.to/) as the curve parameter for signatures.

To sign a message for Neo:

1. Hash the message using [SHA-256](https://en.wikipedia.org/wiki/SHA-2).
2. Sign the message's hash with the signer's private key using ECDSA.

An example can be seen on the right.
