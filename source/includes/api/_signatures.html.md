# Signatures

Ad a decentralised exchange, Switcheo does not use any sort of password or api key.
For every transactions, digital signatures are required as a form of authentication.

## Creating a signature
Switcheo uses [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) for signatures.

```ReactJS
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

### Hashing a message

Before signing, messages are required to be hashed using [SHA-256](https://en.wikipedia.org/wiki/SHA-2
