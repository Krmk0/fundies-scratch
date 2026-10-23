use context dcic2024

#|
   cases (List) l:
   | empty => ... #the answer for no elements
   | link(f, r) => ... #combine f with the answer for r
   end
|#

[list: 1, 2, 3].first
[list: 1, 2, 3].rest
[list: 1].rest
is-link([list: 1, 2, 3].rest) # true
is-empty([list: ]) # true
is-empty([list: 3].rest) # true 

#building lists with link:

check:
  [list: ] is empty
  [list: 1] is link(1, empty)
  [list: 1, 2] is link(1, link(2, empty))
  [list: 1, 2, 3] is link(1, link(2, link(3, empty)))
end

temp-list = link(1, link(2, link(3, empty)))
temp-list.length()

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 1, 2, 3, 4, 5, 6]) is 6
end

my-len([list: 3, 4])

check "some of my-len examples":
  my-len([list: 1, 2, 3]) is 3
  my-len([list: ]) is 0
  my-len([list: 7, 8, 9]) is 1 + my-len([list: 8, 9])
  my-len([list: 7, 8, 9]) is 1 + my-len([list: 7, 8, 9].rest)
  my-len([list: 1, 2, 3]) is 3 + my-len([list: ])
  my-len([list: 9]) is 1 + my-len([list: 9].rest)
end

fun my-sum(l):
  cases (List) l:
    | empty => 0
    | link(f,r) => f + my-sum(r)
  end
where:
  my-sum([list: 1, 2, 3]) is 6
end
  
my-sum([list: 1, 2, 56, 2])

#my-double and the mistake
[list: 3 * 2, [list: 10, 4]] #[list: 6, [list: 10, 4]]
link(3 * 2 , [list: 10, 4]) # [list: 6, 10, 4]

fun my-double(l):
  cases (List) l:
    | empty => empty
    | link(f, r) => link(f * 2, my-double(r))
  end
where:
  my-double([list: 3, 5, 2]) is [list: 6, 10, 4]
end

check:
  my-double([list: 3, 5, 2]) is link(6, link(10, link(4, empty)))
end

# connect strings
fun string-concat(l):
  cases (List) l:
    | empty => ""
    | link(f, r) => f + " " + string-concat(r)
  end
end
 string-concat([list: "Hello", "my name is", "matej"])

# upper case
fun strings-upper(l):
  cases (List) l:
    | empty => ""
    | link(f, r) => string-to-upper(f) + " " + strings-upper(r)
  end
end

strings-upper([list: "Hello", "my name is", "matej"])


# decimal
fun round-numbers(l) -> List<Number>:
  cases (List) l:
    | empty => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
end

round-numbers([list: 4.2, 5.7, 0])