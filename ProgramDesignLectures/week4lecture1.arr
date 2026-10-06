use context dcic2024
include csv
include data-source

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00 # i2
  row: "11:00", 3.95 # i3
  row: "14:00", 4.95 # i4
  row: "16:45", 7.95
end

fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.0
where:
  is-high-value(orders.row-n(2)) is true
  is-high-value(orders.row-n(3)) is false
  is-high-value(orders.row-n(4)) is false
end


new-high-orders = filter-with(orders, is-high-value)

# Instead of creating a new function just to sort the highers than 8, we can use lambda or lam() to create like a temporary nameless function

filter-with(orders, lam(o :: Row): o["amount"] >= 8.0 end)


#order-by
asc = order-by(orders, "amount", true) # true = ascending
dsc = order-by(orders, "amount", false) # false = descending



# Exercise 1

fun is-morning(r :: Row) -> Boolean:
  r["time"] <= "12:00"
where:
  is-morning(orders.row-n(2)) is true
end


only-mornings = filter-with(orders, is-morning)

only-mornings-lam = filter-with(orders, lam(r :: Row): r["time"] <= "12:00" end)

sorted-time = order-by(orders, "time", false)


# Exercise 2

photos = load-table:
  Location :: String,
  Subject :: String,
  Date :: String
  source: csv-table-file("photos.csv", default-options)
  sanitize Date using string-sanitizer
  sanitize Subject using string-sanitizer
end

forest-filtered = filter-with(photos, lam(r :: Row): r["Subject"] == "Forest" end)

forest-sorted = order-by(forest-filtered, "Date", true)
forest-sorted.row-n(0)["Location"]

location-count = count(forest-sorted, "Location")
location-sorted = order-by(location-count, "count", false)