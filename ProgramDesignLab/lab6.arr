use context dcic2024

# Matej Petkovski



# Task 1


# the first one will give us a calculation, 25 times 0.15 = 3.75
25 * 0.15

# the second one will give us "Electric bike"
"Electric" + " " + "bike"

# the third one will give us the number of characters in the string, 9
string-length("handlebar")



# Task 2


# we define minute rate, give it an annotation and then a value
minute-rate :: Number = 0.15

# ride cost function
fun ride-cost(l :: Number, p :: Number) -> Number:
  doc: "Gives the cost of a ride based on the how long it lasted and the rate"
  
  l * p
  
where: 
  ride-cost(15, 0.5) is 7.5
  ride-cost(0, 0) is 0
  ride-cost(10, minute-rate) is 1.5
end



# Task 3


# discounts for long rides function
fun ride-discount(n :: Number) -> Number:
  doc: "Applies a discount to the price of a ride based on the length of a ride"
  
  if n < 30:
    0
  else if n < 60:
    0.1
  else:
    0.2
  end
  
where:
  ride-discount(0) is 0
  ride-discount(15) is 0
  ride-discount(29) is 0
  ride-discount(30) is 0.1
  ride-discount(40) is 0.1
  ride-discount(59) is 0.1
  ride-discount(60) is 0.2
end



# Task 4


rides = table: rider, minutes, rate
  row: "Ella", 20, 0.15
  row: "Farid", 45, 0.10
  row: "Grace", 70, 0.10
  row: "Hugo", 10, 0.20
end

# adding a new column to a table
rides-with-cost = build-column(rides, "cost", lam(r): r["minutes"] * r["rate"] end)

# filtering a table by the value in the minutes column
filtered-rides = filter-with(rides, lam(r): r["minutes"] >= 30 end)
# Farid and Grace are left


# Task 5


# taking out a column as a list
minutes-list = rides.get-column("minutes")
  
# numbers sum loop function
fun total-minutes-loop(l :: List<Number>) -> Number block:
  doc: "Adds up a list of numbers and returns the sum"
 
  var total = 0
  
  for each(n from l):
    total := total + n
  end
  
  total
where:
  total-minutes-loop([list: 5, 10, 20]) is 35
  total-minutes-loop([list: ]) is 0
end

# numbers sum using fold
fun total-minutes-fold(l :: List<Number>) -> Number:
  doc: "Adds up a list of numbers and returns the sum"
  
  fold(lam(acc, n): acc + n end, 0, l)
  
where: 
  total-minutes-fold([list: 5, 10, 20]) is 35
  total-minutes-fold([list: ]) is 0
end

# checking if they give same values
check:
  total-minutes-loop(minutes-list) is total-minutes-fold(minutes-list)
end



# Task 6

# new data for rides
data Ride:
  | pedal-bike(minutes :: Number)
  | e-bike(minutes :: Number, has-pass :: Boolean)
end

# battery fee function
fun battery-fee(r :: Ride) -> Number:
  doc: "Calculates if a battery fee should be given and how much, depending on type of ride and pass holding status"
  
  cases (Ride) r:
    | pedal-bike(m) => 0
    | e-bike(m, p) => 
      if p == false:
        m * 0.05
      else:
        0
      end
  end
  
where: 
  battery-fee(pedal-bike(5)) is 0
  battery-fee(pedal-bike(0)) is 0
  battery-fee(e-bike(5, false)) is 0.25
  battery-fee(e-bike(5, true)) is 0
  battery-fee(e-bike(0, false)) is 0
end


# sum of numbers in a list function
fun total-minutes-rec(l :: List<Number>) -> Number:
  doc: "Returns the sum of all the numbers in a list"
  
  cases (List) l:
    | empty => 0
    | link(f,r) => f + total-minutes-rec(r)
  end
  
where:
  total-minutes-rec([list: 10, 20]) is 30
  total-minutes-rec([list: ]) is 0
end
