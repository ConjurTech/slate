# Contract Hash

A `contract_hash` refers to the hash of the Switcheo Exchange Contract. This may defer by blockchain and version, and environment
(TestNet vs MainNet). 

The `/v2/exchange/contracts` endpoint can be used to get all available contracts for the given environment.

Alternatively, the current contracts are listed below (may not be updated regularly):

```
export const CONTRACT_HASHES = {
  BLOCKCHAIN_NEO: {
    TEST_NET: {
      V1: '0ec5712e0f7c63e4b0fea31029a28cea5e9d551f',
      'V1.5': 'c41d8b0c30252ce7e8b6d95e9ce13fdd68d2a5a8',
      V2: '48756743d524af03aa75729e911651ffd3cbe7d8',
    },
    MAIN_NET: {
      V1: '0ec5712e0f7c63e4b0fea31029a28cea5e9d551f',
      'V1.5': '01bafeeafe62e651efc3a530fde170cf2f7b09bd',
    },
  },
  BLOCKCHAIN_ETH: {
    TEST_NET: {
      V1: brokerArtifact.networks['4'].address,
    },
  },
}
```
