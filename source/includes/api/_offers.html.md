# Offers

An offer represents an open order that rests on the [Switcheo Exchange](https://switcheo.exchange) offer book.

Funds used to make an offer will be placed on hold unless the order is cancelled or filled.

## List Offers

> Example request

 ```js
{
  "blockchain": "neo",
  "pair": "SWTH_NEO",
  "contract_hash": "eed0d2e14b0027f5f30ade45f2b23dc57dd54ad2"
}
 ```

 > Example response

 ```js
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

Parameter     | Type       | Required | Description
------------- | ---------- | -------- | -----------
blockchain    | **string** | yes      | Only return offers from this blockchain. Possible values are `neo`.
pair          | **string** | yes      | Only return offers from this [pair](#pairs).
contract_hash | **string** | yes      | Only return offers for this [contract hash](#contracts).

### Response parameters

Parameter        | Description
---------------- | ----------
id               | Unique identifier for the offer object.
offer_asset      | [Symbol](#supported-assets) of the token that the offer maker is offering.
want_asset       | [Symbol](#supported-assets) of the token that the offer maker wants .
available_amount | Remaining [amount](#amounts) of the `offer_asset` that has not been taken by other orders.
offer_amount     | Total [amount](#amounts) of the `offer_asset`.
want_amount      | Total [amount](#amounts) of the `want_asset`.

### Example
[Full list offers example](https://github.com/ConjurTech/switcheo-api-examples/blob/master/src/examples/offers/listOffersExample.js)

## Offer book

> Example request

 ```js
{
  "pair": "SWTH_NEO",
  "contract_hash": "eed0d2e14b0027f5f30ade45f2b23dc57dd54ad2"
}
 ```

 > Example response

 ```js
{
  asks: [
    {
      "price": "0.00046103",
      "quantity": "9378.0"
    },
    {
      "price": "0.00046759",
      "quantity": "1084.30496802"
    }
  ],
  bids: [
    {
    "price": "0.00045645",
    "quantity": "6678.0"
    },
    {
      "price": "0.0004534",
      "quantity": "12279.38328187"
    },
  ]
}
 ```

Retrieves the offer book.

### HTTP Request

`GET /v2/offers/book`

### Request Parameters

Parameter     | Type       | Required | Description
------------- | ---------- | -------- | -----------
pair          | **string** | yes      | Only return offers from this [pair](#pairs).
contract_hash | **string** | yes      | Only return offers for this [contract hash](#contracts).

### Response parameters

Parameter   | Description
----------- | ----------
price       | Bid or Ask price.
quantity    | If `bids` side, returns amount of tokens being bought. If `asks` side, returns amount of tokens that is being sold. 
