use context starter2024


#STRINGS


a = "Hi"
a


string-length(a)
string-repeat(a + ' ', 3)

"CS" + "2000"


string-to-upper("hello cs2000") # -> HELLO CS2000 (string-toupper)

string-to-lower("HELLO CS2000") # -> hello cs2000 (string-tolower)

string-substring("Welcome to London", 0, 7) # -> to get substring (part of string)


sample_string = "Hello, how are you? My name is Jeff, and I am from London"

string-contains(sample_string, "Jeff") # -> To check if certain characters exist in a string
string-contains(sample_string, "jeff") # -> Case sensitive


# EXERCISE 


exercise_string = "First exercise we gotta do"

#|case-Lower|# string-contains(string-tolower(exercise_string), "exercise")

#|case-Upper|# string-contains(string-toupper(exercise_string), "EXERCISE")


string_space = "           "
string_space
string_space
string_space


# IMAGES

circle(30, "solid", "green")

rectangle(40, 20, "solid", "green")

triangle(50, "outline", "red")

#composition, each of these take two iamges and gives back one image

#overlay(firstimage(details), secondimage(details))
overlay(circle(30, "solid", "blue"), rectangle(80, 60, "solid", "yellow"))

#above(firstimage(details), secondimage(details))
above(square(20, "solid", "red"), rectangle(60, 60, "outline", "yellow"))

#below(firstimage(details), secondimage(details))
below(square(20, "solid", "red"), rectangle(60, 60, "outline", "yellow"))

#beside(firstimage(details), secondimage(details))
beside(square(20, "solid", "red"), rectangle(60, 60, "outline", "yellow"))



#EXERCISE 2

overlay(text("STOP", 30, "white"),
  overlay(regular-polygon(35, 8, "solid", "red"), regular-polygon(40, 8, "outline", "yellow"))
  )
