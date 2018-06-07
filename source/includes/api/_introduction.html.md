# Overview

## Introduction
Welcome to the Switcheo API documentation.

This documentation is intended for developers who want to write applications to interact with Switcheo
and also users who want to gain some context about the underlying system of Switcheo.<br/>
There will be basic explanations of the concepts of Switcheo.
Instructions of how to use API supported functions and detailed overviews of the existing API will also be provided.<br/>

Before you proceed with the API documentation, be sure to explore Switcheo Exchange at [https://switcheo.exchange](https://switcheo.exchange)

## System terminology

Reource | Description
--------- | -----------
[Order](#orders) | Use this to buy or sell assets.
[Offers](#offers) | Orders that are waiting to be filled in the order book.
[Trades](#trades) | Orders that execute fills on offers. 
Contract balance | Funds present in Switcheo's smart contract. You need to deposit funds here to create orders.  

## API
The Switcheo API follows the [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) architecture.
API responses will be in the form of [JSON](https://www.json.org/) or arrays.
[Errors](#errors) are standard HTTP errors.

Switcheo API has several endpoints that allows these functions on Switcheo:

1. Depositing of funds into the Switcheo smart contract
2. Withdrawal of funds from the Switcheo contract
3. Access to real-time or historical trade information.<br/>
4. Access to order book information.
5. Management of orders.  
