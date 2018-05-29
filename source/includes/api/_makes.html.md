# Makes

* Makes represents the user's intention to create a buy or sell [offer](#offers).
* Makes with the `"pending"` status are generated when [orders](#orders) are [created](#create-orders).
* When the [order](#orders) containing the make is [broadcast](#broadcast-orders), a [offer](#offers) is created.
* Makes with `"pending"` statuses are **expired** after **3 minutes**.
* Makes can be seen in the confirmation modal which shows up when the user 
attempts to buy or sell trading pairs in [Switcheo Exchange](#https://switcheo.exchange).
