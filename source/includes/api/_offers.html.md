# Offers

## Get Offers
 
 ```shell
 curl "https://api.switcheo.network/v2/offers?contract_hash=SWITCHEO_CONTRACT_HASH&pair=SWTH_NEO"
 ```
 
 > The above command returns JSON structured like this:
 
 ```json
 {
     "symbol": "SWTH_NEO",
     "price_change": "0.00006001",
     "percentage_price_change": "6.384",
     "last_price": "0.00100000",
     "last_quantity": "1.77051096",
     "bid_price": "0.00100000",
     "bid_quantity": "3098.92243065",
     "ask_price": "0.00102099",
     "ask_quantity": "26012.13923092",
     "high_price": "0.00103344",
     "low_price": "0.00088115",
     "open_price": "0.00095300",
     "volume": "6141.83147280",
     "quote_volume": "6615989.55286128",
     "open_time": 1526531482,
     "close_time": 1526617882,
     "count": 966
    }
 ```
 
 This endpoint gets the offer book (limited to 30 offers per side)
 Offers are buys or sells that users have made on the [Switcheo Exchange](https://switcheo.exchange).
 They can be seen in the ORDER BOOK column.
 
 
 ### HTTP Request
 
 `https://api.switcheo.network/v2/offers`
 
 ### URL Parameters
 
Parameter | Description
--------- | -----------
  blockchain | only returns offers from this blockchain `(eg. neo)`
  contract_hash | only return offers for this contract hash `(Switcheo)`
  pair | only returns offers from this pair `(eg. SWTH_NEO)`
