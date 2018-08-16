# Important Information

Subject                   | Things to note
------------------------- | ----------
[Addresses](#addresses)   | Addresses must be in the correct format.
[Amounts](#amounts)       | Amounts must be converted to the correct format.
[Timestamp](#timestamp)   | If a timestamp parameter is required, then it should first be fetched from the server

## Addresses
An `address` in Switcheo is always represented by a hex string, and should **never** be prefixed by `0x`.

## NEO Addresses

> Getting the user's address

```js
const { wallet } = require('@cityofzion/neon-js')
wallet.getScriptHashFromPublicKey('031c37f6cce9627dc635d026deddd1200013c1b78dac767cdb507339a831183fd9')
// Result: 87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f

// you can also retrieve the script hash from a wallet address directly with:
wallet.getScriptHashFromAddress('AQV8FNNi2o7EtMNn4etWBYx1cqBREAifgE')
// Result: 87cf67daa0c1e9b6caa1443cf5555b09cb3f8e5f
```

For NEO, an `address` refers to the [RIPEMD160](https://en.wikipedia.org/wiki/RIPEMD) hash of the the user's public key.

An example implemention to derive an `address` from a user's public key can be found in the
[neon-js javascript library](https://github.com/CityOfZion/neon-js/blob/5d61c31a5d6e5e2e29095e08c70d23449810b509/src/wallet/core.js#L92).

Please note the difference in terminology between Switcheo and neon-js. Switcheo's `address` is equivalent to neon-js's `scriptHash`.

## Amounts

When specifying amounts as request parameters, the amounts should first be converted by following these steps:

1. Multiply the original amount by 10 to the power of the precision allowed by the given token.
2. Drop any decimals, and convert the resulting integer to a string

For example, if the token's precision is `8`, and the original amount is `9.12345678`:

1. Following the above steps: `9.12345678 * (10 ^ 8)` = `912345678.00`
2. Drop any decimals to get: `912345678`
3. Convert the result to a string to get `"912345678"`
