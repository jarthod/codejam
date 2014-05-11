#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  a, b, k = gets.split.map &:to_i
  a, b = [a, b].min, [a, b].max
  sum = 0
  for i in 0...a
    if i < k
      sum += b
    else
      sum += k
    end
  end
  puts sum
end

