# Offers

An offer represents an open order that rests on the [Switcheo Exchange](https://switcheo.exchange) offer book.

Funds used to make an offer will be placed on hold unless the order is cancelled or filled.

## List Offers

 ```shell
 curl "https://test-api.switcheo.network/v2/offers?contract_hash=9c9d2fac35987621e252981e06762895b09eb035&pair=SWTH_NEO&blockchain=neo"
 ```

 > The above command returns JSON structured like this:

 ```json
 [
   {
     "id": "b3a91e19-3726-4d09-8488-7c22eca76fc0",
     "offer_asset": "SWTH",
     "want_asset": "NEO",
     "available_amount": 2550000013,
     "offer_amount": 4000000000,
     "want_amount": 320000000
   }
 ]
 ```

Retrieves the best 70 offers (per side) on the offer book.

### HTTP Request

`GET /v2/offers`

### Request Parameters

Parameter     | Type       | Optional | Description
------------- | ---------- | -------- | -----------
blockchain    | **string** | no       | Only return offers from this blockchain. Possible values are `neo`.
contract_hash | **string** | no       | Only return offers for this [contract hash](#contracts).
pair          | **string** | no       | Only return offers from this [pair](#pairs).

### Example
[Full list offers example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/offers/listOffersExample.js)
