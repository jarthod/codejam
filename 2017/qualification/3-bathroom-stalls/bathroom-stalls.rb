#!/usr/bin/env ruby

# 0.....0
#  i    j
#  012345
def place(peeps, i, j)
  # puts "place(#{peeps}, #{i}, #{j})"
  return [0, 0] if (j-i) == 1
  return [(j-i)/2, (j-i-1)/2] if peeps == 1

  split = (j+i-1)/2
  if (peeps-1) % 2 == 0
    return place((peeps-1)/2, i, split)
  else
    return place((peeps)/2, split+1, j)
  end
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n, k = gets.split.map &:to_i
  res = place(k, 0, n)
  puts res.join(' ')
end

