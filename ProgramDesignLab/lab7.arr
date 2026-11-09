use context dcic2024

# Defining data
data SensorNet:
  | hub(bandwidth :: Number, left :: SensorNet, right :: SensorNet)
  | sensor(rate :: Number)
end

# Defining 
sA = sensor(60)
sB = sensor(120)
sC = sensor(45)
hub1 = hub(150, sA, sB)
core = hub(200, hub1, sC)



# Task 1

fun total-load(n :: SensorNet) -> Number:
  doc: "Returns the sum of all sensor rates"
  cases (SensorNet) n:
    | hub(band, left, right) => total-load(left) + total-load(right)
    | sensor(rate) => rate
  end
where: 
  total-load(core) is 225
end



# Task 2

fun fits-capacities(n :: SensorNet) -> Boolean:
  doc: "true if every hub's bandwidth is at least as large as the total load of its left and right sub-networks, and false otherwise."
  cases (SensorNet) n:
    | sensor(load) => true
    | hub(bandwidth, left, right) =>
        (bandwidth >= (total-load(left) + total-load(right))) and
        fits-capacities(left) and
        fits-capacities(right)
  end
where:
  fits-capacities(hub1) is false
  fits-capacities(sB) is true
end



# Task 3
      
fun deepest-depth(n :: SensorNet) -> Number:
  doc: "Returns the depth of the deepest sensor in a given SensorNet"
  cases (SensorNet) n:          
    | sensor(name) => 0
    | hub(name, left, right) =>
      left-depth = deepest-depth(left)
      right-depth = deepest-depth(right)
      1 + num-max(left-depth, right-depth)
  end
where:
  deepest-depth(core) is 2
  deepest-depth(hub1) is 1
end



# Task 4

# helper function
fun needed-scale(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | sensor(rate)  => 1
    | hub(bw, l, r) =>
      block:
        load = total-load(l) + total-load(r)
        here = load / bw
        num-max( num-max(here, needed-scale(l)), needed-scale(r) )
      end
  end
where:
  # For 'core': max(225/200 = 1.125, hub1: 180/150 = 1.2) = 1.2
  needed-scale(core) is 1.2
end


# apply function
fun apply-scale(n :: SensorNet, s :: Number) -> SensorNet:
  cases (SensorNet) n:
    | sensor(rate) => sensor(rate / s)
    | hub(bw, l, r) =>
      hub(bw, apply-scale(l, s), apply-scale(r, s))
  end
where:
  total-load(apply-scale(core, 1.2)) is 187.5
  total-load(apply-scale(hub1, 1.2)) is 150
  total-load(apply-scale(core, 2)) is 112.5
  total-load(apply-scale(core, 1)) is 225
end