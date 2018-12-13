# Overview

## Introduction

This documentation is intended for developers who want to write applications to interact with the
[Switcheo Exchange](https://switcheo.exchange) programatically.

Switcheo Exchange offers both a fully featured REST API and a WebSocket API. Language bindings are provided in Javascript. [Authentications](#authentication) are not made using API keys but are done instead by signing the request payload or transaction using your private key. 

You may wish to visit [Awesome Switcheo](https://github.com/Switcheo/awesome-switcheo) which contains everything awesome about Switcheo.

Information on API wrappers can also be found on [Awesome Switcheo](https://github.com/Switcheo/awesome-switcheo).

## Sandbox

**TestNet URLs (Sandbox)**

Type | Base URL
---- | ----------
UI   | [https://beta.switcheo.exchange/](https://beta.switcheo.exchange/)
API  | [https://test-api.switcheo.network](https://test-api.switcheo.network)
WS   | [wss://test-ws.switcheo.io](wss://test-ws.switcheo.io)

**MainNet URLs (Actual Exchange)**

Type | Base URL
---- | ----------
UI   | [https://switcheo.exchange/](https://switcheo.exchange/)
API  | [https://api.switcheo.network](https://api.switcheo.network)
WS   | [wss://ws.switcheo.io](wss://ws.switcheo.io)
