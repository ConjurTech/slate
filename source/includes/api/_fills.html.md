# Fills

* A fill represents the preparation of a [trade](#trades), in agreement to the stated price of an [offer](#offer)
* Fills are generated when [orders](#orders) that fill offers are [created](#create-orders).
* When an order containing a fill is [broadcast](#broadcast-orders), a trade is created.

## Fill object

TODO: Describe

> Example of a fill

```json
{
   "id":"32028da3-ff8d-40c5-810b-e4a39a63024a",
   "offer_hash":"8a951e84e0b6e556917950cc4a45d4ce20a54adf614f392c18c238b3f9450192",
   "offer_asset_id":"c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
   "want_asset_id":"ab38352559b8b203bde5fddfa0b07d8b2525e132",
   "fill_amount":"500000",
   "want_amount":"1000000000",
   "filled_amount":"",
   "fee_asset_id":"ab38352559b8b203bde5fddfa0b07d8b2525e132",
   "fee_amount":"1500000",
   "price":"0.0005",
   "txn":{
      "hash":"1d636df0e8be8e5db401c175385c239404ee2dde8efceefa4c7a3579eed9e0c7",
      "sha256":"ed027df7602e4d9de19736b80ee9d81014071bda7271aacc72c2f8d09d6146f4",
      "invoke":{
         "scriptHash":"dec966baae02856d4ea183969f80eba7e7199b6d",
         "operation":"fillOffer",
         "args":[
            "123bd6e8fe7789429ba7614f24de299b0fc890f9",
            "32e125258b7db0a0dffde5bd03b2b859253538ab9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5",
            "920145f9b338c2182c394f61df4aa520ced4454acc50799156e5b6e0841e958a",
            1000000000,
            "32e125258b7db0a0dffde5bd03b2b859253538ab",
            1500000
         ]
      },
      "type":209,
      "version":1,
      "attributes":[
         {
            "usage":32,
            "data":"123bd6e8fe7789429ba7614f24de299b0fc890f9"
         }
      ],
      "inputs":[
         {
            "prevHash":"422762e60424520a54e4ddf9d71f9d547a9816f3944bb066d5f4e35d83c12125",
            "prevIndex":22
         }
      ],
      "outputs":[
         {
            "assetId":"602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
            "scriptHash":"e707714512577b42f9a011f8b870625429f93573",
            "value":1e-08
         }
      ],
      "scripts":[

      ],
      "script":"0860e31600000000001432e125258b7db0a0dffde5bd03b2b859253538ab0800ca9a3b0000000020920145f9b338c2182c394f61df4aa520ced4454acc50799156e5b6e0841e958a3432e125258b7db0a0dffde5bd03b2b859253538ab9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc514123bd6e8fe7789429ba7614f24de299b0fc890f956c10966696c6c4f66666572676d9b19e7a7eb809f9683a14e6d8502aeba66c9de",
      "gas":0
   },
   "status":"pending",
   "created_at":"2018-06-06T07:28:37.507Z",
   "transaction_hash":"1d636df0e8be8e5db401c175385c239404ee2dde8efceefa4c7a3579eed9e0c7"
}
```   

Look to the right for an example of a fill
