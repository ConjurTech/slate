# Stats

This section consists of endpoints return statistical infromation from Switcheo Exchange.

Authentication is not required for these endpoints.


## Volume

Returns a snapshot volume traded per wallet address for a selected asset and timeframe.

### HTTP Request

`GET /v2/stats/volume`

> Example response

```js
[
{
    "data": [],
    "last_updated_at": 1541523499
}
]

```


### Response parameters

Parameter                 | Description
------------------------- | ----------
data                      | Address of the Ethereum  Exchange Contract owner ????.
last_updated_at           | Epoch timestamp of when snapshot was taken
 
