# REST API

## Introduction

There are two types of REST API endpoints:

Public Exchange APIs - these endpoints provide exchange history, statistics and other data and do not need to be authenticated
Private Trading APIs - these endpoints can be used to execute trades and must be authenticated
All API requests and responses use the JSON format.

The base URLs for the REST API are:

Type                  | Base URL
--------------------- | ----------
Sandbox / TestNet     | [https://test-api.switcheo.network/](https://test-api.switcheo.exchange/)
Production / MainNet  | [https://api.switcheo.network](https://api.switcheo.network)

## Rate Limits

All endpoints are rate-limited. We use a dynamic algorithm for determining these limits. The HTTP error code `429` will be returned if this limit is exceeded. You should implement an exponential backoff strategy when encountering this error code.
