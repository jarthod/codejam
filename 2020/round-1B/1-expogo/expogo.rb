#!/usr/bin/env ruby

def reverse_find_path from:, to:
  0.upto(40) do |n|
    path = []
    x, y = from
    res = while n >= 0
      if x.abs > y.abs
        if x > 0
          path.unshift "E"
          x -= 2**n
        elsif x < 0
          path.unshift "W"
          x += 2**n
        else
          break :incomplete
        end
      else
        if y > 0
          path.unshift "N"
          y -= 2**n
        elsif y < 0
          path.unshift "S"
          y += 2**n
        else
          break :incomplete
        end
      end
      n -= 1
    end
    next if res == :incomplete
    if x == 0 and y == 0
      return path.join
    end
  end

  return "IMPOSSIBLE"
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  x, y = gets.split.map &:to_i
  puts reverse_find_path(from: [x, y], to: [0, 0])
end

