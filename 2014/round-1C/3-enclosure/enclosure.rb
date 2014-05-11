#!/usr/bin/env ruby

def min_size n, m , k
  return k if k <= 4
  width = 1
  height = 1
  block = 5
  corners = 0
  while block < k
    if width < height or height >= m - 2
      if width < n - 2
        width += 1
        block += 2 + height
      else
        corners += 1
        block += 1
      end
    else
      height += 1
      block += 2 + width
    end
  end
  width*2 + height*2 + corners
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n, m, k = gets.split.map &:to_i
  puts min_size(n, m , k)
end

