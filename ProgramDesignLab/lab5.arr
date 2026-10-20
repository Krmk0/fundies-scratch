use context dcic2024

include csv
include data-source

#|
   We import a table containing flights, and their details. As the table data is not perfect, we need to handle the missing data, clean the data and identify the duplicates.
   Some examples of this kind of data:
   -dep_delay and arr_delay that have values below 0 should be set to 0.
   -carrier has values that are lowercase as opposed to upper and have spaces before and after.
   -tailnum has some missing values that should be replaced with UNKNOWN
|#
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
  
  source: csv-table-file("flights_sample53.csv", default-options)
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


fun fix-empty(s :: String) -> String:
  doc: "Corrects missing values in tailnum column with UNKNOWN"
  if s == "":
    "UNKNOWN"
  else:
    s
  end
where:
  fix-empty("") is "UNKNOWN"
end

#Creting a new table using the function we made to fix the empty values in tailnum
fixed = transform-column(flights, "tailnum", fix-empty)

fixed

#Creating a function that checks negative values in dep_delay and if the value is negative changes it to 0, else keeps the same
fun fix-negatives(x):
  if x < 0:
    0
  else:
    x
  end
end

#Creating a new table and transforming the dep_delay column to fix the negative values using the function we created
fixed-dep = fixed.transform-column("dep_delay", fix-negatives)

#Creating a new table and transformin the arr_delay column to fix the negative values using the function we created
fixed-flights = fixed-dep.transform-column("arr_delay", fix-negatives)

fixed-flights

# Now the duplicates and normalizing carrier values

# Trim spaces at both ends
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
end


# Combining flight, carrier, and dep_time to identify duplicate entries.
# Create a new column called dedup_key that concatenates these three string values as a single string (e.g., "1053-UA-18:00").
# Normalizes time by converting the values to string, but also checking if the minutes are 0, if they are to add one more 0. Then we combine them.

new-column = build-column(build-column(build-column(fixed-flights, "number-clean", lam(row :: Row):
      num-to-string(row["flight"]) end), "carrier-clean", lam(row :: Row): 
    string-to-upper(trim(row["carrier"])) end), "time-clean", lam(row :: Row):
    hour = num-to-string(row["hour"])
    minute = row["minute"]
    
    if
      minute < 10:
      hour + ":0" + num-to-string(minute)
      else:
    hour + ":" + num-to-string(minute)
    end
  end)
      
# New dedup-key column
flights-with-key = build-column(new-column, "dedup-key", lam(row :: Row):
  row["number-clean"] + "-" + row["carrier-clean"] + "-" + row["time-clean"] end)

flights-with-key


# Group rows that have the same key
grouped-flights = group(flights-with-key, "dedup-key")

# Count occurrences of each key
flight-counts = count(flights-with-key, "dedup-key")

# Keep only keys that occur more than once
duplicates = filter-with(flight-counts,
  lam(row :: Row):
    row["count"] > 1
  end)

duplicates

# Frequecy bar chart
freq-bar-chart(flights-with-key, "carrier-clean")

# Histogram
histogram(flights-with-key, "distance", 100)

# Distance on the x-axis, air time on the y-axis
scatter-plot(flights-with-key, "distance", "air_time")

# Extract as list
list1 = flights-with-key.get-column("distance")



# Calculate total, average, and maximum
var total = 0
var maximum = 0

for each(dist from list1) block:
  total := total + dist

  if dist > maximum:
    maximum := dist
  else:
    nothing
  end
end

average = total / length(list1)

total
average
maximum