#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  stack = gets.strip
  swaps = 0
  for i in 1...(stack.size)
    swaps +=1 if stack[i] != stack[i-1]
  end
  swaps += 1 if stack[-1] == '-'
  puts swaps
end

