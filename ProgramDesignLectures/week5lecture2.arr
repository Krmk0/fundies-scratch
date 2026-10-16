use context dcic2024
import math as M
import statistics as S

#linked-list 

cafe-data = table: day, drinks-sold
  row: "Mon", 45
  row: "Tue", 30
  row: "Wed", 55
  row: "Thu", 40
  row: "Fri", 60
end

sales = cafe-data.get-column("drinks-sold")

#basic stats
M.max(sales)
S.mean(sales)
S.median(sales)
M.sum(sales)

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]
unique-codes = distinct(discount-codes)

fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end
real-codes = filter(is-real-code, unique-codes)
first-code = real-codes.get(0)
lower-codes = map(string-to-lower, real-codes)

new-lower-codes = map(string-to-lower, discount-codes)

new-real-codes = map(is-real-code, new-lower-codes)
new-first-code = new-real-codes.get(0)

distinct(filter(is-real-code, map(string-to-lower, discount-codes)))

sales.sort()
sales.sort().reverse()

var total = 1
total := total + 10

fun my-sum(num-list :: List) -> Number block:
  var running = 0
  for each(n from num-list):
    running := running + n
  end
  running
  where:
  my-sum([list: 0, 1, 2, 3]) is 6
  my-sum([list: ]) is 0
end


fun drinks-sum(num-list :: List) -> Number block:
  var sum-d = 0
  for each(n from num-list):
    sum-d := sum-d + n
  end
  sum-d
end

drinks-sum(sales)

#or just

M.sum(sales)

#make new list

fun add-two(numbers :: List<Number>) -> List<Number> block:
  doc: "adds two to each number in a list"
  var added-two = [list: ]
  for each(n from numbers):
    added-two := added-two.append([list: n + 2])
  end
  added-two
where:
  add-two([list: 1, 2, 3]) is [list: 3, 4, 5]
end

#VAT

fun add-vat(numbers :: List<Number>) -> List<Number> block:
  doc: "Returns the 20% VAT on each price in a list"
  var added-vat = [list: ]
  for each(n from numbers):
    added-vat := added-vat.append([list: n * 0.2])
  end
  added-vat
where:
  add-vat([list: 10, 50, 100]) is [list: 2, 10, 20]
  add-vat([list: ]) is [list: ]
end


fun add-vat-to-price(numbers :: List<Number>) -> List<Number> block:
  doc: "Returns the price with 20% VAT added on each price in a list"
  var added-vat = [list: ]
  for each(n from numbers):
    added-vat := added-vat.append([list: n * 1.2])
  end
  added-vat
where:
  add-vat-to-price(sales) is [list: 54, 36, 66, 48, 72]
  add-vat-to-price([list: ]) is [list: ]
end

add-vat-to-price(sales)

#with lambda
map(lam(p): p + (p * 0.2) end, sales) 

#fold: the loop template without the var
#fold :: (f :: (Basem Elt -> Base), base :: Base, lst :: List <Elt>) -> Base

# 3 inputs, a starting value, a rule, the list
fun my-sum-fold(num-list :: List<Number>) -> Number:
  doc: "docs"
  fold(lam(acc, n): acc + n end, 0, num-list)
where:
  my-sum-fold([list: 0, 1, 2, 3]) is 6
  my-sum-fold([list: ]) is 0
end

#|
   fold(lam(acc, n): acc + n end, 0, [list: 45, 30, 55]) 
   answer is 130
   
   answers so far: 0, 45, 75
   next item: 45, 30, 55
   new answer: 45, 75, 130
|#