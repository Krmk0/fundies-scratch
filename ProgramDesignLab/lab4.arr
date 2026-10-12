use context dcic2024

include csv
include data-source

# Table
flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  
  source: csv-table-file("flights.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize carrier using string-sanitizer
  sanitize flight using num-sanitizer
  sanitize tailnum using string-sanitizer
  sanitize origin using string-sanitizer
  sanitize dest using string-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
  sanitize time_hour using string-sanitizer
end


# Exercise 1
fun is_long_flight(row :: Row) -> Boolean:
  doc: "Checks if a row has a value bigger or equal that 1500 in distance and returns boolean value, for sorting a table by distance"
  row["distance"] >= 1500
  
where:
  is_long_flight(flights.row-n(0)) is false
end

# Creating a table that is filtered by the function
filtered_1 = filter-with(flights, is_long_flight)

# Creating a table that is ordered descending by air_time
ordered = order-by(filtered_1, "air_time", false)

# Extracting values from row one
ordered.row-n(0)["carrier"] 
ordered.row-n(0)["origin"]
ordered.row-n(0)["dest"]

ordered

# Exercise 2

fun is_delayed_departure(row :: Row) -> Boolean:
  doc: "Checks if a row has a value bigger or equal to 30 and returns a boolean value, for sorting a table by dep_delay"
  row["dep_delay"] >= 30
  
where:
  is_delayed_departure(flights.row-n(0)) is false
end


fun is_morning_sched_dep(row :: Row) -> Boolean:
  doc: "Checks if a row has a value smaller than 1200 and returns a boolean value, for sorting a table by dep_time"
  row["sched_dep_time"] < 1200
  
where:
  is_morning_sched_dep(flights.row-n(0)) is true
end

# Create a new table that filters by chaining 2 lambda functions, like the ones above

filtered_2 = filter-with(filter-with(flights, lam(row :: Row) -> Boolean: row["dep_delay"] >= 30 end), lam(row :: Row) -> Boolean: row["sched_dep_time"] < 1200 end)
filtered_2

# Create a new table that filters again by distance
filtered_dist = filter-with(filtered_2, lam(row :: Row) -> Boolean: row["distance"] > 500 end)
filtered_dist

# Create a new table that then orders by dep_delay
ordered_2 = order-by(filtered_dist, "dep_delay", false)
ordered_2

# Extracting values from row one
ordered_2.row-n(0)["flight"]
ordered_2.row-n(0)["origin"]
ordered_2.row-n(0)["dep_delay"]


# Exercise 3

# First transform
transformed = transform-column(flights, "dep_delay", lam(delay :: Number) -> Number: if delay < 0: 0 else: delay end end)

# Second transform
transformed_2 = transform-column(transformed, "arr_delay", lam(delay :: Number) -> Number: if delay < 0: 0 else: delay end end)

# Adding a column
new-column = build-column(transformed_2, "effective_speed", lam(air :: Row) -> Number: if air["air_time"] > 0: air["distance"] / (air["air_time"] / 60) else: 0 end end)

ordered_3 = order-by(new-column, "effective_speed", false)

# Extracting values from row one
ordered_3.row-n(0)["carrier"]
ordered_3.row-n(0)["origin"]
ordered_3.row-n(0)["dest"]


# Exercise 4

fun apply-arrival-discount(t :: Table) -> Table:
  doc: "Takes a table and reduces arr_delay by 20% only if its value is more or equal to 0 but less than or equal to 45"
  
  transform-column(t, "arr_delay", lam(x :: Number) -> Number: if (x >= 0) and (x <= 45): x * 0.8 else: x end end)
  
where: 
  apply-arrival-discount(
    table: arr_delay :: Number
      row: -10
      row: 0
      row: 30
      row: 60
    end) 
  is
    table: arr_delay :: Number
      row: -10
      row: 0
      row: 24
      row: 60
end
end

# Create a table to with discounts
discounts = apply-arrival-discount(flights)


# Add a new column
score = build-column(transformed_2, "on_time_score", lam(row :: Row) -> Number: 
    # Defining new values in lam from table values
    dep = row["dep_delay"] 
    arr = row["arr_delay"] 
    air = row["air_time"]
    
    # Checking negative values
  dep-fixed = if dep < 0: 0 else: dep end
  arr-fixed = if arr < 0: 0 else: arr end
    
    # Equation for score
  score = 100 - (dep-fixed - arr-fixed) - (air / 30)
    
    # Check score if negative
  if score < 0:
    0
  else:
    score
  end
end)

# Ordering
ordered_4 = order-by(order-by(score, "on_time_score", false), "distance", false)


# Extracting values from row one
ordered_4.row-n(0)["carrier"]
ordered_4.row-n(0)["origin"]
ordered_4.row-n(0)["origin"]
ordered_4.row-n(0)["dest"]

# Extracting values from row two
ordered_4.row-n(1)["carrier"]
ordered_4.row-n(1)["origin"]
ordered_4.row-n(1)["origin"]
ordered_4.row-n(1)["dest"]