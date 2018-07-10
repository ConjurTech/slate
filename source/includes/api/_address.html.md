# Address

An `address` in Switcheo is always represented by a hex string. An `address` can refer to a user account,
or a smart contract. **An address should never be prefixed by `0x`**.

##### NEO

For NEO, an `address` refers to the [RIPEMD160](https://en.wikipedia.org/wiki/RIPEMD) hash of the verification script for the user's public key.

An example implemention to derive an `address` from a user public key can be found in the
[neon-js javascript library](https://github.com/CityOfZion/neon-js/blob/5d61c31a5d6e5e2e29095e08c70d23449810b509/src/wallet/core.js#L92). *(Note the difference in terminology: Switcheo's `address` refers to `scriptHash` in neon-js)*

Where the `address` refers to a deployed contract, this is simply the RIPEMD160 hash of the deployed contract (bytes).

Note that as a deployed contract's verification script is in essence itself, there is no actual difference in calculating
 the `address` of a user public key versus a deployed contract.

An `address` is always 20 bytes (40 hex digits) long in NEO.

##### ETHEREUM

For Ethereum, an `address` refers to the [Keccak](https://en.wikipedia.org/wiki/SHA-3) hash of the user's public key.

Where `address` refers to a deployed contract, it is the last 20 bytes of the transaction hash of the deployment
  transaction, and depends only on the sender `address` and `nonce`.

An `address` is always 20 bytes (40 hex digits) long in Ethereum.
