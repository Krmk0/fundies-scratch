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

