use context dcic2024
include csv
include data-source

#|
   plan a task before coding it
   finding and cleaning dirty data
   visualisation
|#

# task plan is a to-do list you can check off
#|
   input = the columns you start from
   output = a concrete example of what you want at the end
   steps = small enough that each one is a single function or table operation
   tools = the operation for each step: filter-with, transform-column
|#

voter-data = load-table: VoterID, DOB, Party, Address, City, County, Postcode
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/voters.csv", default-options)
end

    
#Confirm the party problem
filter-with(voter-data, lam(r): r["Party"] == "Labour" end).length()

#Check all values in a table by how many are present
order-by(count(voter-data, "Party"), "count", false)

#Reading one value with get-column

fun get-column(r :: Row, colname :: String): 
  doc: "Returns the value in row r for the column colname"
  r[colname]
where:
  get-column(voter-data.row-n(3), "Party") is "Labuor"
  get-column(voter-data.row-n(0), "VoterID") is "1"
end

filter-with(voter-data, lam(r): get-column(r, "Party") == "Labour" end).length()
get-column(voter-data.row-n(3), "Party")

with-year = build-column(voter-data, "BirthYear", lam(r): string-substring(get-column(r, "DOB"), 6, 10) end)
get-column(with-year.row-n(0), "BirthYear")

#fixing typo
fun fix-typo(s :: String) -> String:
  doc: "Corrects the one known misspelling of labour"
  if s == "Labuor":
    "Labour"
  else if s == "":
    "None"
  else:
    s
  end
where:
  fix-typo("Labuor") is "Labour"
  fix-typo("") is "None"
  fix-typo("Green Party") is "Green Party"
end

fixed = transform-column(voter-data, "Party", fix-typo)
fixed

freq-bar-chart(fixed, "Party")

ordered = order-by(count(fixed, "Party"), "count", false)
