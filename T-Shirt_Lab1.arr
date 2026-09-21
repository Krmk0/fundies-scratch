use context starter2024


# First we define cost of design, number of shirts for the first and second order, and how much it costs for a new design

t_shirt_design = 12
number_of_shirts = 5
number_of_shirts2 = 7
new_design = 3

# Then we calculate the total cost for both orders, taking into account that each uses a new design

total_cost = (number_of_shirts * t_shirt_design) + new_design

total_cost2 = (number_of_shirts2 * t_shirt_design) + new_design


# Then we print the cost of both orders

"The cost of the first order is " + tostring(total_cost)



"The cost of the second order is " + tostring(total_cost2)




# First we define the dimensions of the poster and the price we use to calculate

poster_width = 420
poster_height = 594
poster_price_calc = 0.10

# We calculate the perimeter and price of the poster

poster_perimeter = 2 * (poster_width + poster_height)

poster_price = (poster_perimeter * poster_price_calc)

# we print the price of the poster

"The cost of the poster is " + tostring(poster_price)
