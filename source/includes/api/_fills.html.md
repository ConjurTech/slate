# Fills

> Example of a fill

```json
{
  "id": "f9a7e1e0-9a73-43a9-87b4-64cc034026a8",
  "offer_hash": "ecf1b5e2992a82245b17a0f8c54e98357e04fc833db371f9e27de6511d7271e2",
  "offer_asset_id": "ab38352559b8b203bde5fddfa0b07d8b2525e132",
  "want_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "fill_amount": "89489747",
  "want_amount": "11007239",
  "filled_amount": "",
  "fee_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "fee_amount": "16510",
  "price": "0.123",
  "txn": {
    "hash": "0a41a03cb89e84c9daeae981797aa221d446cec2b6b8002eb2b4e0472f951975",
    "sha256": "5f5c1952f4e0dc3d5a0b8967d647877a5220d3f2e41af4482600c12969a5b0f1",
    "invoke": {
      "scriptHash": "bdfab1bf3f214dc433a6d08c2202471ed220ae24",
      "operation": "fillOffer",
      "args": [
        "f85d49d61d1c7bc972857724eb3b1fc91e49e2ed",
        "9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc532e125258b7db0a0dffde5bd03b2b859253538ab",
        "e271721d51e67de2f971b33d83fc047e35984ec5f8a0175b24822a99e2b5f1ec",
        11007239,
        "9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5",
        16510
      ]
    },
    "type": 209,
    "version": 1,
    "attributes": [
      {
        "usage": 32,
        "data": "f85d49d61d1c7bc972857724eb3b1fc91e49e2ed"
      }
    ],
    "inputs": [
      {
        "prevHash": "be3b0c15e495e8d051efa528de06a24c69cecda5cd1a8f98a9af2af877988a60",
        "prevIndex": 14
      }
    ],
    "outputs": [
      {
        "assetId": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
        "scriptHash": "e707714512577b42f9a011f8b870625429f93573",
        "value": 1e-8
      }
    ],
    "scripts": [],
    "script": "087e40000000000000209b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc50807f5a7000000000020e271721d51e67de2f971b33d83fc047e35984ec5f8a0175b24822a99e2b5f1ec349b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc532e125258b7db0a0dffde5bd03b2b859253538ab14f85d49d61d1c7bc972857724eb3b1fc91e49e2ed56c10966696c6c4f666665726724ae20d21e4702228cd0a633c44d213fbfb1fabd",
    "gas": 0
  },
  "status": "pending",
  "created_at": "2018-06-13T07:33:56.912Z",
  "transaction_hash": "0a41a03cb89e84c9daeae981797aa221d446cec2b6b8002eb2b4e0472f951975"
}
```   

* A fill is generated when an [order](#orders), that fills the make of another order, is created.
* When an order containing a fill is [broadcast](#broadcast-orders), a trade is created.
