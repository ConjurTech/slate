# Troubleshooting

The following steps can be used to troubleshoot potential issues:

1. Check the [Important Information](#important-information) section.
Possible issues include the address format, amount format, parameter casing, private key format,
wrong parameters included to be signed, wrong timestamp.

2. Trace each step of signing parameters using the example in
[ Signing Request Parameters](#signing-request-parameters), this example has
the expected inputs and outputs at each step of generating a signature.

## CORS

When developing on a localhost server, you might encounter a CORS error.

To avoid this, please run your localhost server on port 8080.
