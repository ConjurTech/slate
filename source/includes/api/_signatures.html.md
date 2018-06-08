# Signatures

As a decentralised exchange, Switcheo does not use any sort of password or api key.
For every transactions, digital signatures are required as a form of authentication.

## Creating a signature

> Code example

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

Switcheo uses [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm)
with [NIST P-256](http://safecurves.cr.yp.to/) as the curve parameter for signatures.

### Steps to create a signature:

1. Hash the message using [SHA-256](https://en.wikipedia.org/wiki/SHA-2).
2. Sign the message's hash with the signer's private key using ECDSA

Look to the right for an example of how to create a signature.

TODO: should we support der encoding?
