# Streaming API

## Introduction

Switcheo offers 3 APIs for streaming data:

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

The Switcheo Streaming API uses the [Socket.IO](https://socket.io/) protocol. It is recommended to use a Socket.IO [client](https://github.com/socketio/socket.io#features) for connecting the API.

For more information on how the Socket.IO protocol works in general, refer to:

- [What Socket.IO is](https://socket.io/docs/#What-Socket-IO-is)
- [Socket.IO Protocol](https://github.com/socketio/socket.io-protocol)

## Connection Endpoints

> Example

```js
const client = io('wss://test-ws.switcheo.io/<namespace>');
```

The connection endpoints are:

Type                  | Base URL
--------------------- | ----------
Sandbox / TestNet     | [wss://test-ws.switcheo.io/](wss://test-ws.switcheo.io)
Production / MainNet  | [wss://ws.switcheo.io](wss://ws.switcheo.io)


## Event Types

Below are the event types that may be emitted by WebSocket server. In addition,
all standard Socket.IO events are also emitted.

Name   | Type | Description
------ | ---- | ---------
`all`  | Server | Emitted when initially joining a room
`more` | Server | Emitted in response to additional data requested by client
`updates` | Server | Emitted when a new event occurs

Below are the event types that can be emitted by the client and are processed by the WebSocket server.

Name   | Type | Description
------ | ---- | ---------
`join`  | Client | Emit to join a room (i.e. subscribe to a channel)
`leave` | Client | Emit to leave a room (i.e. unsubscribe from a channel)
`more` | Client | Emit to fetch more data


## Rooms

> Example

```js
io.on('connection', function(socket){
  socket.join({ ... });
});
```

After connecting to the Switcheo API, clients need to join the appropriate room in order to send or receive data.

Note that the room to join is always an object. The namespace and room parameters are described in each API section below. To learn more about Room and Namespaces, see the [Socket.io docs](https://socket.io/docs/rooms-and-namespaces/).

## Offer Book

The Offer Book API allows clients to maintain an offer book, with diff-ing support to ensure data integrity.

### Socket Connection

> Example

```js
const client = io('wss://test-ws.switcheo.io/books');
io.on('connection', function(socket){
  socket.join({
    contractHash: "91b83e96f2a7c4fdf0c1688441ec61986c7cae26",
    pair: "SWTH_NEO"
  });
});
```

To subscribe to the offer book API, connect to the `offers` namespace and join the room with the following parameters:

Parameter                 | Description
------------------------- | ----------
contractHash              | [Contract hash](#contract-hashes) of the exchange
pair                      | [Pair](#get-pairs) of the offer book to subscribe

### All Event

> Example Event

```js
{
  book: {
    buys: [ // i.e. bids
      { price: '0.01000000', amount: '100' }, // amount refers to the quote quantity
      { price: '0.09000000', amount: '50' },
      ...
    ],
    sells: [ // i.e. asks
      ...
    ]
  }
  digest: '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
}
```

Upon joining the appropriate room, you will receieve an `all` event on your socket, which will contain the full data of the offer book for the subscribed pair, as well as a SHA-1 digest.

The SHA-1 digest can be used to maintain offer book integrity after future updates are applied.

#### Response Fields

Parameter | Description
--------- | ----------
book      | The offer book data
digest    | A SHA-1 digest of the stringified JSON `book`

### Updates Event

> Example Event

```js
{
  events: [
    { price: '0.01000000', side: 'buy', delta: '-1' },
    ...
  ],
  digest: '62d7beb325a49df2c323c45fd27e119d524468e0',
}
```

> Example Handling

```js
socket.on('all', ({ events, digest }) => {
  events.forEach(event => {
    const index = book[event.side].findIndex(o => o.price === event.price)
    oldBook[event.side].amount += event.delta
  })
  const computedDigest = computeDigest(book)
  if (computedDigest !== digest) {
    throw new Error('offer book desynchronized!') // handle by rejoining room
  }
});
```

Whenever there is a change to the offer book, an `updates` event will be emitted, containing the update events and a SHA-1 digest.

#### Response Fields

Field     | Description
--------- | ----------
events    | An array of `event`s to apply against the existing offer book.
digest    | A SHA-1 digest of the stringified JSON `book` after `events` have been applied.

#### `event` Fields

Field     | Description
--------- | ----------
delta     | The difference in quantity, which may be negative.
price     | The offer book price point that is being updated.
side      | The side of the offer book that has changed, either `buy` or `sell`.

If the SHA-1 digest of the offer book does not match after applying updates, the room should be rejoined in order to refetch the full offer book.

The digest should be computed by constructing a sorted JSON string and applying the SHA-1 hash algorithm.

Keys in any JSON object should be sorted alphanumerically. Arrays should be sorted from highest price to lowest price.

Take note that when changing numeric values, and recomputing the offer book digest, amounts should be stringified, and exponentiated when the exponent is less than `-6` or more than `19`.

#### Number to string formatting

Number        | String  | Info
-----------   | ------- | -----
`12345678`    | `'12345678'` | // e is only 8
`0.000000123` | `'1.23e-7'`  | // e is < -6

## Trade Events

The Trade Events API allows clients to subscribe and listen to trade events that happen on Switcheo Exchange. There is diff-ing support to ensure that no trade events are missed.

### Socket Connection

> Example

```js
const client = io('wss://test-ws.switcheo.io/trades');
io.on('connection', function(socket){
  socket.join({
    contractHash: "91b83e96f2a7c4fdf0c1688441ec61986c7cae26",
    pair: "SWTH_NEO"
  });
});
```

To subscribe to the trade events API, connect to the `trades` namespace and join the room with the following parameters:

Parameter                 | Description
------------------------- | ----------
contractHash              | [Contract hash](#contract-hashes) of the exchange
pair                      | [Pair](#get-pairs) to listen to trade events for

### All Event

> Example Event

```js
{
  trades: [
    { price: '0.01000000', side: 'buy', timestamp: '-1', amount: '100' },
    ...
  ]
  digest: '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12',
}
```

Upon joining the appropriate room, you will receieve an `all` event on your socket, which will contain the last 50 trade events for the subscribed pair, as well as a SHA-1 digest.

The SHA-1 digest can be used to ensure that trade events were not missed.

#### Response Fields

Field     | Description
--------- | ----------
trades    | The `trade` events
digest    | A SHA-1 digest of the stringified JSON `trades`

#### `trade` Fields

Field     | Description
--------- | ----------
amount    | The amount of tokens traded (in quote quantity)
price     | The price of the trade
side      | The taker side of the trade, either `buy` or `sell`
timestamp | The trade execution time

### Updates Event

> Example Event

```js
{
  events: [...],
  digest: '62d7beb325a49df2c323c45fd27e119d524468e0',
  limit: 50,
}
```

Whenever there is a new trade event, an `updates` event will be emitted.

The digest should be computed by stringifying the last `limit` trades of JSON data, and applying the SHA-1 hash algorithm.

The data array should be sorted from the largest to smallest `timestamp`. Keys in each object should be sorted alphanumerically.

Take note that to compute the digest, only the last `limit` trades should be used. Earlier trades events should be trimmed, before stringifying and hashing the data.

#### Event Fields

Field     | Description
--------- | ----------
events    | An array of `event`s, in the same format as `trade`
digest    | A SHA-1 digest of the stringified JSON `trades` after `events` have been applied.
limit     | The number of trades to hash in order to compute the SHA-1 digest. If this is less than the number of trades given in the `all` event and `updates` event, all trades should be used.

## Order Events

The Order Events API allows clients to subscribe and listen to order events that happen on Switcheo Exchange.

### Socket Connection

> Example

```js
const client = io('wss://test-ws.switcheo.io/orders');
io.on('connection', function(socket){
  socket.join({
    contractHash: "91b83e96f2a7c4fdf0c1688441ec61986c7cae26",
    pair: "SWTH_NEO",
    address: "20abeefe84e4059f6681bf96d5dcb5ddeffcc377"
  });
});
```

To subscribe to the order events API, connect to the `orders` namespace and join the room with the following parameters:

Parameter                 | Description
------------------------- | ----------
address                   | Address to listen to order events for
contractHash              | [Contract hash](#contract-hashes) of the exchange

### All Event

> Example Event

```js
{
  orders: [
    {
      baseAmount: "6147810",
      baseAsset: "NEO",
      blockchain: "neo",
      fee: "0",
      feeAsset: "NEO",
      filledAmount: "12345000000",
      fills: [
        {
          amount: "2345000000",
          fee: "1758750",
          id: "353e8e0e-581c-4207-9cdb-718144d0ce0e",
          price: "0.000498",
          timestamp: 1541582687
        },
        ...
      ],
      id: "06105c4c-9ed1-43fb-be79-d65c9e40c7fa",
      makeFills: [
        amount: "12345000000",
        fee: "78791",
        id: "2e8da960-10f6-439f-9ec2-36f5eeb1f179",
        price: "0.00034",
        timestamp: 1540528856,
        ...
      ],
      price: "0.000498",
      side: "sell",
      status: "completed",
      timestamp: 1541582603,
      tradeAmount: "12345000000",
      tradeAsset: "SWTH",
      type: "limit"
    },
    ...
  ]
}
```

Clients can emit an `all` event to receive the last 50 orders. To receive more orders, emit a [`more`](#more-event) event.

#### Request Fields

Field        | Type                | Required | Description
------------ | ------------------- | -------- | -----------
address      | Array\<**string**\> | yes      | Addresses to listen to order events for
contractHash | Array\<**string**\> | yes      | [Contract hashes](#contract-hashes) of the exchange
pair         | **string**          | no       | [Pair](#get-pairs) to listen to order events for
status       | **string**          | no       | The status of the order, either `cancelled`, `completed`, or `open`

#### Response Fields

Field     | Description
--------- | ----------
orders    | The `order` events

#### `order` Fields

Field        | Description
------------ | -----------
baseAmount   | The quoted quantity of base asset
baseAsset    | The base asset
blockchain   | The blockchain, either `neo` or `eth`
fee          | The fee incurred
feeAsset     | The fee asset
filledAmount | The filled amount of the order
fills        | The orders `fill`ed by this order
id           | The order id
makeFills    | The orders that `fill`s this order
price        | The quoted price if it's a limit order or `null` if it's a market order
side         | The side of the order, either `buy` or `sell`
status       | The status of the order, either `cancelled`, `completed`, or `open`
timestamp    | The order time
tradeAmount  | The quoted quantity of trade asset
tradeAsset:  | The trade asset
type         | The type of order, either `limit` or `market`

#### `fill` Fields

Field     | Description
--------- | -----------
amount    | The filled amount
fee       | The fee incurred by the taker
id        | The fill id
price     | The executed price
timestamp | The executed time

### More Event

The more event is exactly the same as the [`all`](#all-event) event with the exception of an additional request parameter, `beforeId`.

#### Request Fields

Field        | Type                | Required | Description
------------ | ------------------- | -------- | -----------
address      | Array\<**string**\> | yes      | Addresses to listen to order events for
contractHash | Array\<**string**\> | yes      | [Contract hashes](#contract-hashes) of the exchange
pair         | **string**          | no       | [Pair](#get-pairs) to listen to order events for
status       | **string**          | no       | The status of the order, either `cancelled`, `completed`, or `open`
beforeId     | **string**          | no       | The id of the last order in the order history

### Updates Event

> Example Event

```js
{
  events: [...],
}
````

Whenever there is a new order event, an `updates` event will be emitted.

#### Event Fields

Field     | Description
--------- | -----------
events    | An array of `event`s, in the same format as `order`
