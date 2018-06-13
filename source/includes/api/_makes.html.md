# Makes

> Example of a make

```json
{
  "offerHash": "3eda0632d6713dd3aa8e8512ab73c2e9e59151b04916a5350023629e913e36a7",
  "hash": "ffe681b91911ec1217190c89899371abdabf73bf2be4eda8e1c3e3c8d202a038",
  "sha256": "c0356803fd3ce5bb16fab7130d0baeb000eaed125edb4b9d10687e75306d30a0",
  "invoke": {
    "scriptHash": "bdfab1bf3f214dc433a6d08c2202471ed220ae24",
    "operation": "makeOffer",
    "args": [
      "f85d49d61d1c7bc972857724eb3b1fc91e49e2ed",
      "9b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc5",
      15000000,
      "32e125258b7db0a0dffde5bd03b2b859253538ab",
      500000000,
      "62343361656531302d643532332d343830342d393831342d376637653863353361636230"
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
      "prevIndex": 13
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
  "script": "2462343361656531302d643532332d343830342d393831342d376637653863353361636230080065cd1d000000001432e125258b7db0a0dffde5bd03b2b859253538ab08c0e1e40000000000209b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc514f85d49d61d1c7bc972857724eb3b1fc91e49e2ed56c1096d616b654f666665726724ae20d21e4702228cd0a633c44d213fbfb1fabd",
  "gas": 0
}
```
* A make is generated when an [order](#orders), which does not fill any makes from other orders, is created.
* When an order containing a make is [broadcast](#broadcast-orders), an offer will be created.

Look to the right for an example of a make  
