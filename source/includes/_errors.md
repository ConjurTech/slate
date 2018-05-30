# Errors

The Switcheo API uses the following error codes:

Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request is invalid.
403 | Forbidden -- The specified endpoint is for administrators only.
404 | Not Found -- The specified endpoint could not be found.
406 | Not Acceptable -- You requested a format that isn't json.
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.
