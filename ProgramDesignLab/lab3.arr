use context starter2024

# Exercise 1
fun leapyear(year :: Number):
  doc: "Checks if a given year is a leap year"
  
  if num-modulo(year, 400) == 0:
    true
  else if num-modulo(year, 100) == 0:
    false
  else if num-modulo(year, 4) == 0:
    true
  else:
    false
  end
where:
  leapyear(2024) is true
  leapyear(1500) is false
  leapyear(1600) is true
end


# Exercise 2
fun tick(n :: NumInteger) -> NumInteger:
  doc: "Gives the next second in a minute"
  
  if (n >= 0) or (n <= 59):
  num-modulo(n + 1, 60)
  else:
    0
  end
where: 
  tick(59) is 0
  tick(0) is 1
  tick(-1) is 0
  tick(1.2) is 0
end

tick(59)


# Exercise 3
fun rps(c1 :: String, c2 :: String) -> String:
  doc: "Compares 2 values according to rock paper scissors"
  
  ask:
    | c1 == c2 then: "tie"
    | (c1 == "rock") and (c2 == "paper") then: "c2 wins"
    | (c1 == "rock") and (c2 == "scissors") then: "c1 wins"
    | (c1 == "rock") and (c2 == "rock") then: "tie"
    | (c1 == "paper") and (c2 == "paper") then: "tie"
    | (c1 == "paper") and (c2 == "scissors") then: "c2 wins"
    | (c1 == "paper") and (c2 == "rock") then: "c1 wins"
    | (c1 == "scissors") and (c2 == "paper") then: "c1 wins"
    | (c1 == "scissors") and (c2 == "scissors") then: "tie"
    | (c1 == "scissors") and (c2 == "rock") then: "c2 wins"
    | otherwise: "Invalid input"
end
where: 
  rps("scissors", "rock") is "c2 wins"
end


# Exercise 4
planets = table: name :: String, distance :: Number
  row: "Mercury",	0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end