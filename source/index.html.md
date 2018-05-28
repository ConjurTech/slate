---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/lord/slate'>Documentation Powered by Slate</a>

includes:
  - api/currency_pairs
  - api/intents
  - api/settlements
  - api/orders
  - api/offers
  - api/trades
  - api/balances
  - api/withdrawals
  - api/deposits
  - errors

search: true
---

# Introduction

Welcome to the Switcheo Exchange API.

The Switcheo API follows the [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) architecture.
It has endpoints that grant access to real-time or historical trade information
and also allows management of [orders](#orders) on Switcheo Exchange.
API responses will be in the form of [JSON](https://www.json.org/) and [errors](#errors) are standard http errors.
You can visit Switcheo Exchange at [https://switcheo.exchange](https://switcheo.exchange).

