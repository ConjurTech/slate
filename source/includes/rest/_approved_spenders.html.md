## Approved Spenders

Switcheo Exchange is made up of a group of contracts.
There is a main Broker contract that users deposits funds to,
and there are sub-contracts that perform different functions to update user funds within the main Broker contract.

For security, users have to send a transaction to approve a sub-contract before
that sub-contract is allowed to update the user's funds within the main contract.

The Atomic Swap contract is an example of such a sub-contract.
To perform Atomic Swaps, users will have to first approve the Atomic Swap contract.

### POST Create Approval

This is the first API call required to approve a spender.

#### HTTP Request

`POST /v2/approved_spenders`

#### Request Parameters

 Parameter  | Type       | Required | Description
----------- | ---------- | -------- | ------------------------------
 contract_hash   | **string** | yes       | The contract hash of the [main contract](#get-contracts).
 address    | [address](#addresses) | yes       | [Address](#addresses) of the approver. **Do not include this in the parameters to be signed.**
 spender_address | **string** | yes | The address of the [sub-contract](#get-atomic-swap-contracts) to be approved.

### POST Execute Approval

This is the second endpoint required to execute an approval.
After using the [Create Approval](#post-create-approval) endpoint,
you will receive a response which contains a `transaction`.

The `transaction` in the response should be signed and directly broadcasted by the client,
the transaction hash of the broadcasted transaction should then be sent to the broadcast endpoint.

#### HTTP Request

`POST /v2/approved_spenders/:id/broadcast`

#### Request Parameters

 Parameter  | Type       | Description
 ---------- | ---------- | -----------
 transaction_hash | **string** | The transaction hash of the broadcasted transaction
