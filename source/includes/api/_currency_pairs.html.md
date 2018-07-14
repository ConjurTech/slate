# Currency Pairs

When trading on Switcheo Exchange, markets are represented as currency pairs.

Currency pairs in the Switcheo API are written in the format: `<trade>_<base>`, where `trade` is the currency
that is being bought or sold, and `base` is the base currency for the market that is given or taken in return, respectively.

For example:

- When **selling** on `SWTH_NEO`, it means the user is selling `SWTH` for `NEO`.
- When **buying** on `SWTH_NEO`, it means the user is buying `SWTH` for `NEO`.

The valid `base` currencies are currently:
`NEO`, `GAS`, `SWTH`.
