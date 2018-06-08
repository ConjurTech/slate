# Makes

* A make represents the preparation of an [offer](#offers).
* Makes are generated when [orders](#orders) that do not fill any offer are [created](#create-orders).
* When an order containing a make is [broadcast](#broadcast-orders), an offer will be created.


## The make object

TODO: Describe

> Example of a make

```json
{
  "id": "fdecd44e-94f4-41bb-b4b8-e21c59076666",
  "offer_hash": "113b5c2894cc1074513ed90832c7dd83085aa236ff6a74145fd96d7173234b31",
  "available_amount": "0",
  "offer_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
  "offer_amount": "22973785950",
  "want_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "want_amount": "974547",
  "filled_amount": "22973785950",
  "txn": null,
  "cancel_txn": null,
  "price": "0.000042419956472172145401224128668265928541917",
  "status": "success",
  "created_at": "2018-06-05T10:07:35.077Z",
  "transaction_hash": "b9a77a943a0f4803081d656d3a556516757b603ca094aa2922be00b8db020a8d",
  "trades": [
    {
      "id": "abd4a797-2a35-42d1-ba22-ca9219867e3c",
      "status": "success",
      "want_amount": "500000513",
      "filled_amount": "21209",
      "fee_amount": "750000",
      "fee_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
      "price": "0.00004242",
      "created_at": "2018-06-05T10:08:39.542Z"
    }
  ]
}
```
