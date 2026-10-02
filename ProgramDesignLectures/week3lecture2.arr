use context dcic2024
include csv
include data-source

#|workouts = table: date :: String, activity :: String, duration :: Number
  row: "2026-04-01", "Running", 30
  row: "2026-04-02", "Swimming", 20
  row: "2026-04-03", "Cycling", 60
end

   workout|#

check:
  table: date :: String, activity :: String, duration :: Number
  row: "2026-04-01", "Running", 30
  row: "2026-04-02", "Swimming", 20
  row: "2026-04-03", "Cycling", 60
end
  
  #is-not
  is
  
  table: date :: String, activity :: String, duration :: Number
  row: "2026-04-01", "Running", 30
  row: "2026-04-02", "Swimming", 20
  row: "2026-04-03", "Cycling", 60
  end
end



workouts = table: date :: String, activity :: String, duration :: Number
  row: "2026-04-01", "Running", 30
  row: "2026-04-02", "Swimming", 20
  row: "2026-04-03", "Cycling", 60
end

#find the value for the whole row
first-row = workouts.row-n(0)
first-row

#find a value in a row
workouts.row-n(1)["activity"]
workouts.row-n(1)["duration"]

#number of rows
workouts.length()

#get all values in a column
workouts.get-column("activity")

#basic stats
mean(workouts, "duration")
median(workouts, "duration")
sum(workouts, "duration")
stdev(workouts, "duration")
modes(workouts, "activity")

#import csv from url

recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/recipes.csv", default-options)
  sanitize servings using num-sanitizer
  sanitize prep-time using num-sanitizer
end

#include csv and data-source
recipes

recipes.length()

mean(recipes, "prep-time")


plants = load-table:
  plantname :: String,
  latitude :: Double,
  longitute :: Double,
  date :: String,
  soil :: String,
  height :: Double,
  color :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
end

plants

plants.length()
plants.row-n(99)
plants.get-column("plantname")


glucose = load-table:
  patient_id :: Number,
  glucose_level :: Double,
  date :: String,
  dose :: Double,
  exercise :: Double,
  stress :: Number
  source: csv-table-file("glucose_levels.csv", default-options)
end

glucose