# Signatures

Since Switcheo Exchange is a decentralised exchange, to perform certain instructions ie. [create order](#create-orders), digital signatures are required as a form of verification.
Switcheo Exchange uses [ECDSA](#https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) for signatures.

## Sign your transactions
export const sign = (msgHash, privateKey) => {
  const msgBuffer = Buffer.from(msgHash, 'hex')

  const elliptic = new EC('p256')
  const sig = elliptic.sign(msgBuffer, privateKey, null)
  const signature = Buffer.concat([
    sig.r.toArrayLike(Buffer, 'be', 32),
    sig.s.toArrayLike(Buffer, 'be', 32),
  ])

  return signature.toString('hex')
}
