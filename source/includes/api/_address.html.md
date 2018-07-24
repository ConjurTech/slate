# Address

An `address` in Switcheo is always represented by a hex string, and should **never** be prefixed by `0x`.

## NEO

> Convert a public key to an address

```js
const { wallet } = require('@cityofzion/neon-js')
const address = wallet.getScriptHashFromPublicKey('<public key>')
```

For NEO, an `address` refers to the [RIPEMD160](https://en.wikipedia.org/wiki/RIPEMD) hash of the the user's public key.

An example implemention to derive an `address` from a user's public key can be found in the
[neon-js javascript library](https://github.com/CityOfZion/neon-js/blob/5d61c31a5d6e5e2e29095e08c70d23449810b509/src/wallet/core.js#L92).

Please note the difference in terminology between Switcheo and neon-js. Switcheo's `address` is equivalent to neon-js's `scriptHash`.

## Ethereum

For Ethereum, an `address` refers to the [Keccak](https://en.wikipedia.org/wiki/SHA-3) hash of the user's public key.
