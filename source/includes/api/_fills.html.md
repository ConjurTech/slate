# Fills

* Fills represent the user's intention to fill a buy or sell [offer](#offers) that another user has created, in agreement
to the stated price.
* Fill(s) with `"pending"` statuses are generated when [orders](#orders) are created.
* When the [order](#orders) containing the fill is [broadcast](#broadcast-orders), a [trade](#trades) is created.
* Fills with `"pending"` statuses are **expired** after **3 minutes**.
* Fills can be seen in the confirmation modal which shows up when the user 
attempts to buy or sell trading pairs on [Switcheo Exchange](#https://switcheo.exchange).
