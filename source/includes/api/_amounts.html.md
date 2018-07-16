# Amounts

> Convert a number to an asset amount

```js
const { BigNumber } = require('bignumber.js')
const value = 9999.12345678
const bigNumber = new BigNumber(value)
const assetMultiplier = Math.pow(10, NEO_ASSET_PRECISION)
return bigNumber.times(assetMultiplier).toFixed(0)
```

Some endpoints (e.g. create order) will require you to specify asset amounts as URL parameters (e.g. `offer_asset_amount`).

An amount is a positive number that must be converted to a string so as to preserve precision across the system.

It should also be specified up to the precision allowed by the given token,
and the decimal point itself should be dropped.
