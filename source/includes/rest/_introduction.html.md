# REST API

## Introduction


### URLs

Please check our sandbox API here:

### Parameter Casing

Parameters used to generate a signature or sent in API requests should always be snake cased.

Parameters are camel cased in the examples because the examples are in JavaScript and it is
JavaScript's convention to use camel case.

The code in the examples make use of helper methods to automatically convert camel cased keys into
snake cased keys.

## Rate Limits

All endpoints are rate-limited. We use a dynamic algorithm for determining these limits. The HTTP error code `429` will be returned if this limit is exceeded. You should implement an exponential backoff strategy when encountering this error code.
