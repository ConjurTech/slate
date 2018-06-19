# Overview

## Introduction

Welcome to the Switcheo Exchange API documentation.

This documentation is intended for developers who want to write applications to interact with Switcheo Exchange
programatically.

This API 

Before you proceed with the API documentation, be sure to explore Switcheo Exchange at [https://switcheo.exchange](https://switcheo.exchange)

## API

The Switcheo API uses the [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) architecture.
API requests and responses use the [JSON](https://www.json.org/) format.

There are two main types of API endpoints.

- Trading APIs - these endpoints can be used to execute trades and must be authenticated
- Exchange APIs - these endpoints provide exchange history, statistics and other data and do not need to be authenticated

## Authentication

Authentication for Switcheo Exchange API is different from traditional APIs as ECDSA signatures using users' private keys
are used. Please see the Authentication section for more details.

## Rate Limits

All endpoints are rate-limited. We use a dynamic algorithm for determining these limits. The HTTP error code `429` will
be returned if this limit is exceeded. You should implement an exponential backoff strategy when encountering this error code. 

## Terminology

Resource | Description
--------- | -----------
[Order](#orders) | An order represents a buy or sell intent of a currency against another base currency.
[Offers](#offers) | An offer is an open order on the order book that are waiting to be filled.
Address | The address of the trading wallet. For NEO, this is the SHA-256 hash of the verification script for the wallet as a hex string in big endian format.
Wallet Balance | Wallet balance refers to funds present in your wallet.
Contract Balance | Contract balance refers to funds present in Switcheo's smart contract. Funds must be deposited here before they can be traded.  
