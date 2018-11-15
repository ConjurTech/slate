# Overview

## Introduction

Welcome to the Switcheo Exchange API documentation.

This documentation is intended for developers who want to write applications to interact with the
Switcheo Exchange programatically.

Before you proceed with the API documentation, be sure to explore Switcheo Exchange at
[https://switcheo.exchange](https://switcheo.exchange).

Switcheo Exchange provides a REST API and a WebSocket API, described below.

If you have technical questions, you can ask them at our [slack channel](https://join.slack.com/t/switcheonetwork/shared_invite/enQtNDAyMTQ3Mzg3NjA1LTc0ODBlMWMxMjRkNTE5ZjkzN2VkNDNhYjQ2MjFlZTUwMzQ3NGMxYzZlODM5ZTAwZTcxMWM2YjA5MTAyN2FkYmI).

## REST API

Switcheo offers both public and private REST APIs.

There are two types of REST API endpoints:

- Public Exchange APIs - these endpoints provide exchange history, statistics and other data and do not need to be authenticated
- Private Trading APIs - these endpoints can be used to execute trades and must be authenticated

All API requests and responses use the [JSON](https://www.json.org/) format.

## WebSocket API

A WebSocket API that can provide real-time trading data is also available. You may find out more information about it [here](#websocket-api).

## Sandbox

Use the following TestNet (sandbox) URLs when developing your application:

Type | Base URL
---- | ----------
UI   | [https://beta.switcheo.exchange/](https://beta.switcheo.exchange/)
API  | [https://test-api.switcheo.network](https://test-api.switcheo.network)
WS   | [wss://test-ws.switcheo.io](wss://test-ws.switcheo.io)

Use the MainNet URLs for actual trading and market data:

Type | Base URL
---- | ----------
UI   | [https://switcheo.exchange/](https://switcheo.exchange/)
API  | [https://api.switcheo.network](https://api.switcheo.network)
WS   | [wss://ws.switcheo.io](wss://ws.switcheo.io)
