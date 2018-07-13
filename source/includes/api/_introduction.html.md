# Overview

## Introduction

Welcome to the Switcheo Exchange API documentation.

This documentation is intended for developers who want to write applications to interact with the
Switcheo Exchange programatically.

Before you proceed with the API documentation, be sure to explore Switcheo Exchange at
[https://switcheo.exchange](https://switcheo.exchange).

## API Requests

The Switcheo API uses [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) architecture.
API requests and responses use the [JSON](https://www.json.org/) format.

There are two main types of API endpoints.

- Trading APIs - these endpoints can be used to execute trades and must be authenticated
- Exchange APIs - these endpoints provide exchange history, statistics and other data and do not need to be authenticated

## Mainnet/Testnet URLs

When developing your application, the testnet URL should be used:

[https://test-api.switcheo.network](https://test-api.switcheo.network)

For actual trading and market data, the mainnet URL should be used:

[https://api.switcheo.network](https://api.switcheo.network)

## Rate Limits

All endpoints are rate-limited. We use a dynamic algorithm for determining these limits. The HTTP error code `429` will
be returned if this limit is exceeded. You should implement an exponential backoff strategy when encountering this error code.
