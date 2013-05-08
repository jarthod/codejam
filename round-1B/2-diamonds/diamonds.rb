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

gets.to_i.times do |i|
  diamonds, x, y = gets.split.map &:to_i
  secured_pyramids = 0
  while diamonds >= 4*secured_pyramids + 1
    diamonds -= 4*secured_pyramids + 1
    secured_pyramids += 1
  end
  puts "secured: #{secured_pyramids}, ramains: #{diamonds}"
  prob = if (x.abs + y) <= 2 * (secured_pyramids-1)
    1.0 # inside
  elsif (x.abs + y) > 2 * (secured_pyramids)
    0.0 # outside
  else
    side = secured_pyramids * 2
    if y < diamonds - side
      1.0
    else
      probs = []
      p probs
      nil
    end
  end
  puts "Case ##{i+1}: #{prob}"
end

