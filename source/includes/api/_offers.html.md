# Offers

An offer represents an open order on the [Switcheo Exchange](https://switcheo.exchange) offer book.

Funds used to make an offer are locked in the contract until the order is cancelled or filled.

## List Offers

> Example request - ETH Pair

 ```js
{
  "pair": "JRC_ETH",
  "contract_hash": "0x607af5164d95bd293dbe2b994c7d8aef6bec03bf"
}
 ```

 > Example response

 ```js
 [
    {
        "id": "e4a76e85-53dc-4a25-ab44-4eed504ce0e0",
        "address": "0x0fc8f7bab5feb402ed624b5f5fc88a0648a7f3ae",
        "available_amount": 2.4043723e+24,
        "offer_amount": 1e+25,
        "want_amount": 1500000000000000000,
        "offer_asset": "JRC",
        "want_asset": "ETH"
    },
    ....
]
 ```

Retrieves the 70 best offers (per side) on the offer book.

### HTTP Request

`GET /v2/offers`

### Request Parameters

Parameter     | Type       | Required | Description
------------- | ---------- | -------- | -----------
pair          | **string** | yes      | Only return offers from this [pair](#pairs).
contract_hash | **string** | no       | Only return offers for this [contract hash](#contracts).

### Response parameters

Parameter        | Description
---------------- | ----------
id               | Unique identifier for the offer object.
address          | [Address](#addresses) of the offer maker
available_amount | Remaining [amount](#amounts) of the `offer_asset` that has not been taken by other orders.
offer_amount     | Total [amount](#amounts) of the `offer_asset`.
want_amount      | Total [amount](#amounts) of the `want_asset`.
offer_asset      | [Symbol](#supported-assets) of the token that the offer maker is offering.
want_asset       | [Symbol](#supported-assets) of the token that the offer maker wants .

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
contract_hash | **string** | no       | Only return offers for this [contract hash](#contracts).

### Response parameters

Parameter   | Description
----------- | ----------
price       | Bid or Ask price.
quantity    | If `bids` side, returns amount of tokens being bought. If `asks` side, returns amount of tokens that is being sold.
