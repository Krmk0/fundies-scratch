use context starter2024

# Traffic Cone

lights = above(circle(15, "solid", "red"), above(circle(15, "solid", "yellow"), circle(15, "solid", "green")))

rectangle_shape = rectangle(40, 100, "solid", "black")

pole = rectangle(5, 20, "solid", "gray")

traffic_light = overlay-xy(lights, -5, -5, rectangle_shape)

above(traffic_light, pole)