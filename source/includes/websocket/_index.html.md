# WebSocket API

## Introduction

Switcheo offers 3 WebSocket APIs for streaming data:

1. a public Offer Book API
2. a public Trade Events API
3. a private Order Events API

Advantages include:

- receive notifications in real time
- reduce the amount of data you have to transfer over the network
- reduce latency introduced by polling interval

For example, to maintain an order book on your client and react to changes on it, you may be polling the [Get Offer Book](#get-offer-book) endpoint every three seconds:

1. request `/v2/offers`
2. bring back HTTP header data and a response body
3. parse the JSON in the response body
4. compare the latest response against the previous response to see what has changed

Using the public Offer Book API, you can instead subscribe once and receive real time notifications of all
offer book changes.

The Switcheo WebSocket uses the [Socket.IO](https://socket.io/) protocol. It is recommended to use a Socket.IO [client](https://github.com/socketio/socket.io#features) for connecting to Switcheo's WebSocket API.

For more information on how the WebSocket protocol works in general, refer to:
- [About HTML5 WebSocket](https://websocket.org/aboutwebsocket.html)
- [RFC 6455 - The WebSocket Protocol](https://tools.ietf.org/html/rfc6455)

## Sandbox

## Event Types

## Offer Book

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

## Trade Events

Coming soon..

## Order Events

Coming soon..
