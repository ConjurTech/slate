# Errors

The Switcheo API uses the following error codes:

Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request is badly formed.
401 | Unauthorized -- You did not provide a valid signature.
404 | Not Found -- The specified endpoint or resource could not be found.
406 | Not Acceptable -- You requested a format that isn't json.
422 | Unprocessible Entity -- Your request had validation errors.
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.
