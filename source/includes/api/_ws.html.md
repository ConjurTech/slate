# Websocket API

This section documents the Switcheo Exchange websocket interface, which is used for transfer of streaming data to clients. It is recommended to use [socket.io](https://socket.io/) for connecting to this interface.

Authentication is not required for these endpoints.

## Offers

> Example response

```js
[
  "join",
  {
    contractHash: "91b83e96f2a7c4fdf0c1688441ec61986c7cae26",
    pair: "FTWX_NEO"
   }
]
```

### Join Room

### Request parameters

Parameter                 | Description
------------------------- | ----------
contractHash              | Address of the exchange contract to subscribe to.
pair                      | Asset pair to subscribe to.

### Response parameters

Parameter          | Type       | Description
-------------------| ---------- | ----------
Coming soon..

## Trades

Coming soon..

## Orders

Coming soon..
