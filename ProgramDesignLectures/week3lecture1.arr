use context starter2024

check:
  true is true
  not(true) is false
  
  #and
  true and true is true
  false and true is false
  false and false is false
  (3 > 1) and ((4 * 2) == 8) is true
  (5 < 2) and ((2 + 3) == 5) is false
  
  #or
  true or false is true
  false or false is false
  ((3 * 7) == 21) or ("a" == "b") is true
  
end

fun choose-hat(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear, with above 27C a sun hat, below nothing"
  
  if temp-in-C > 27:
    "sun hat"
  else:
    "no hat"
  end
  
where:
  choose-hat(25) is "no hat"
  choose-hat(32) is "sun hat"
  choose-hat(27) is "sun hat"
end

