use context dcic2024

data Comment:
    comment(author :: String, text :: String, likes :: Number, replies :: List<Comment>)
end

r1 = comment("@user1", "I am feeling anxious", 4, [list: ])
c1 = comment("@user2", "We are about to get our grades", 15, [list: r1])
c2 = comment("@user3", "One of the greatest comebacks!!! #GOAT", 30, [list: ])
r2 = comment("@user45", "Today is super cold!!! Hot chocolate?", 5, [list: ])
r3 = comment("@user65", "I'm very happy today", 40, [list: ])
c3 = comment("@user7", "the London weather is not for everyone", 3, [list: r2, r3])

thread = comment("@user54", "Thunderstorm warning for Thursday", 120, [list: c1, c2, c3])


fun count-comments(c :: Comment) -> Number:
  doc: "How many comments are in the thread"
  1 + count-comments-list(c.replies)
where: 
  count-comments(r1) is 1
  count-comments(c3) is 3
  count-comments(thread) is 7
end


fun count-comments-list(cs :: List<Comment>) -> Number:
  doc: "how many comments are in all the threads"
  cases (List) cs:
    | empty => 0
    | link(f,r) => count-comments(f) + count-comments-list(r)
  end
end


fun count-likes(c :: Comment) -> Number:
  doc: "Count how many likes in the thread"
  c.likes + count-likes-list(c.replies)
where:
  count-likes(r1) is 4
  count-likes(c1) is 19
end


fun count-likes-list(cs :: List<Comment>) -> Number:
  doc: "how many likes are in all the threads"
  cases (List) cs:
    | empty => 0
    | link(f,r) => count-likes(f) + count-likes-list(r)
  end
end

# Which comments got no reply?
fun got-reply(c :: Comment) -> Boolean:
  doc: "Checks if a comment ahs a reply"
  c.replies <> [list: ]
where:
  got-reply(c1) is true
  got-reply(r1) is false
end
