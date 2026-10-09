use context dcic2024

#|
   The two operations: 
   1 - transform-column: 
     your function takes: one value, you get back: same columns, new values in one
   
   2 - build column:
     your function takes: one whole row, you get back: one extra column
|#

sales = table: item :: String, price :: Number, qty :: Number
  row: "Tea", 2.50, 4
  row: "Coffee", 3.00, 2
  row: "Cake", 4.25, 3
end

sales.get-column("price")
#transform column
#add VAT to every price.

with-vat = transform-column(sales, "price", lam(p :: Number): p * 1.2 end)
with-vat.get-column("price")

#build-column
#| fun line-total(r :: Row) -> Number:
  doc: "returns price times quantity for one order line"
  r["price"] * r["qty"]
where:
  line-total(sales.row-n(0)) is 10
   end |#

# Seperate 

with-total = build-column(sales, "total", lam(r :: Row): r["price"] * r["qty"] end)
with-total
with-total.get-column("total")

total-updated = build-column(with-vat, "total", lam(r :: Row): r["price"] * r["qty"] end)
total-updated
total-updated.get-column("total")

# Chained

billed = build-column(transform-column(sales, "price", lam(p :: Number): p * 1.2 end), "total", lam(r :: Row): r["price"] * r["qty"] end)
billed

#build-column(name of table, "new column name", func or lam)
#transform-column(name of table, "name of value to change", func or lam)

# Exercises

# E 1

items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

items-closer = items
  .transform-column("x-coordinate", lam(r :: Number): r * 0.9 end)
  .transform-column("y-coordinate", lam(r :: Number): r * 0.9 end)


with-distance = build-column(items-closer, "distance",
  lam(r :: Row): (r["x-coordinate"] * r["x-coordinate"]) + (r["y-coordinate"] * r["y-coordinate"]) end)

sorted-distance = order-by(with-distance, "distance", true)
sorted-distance.row-n(0)
