#!/usr/bin/env ruby

# symetric pyramid size:
# 1 => 1
# 2 => 6 (+ 5)
# 3 => 15 (+ 9)
# 4 => 28 (+ 13)

#     /\
#    /\/\
#   /\/\/\
#  /\/\/\/\
# /\/\/\/\/\
# \/\/\/\/\/
# lay: 1 2 3

def fact n
  (1..n).inject(:*) || 1
end

def combi k, n
  fact(n) / (fact(k) * fact(n-k))
end

def prob diamonds, height, y
  # puts "prob #{diamonds}, #{height}, #{y}"
  if y < 0
    1.0
  elsif diamonds <= 0
    0.0
  elsif diamonds > height
    prob(diamonds - 2, height - 1, y - 1)
  # elsif y == 0
  #   (2**diamonds - 1).to_f / (2**diamonds)
  else
    ((y+1)..diamonds).to_a.map {|x| combi(x, diamonds)}.reduce(:+).to_f / (2**diamonds)
    # diamonds - 1, height, y - 1) * 0.5
  end
end

gets.to_i.times do |i|
  diamonds, x, y = gets.split.map &:to_i
  secured_layers = 0
  layer = (x.abs + y) / 2 + 1
  while diamonds >= 4*secured_layers + 1
    diamonds -= 4*secured_layers + 1
    secured_layers += 1
  end
  # puts "secured: #{secured_layers}, ramains: #{diamonds}"
  # puts "target on layer #{layer}"
  prob = if layer <= secured_layers
    1.0 # inside
  elsif layer > secured_layers + 1
    0.0 # outside
  else
    height = secured_layers * 2
    prob(diamonds, height, y) # distributed
  end
  puts "Case ##{i+1}: #{prob}"
end

