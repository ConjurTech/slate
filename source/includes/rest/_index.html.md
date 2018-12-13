# REST

## Introduction

The REST APIs are feature complete, allowing developers to build their own applications on top of Switcheo Exchange.

All API requests and responses use the JSON format.

There are two types of REST API endpoints available:

**Public**  

These public endpoints include:

+ GET [Announcements](#get-announcements)
+ GET [Candlesticks](#get-candlesticks)
+ GET [Contract Balances](#get-contract-balances)
+ GET [Contracts](#get-contracts)
+ GET [Fees](#get-fees)
+ GET [Last 24 Hours](#get-last-24-hours)
+ GET [Last Price](#get-last-price)
+ GET [Offer Book](#get-offer-book)
+ GET [Order](#get-order)
+ GET [Order Book](#get-order-book)
+ GET [Orders](#get-orders)
+ GET [Pairs](#get-pairs)
+ GET [Recent Trades](#get-recent-trades)
+ GET [Timestamp](#get-timestamp)
+ GET [Tokens](#get-tokens)
+ GET [Trades](#get-trades)

**Private**  

All private endpoints must be authenticated.  

These public endpoints include:

+ POST [Create Cancellation](#post-create-cancellation)
+ POST [Create Deposit](#post-create-deposit)
+ POST [Create Order](#post-create-order)
+ POST [Create Withdrawal](#post-create-withdrawal)
+ POST [Execute Cancellation](#post-execute-cancellation)
+ POST [Execute ETH Deposit](#post-execute-eth-deposit)
+ POST [Execute NEO Deposit](#post-execute-neo-deposit)
+ POST [Execute Order](#post-execute-order)
+ POST [Execute Withdrawal](#post-execute-withdrawal)

The base URLs for the REST API are:

Type                  | Base URL
--------------------- | ----------
Sandbox / TestNet     | [https://test-api.switcheo.network/](https://test-api.switcheo.exchange/)
Production / MainNet  | [https://api.switcheo.network](https://api.switcheo.network)

## Rate Limits

All endpoints are rate-limited. We use a dynamic algorithm for determining these limits. The HTTP error code `429` will be returned if this limit is exceeded. You should implement an exponential backoff strategy when encountering this error code.
