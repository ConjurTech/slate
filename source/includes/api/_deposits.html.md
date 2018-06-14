# Deposits

## Description

Used to move funds from wallet into smart contract ie. wallet balance.

### Overview

To perform any action, **two** API calls are required. This defers from a traditional exchange API,
 as the deposit must be co-signed by our off-chain service, and then broadcasted to the appropriate blockchain.
 
The **first** API call creates an appropriate blockchain transaction (e.g. [create deposit](#create-an-deposit)), which will 
  be returned in the response.

This transaction must then be signed in the specific way as required as by the blockchain; The signature should then
  be returned as the payload in the **second** API call (e.g. [broadcast deposit](#broadcast-an-deposit)).
  
As mentioned above, the message to be signed in the second step of an action is simply the serialized 
  blockchain transaction itself. 
  
As there is no transaction to be signed in the first step of an action, in general, the message 
  to be signed in the first step of an action is the request parameters as an deposited JSON **string**.  

## List deposits

```shell
curl "https://api.switcheo.network/v2/deposits?address=PUBLIC_ADDRESS"
```

> Example response:

```json
[
  {
    "id": "c415f943-bea8-4dbf-82e3-8460c559d8b7",
    "blockchain": "neo",
    "contract_hash": "c41d8b0c30252ce7e8b6d95e9ce13fdd68d2a5a8",
    "address": "20abeefe84e4059f6681bf96d5dcb5ddeffcc377",
    "side": "buy",
    "offer_asset_id": "c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
    "want_asset_id": "602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
    "offer_amount": "100000000",
    "want_amount": "20000000",
    "transfer_amount": "0",
    "priority_gas_amount": "0",
    "use_native_token": false,
    "native_fee_transfer_amount": 0,
    "deposit_txn": null,
    "created_at": "2018-05-15T10:54:20.054Z",
    "status": "processed",
    "fills": [],
    "makes": []
  }
]
```

This endpoint retrieves deposits from a specific address filtered by the params provided.

### HTTP Request

`https://api.switcheo.network/v2/deposits`

### Url parameters

 Parameter      | Type                  | Description
--------------- | --------------------- | -----------
 address        | **string**            | deposit maker's wallet address. Only returns deposits from this address.
 contract_hash  | **string** (optional) | Switcheo [contract hash](#contract-hash). Only returns deposits from this contract hash.
 trade_asset_id | **string** (optional) | Hash of an asset. Only returns deposits with this trade asset.
 base_asset_id  | **string** (optional) | Hash of an asset. Only returns deposits with this base asset.

## Create a deposit

> Example of message to sign:

```

```

This is the first api call required to create an deposit.
  deposits can only be created after sufficient funds have been [deposited](#deposits) into the deposit maker's contract balance.

A [signature](#authentication) has to be provided for this api call. An example of the message required to be signed 
  can be seen on the right.
  
<aside class="notice">
  Note: After calling this endpoint, do remember to call the second api (broadcast deposit) for the deposit to be created. 
</aside>

> Example Request:

```shell
curl 
```

> Example Response:

```json

```
    
### HTTP Request (POST)

`https://api.switcheo.network/v2/deposits`
    
### Url parameters

 Parameter         | Type        | Description
------------------ | ------------| -----------
 blockchain        | **string**  | Blockchain (in lowercase) that the offer is on. Possible values are: `neo`
 contract_hash     | **string**  | Switcheo [contract hash](#contract-hash) to execute the deposit on.
 address           | **string**  | Hash of the deposit maker's wallet public address.
 pair              | **string**  | Pair to trade, e.g. `RPX_NEO` 
 side              | **string**  | Possible values are: `buy`, `sell`
 price             | **string**  | deposit price to 8 decimal places
 offer_amount      | **string**  | Number of assets offered in the deposit.
 use_native_tokens | **boolean** | `true` if SWTH is used as fees. `false` if SWTH is not used for fees.
 timestamp         | **int**     | Current timestamp (epoch milliseconds)
 public_key        | **string**  | Public key of the deposit maker in hex format
 signature         | **string**  | Message hash signed with deposit maker's private key.
 
## Broadcast a deposit

> 1.Example response from first api call:

```json
{}
```

> 2.Sign make from transaction:

```json
{}
```


> 3.Put signature and make id in this format for signature url parameter:

```
{
    fills: {},
    makes: 
      {
        "b43aee10-d523-4804-9814-7f7e8c53acb0": "a294da6f9e5095190194532363051145f538cf2809b874c736e2dc5ca1584e9a848c849dc44077389ddcee5678f7e37ac3602cc69f030453f8c466c96aa2e8c6"
      }
}
```

This is the second api call needed to create an deposit.
  After using the create deposit endpoint, you will receive a transaction as the response to be broadcast.

Every [fill](#fills) and [make](#makes) in the response from the first api call has to be [signed](#authentication). 

Looking at the example on the right:
   
1. A response is received from calling the [create deposit](#create-an-deposit) endpoint.
2. `fills` returns an empty array, so lets look at `makes`. The message we have to sign will be the value returned by the `txn` key.
3. After signing the make, we will have to include the make id and signature in an object:
 
 `{ makes: { id: <signature> }, fills: { id: <signature> } }`
 
  and use it for the `signature` url parameter.
  
> Example request:
 
 ```shell
 curl https://api.switcheo.network/v2/deposits/id/broadcast \
   -d '{"public_key":"034d2ad7cc8a2598dd341271920fd78ea98209cd082aae6a1ef10d51a3b254d822","signatures":{"fills":{},"makes":{"48c908fb-95a6-4646-9484-d01ea509f6cc":"3eab5444213a78d9450505da829ba533071d53e020b9beb266a85032f63f3b7331bb21d2df820e59738534462fc02a4b7cc1bd689918870bcbd7b1fadc1f3aca"}}}' 
 ```
 
 > Example response:
 
 ```json
{ 
  "id":"474940c6-2be4-43a8-aa71-0f9b2bc8908c",
  "blockchain":"neo",
  "contract_hash":"06118464b88a1049f38abac013347ca9039fb8b0",
  "address":"20abeefe84e4059f6681bf96d5dcb5ddeffcc377",
  "side":"sell",
  "offer_asset_id":"602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7",
  "want_asset_id":"c56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b",
  "offer_amount":"100000",
  "want_amount":"143253",
  "transfer_amount":"0",
  "priority_gas_amount":"0",
  "use_native_token":false,
  "native_fee_transfer_amount":0,
  "deposit_txn":null,
  "created_at":"2018-05-23T03:20:19.481Z",
  "status":"pending",
  "fills":[],
  "makes":[]
}
 ```
 
### HTTP Request
 
`https://api.switcheo.network/v2/deposits/id/broadcast`
 
### URL Parameters
 
Parameter | Type | Description
--------- | ----------- | -----------
  signature | **string** | The signatures in this format: `{ makes: { id: <signature> }, fills: { id: <signature> } }`
  public_key | **string** | Public key of the deposit maker in hex format

