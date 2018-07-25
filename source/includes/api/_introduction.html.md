# Overview

## Introduction

Welcome to the Switcheo Exchange API documentation.

This documentation is intended for developers who want to write applications to interact with the
Switcheo Exchange programatically.

Before you proceed with the API documentation, be sure to explore Switcheo Exchange at
[https://switcheo.exchange](https://switcheo.exchange).

If you have technical questions, you can ask them at our [slack channel](https://join.slack.com/t/switcheonetwork/shared_invite/enQtNDAyMTQ3Mzg3NjA1LTc0ODBlMWMxMjRkNTE5ZjkzN2VkNDNhYjQ2MjFlZTUwMzQ3NGMxYzZlODM5ZTAwZTcxMWM2YjA5MTAyN2FkYmI).

## API Requests

The Switcheo API uses [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) architecture.
API requests and responses use the [JSON](https://www.json.org/) format.

There are two types of API endpoints.

- Exchange APIs - these endpoints provide exchange history, statistics and other data and do not need to be authenticated
- Trading APIs - these endpoints can be used to execute trades and must be authenticated

## Mainnet / Testnet URLs

Use the testnet URLs when developing your application:

    | URL
--- | ----------
UI  | [https://beta.switcheo.exchange/](https://beta.switcheo.exchange/)
API | [https://test-api.switcheo.network](https://test-api.switcheo.network)

Use the mainnet URLs for actual trading and market data:

    | URL
--- | ----------
UI  | [https://switcheo.exchange/](https://switcheo.exchange/)
API | [https://api.switcheo.network](https://api.switcheo.network)

## Rate Limits

All endpoints are rate-limited. We use a dynamic algorithm for determining these limits. The HTTP error code `429` will
be returned if this limit is exceeded. You should implement an exponential backoff strategy when encountering this error code.
