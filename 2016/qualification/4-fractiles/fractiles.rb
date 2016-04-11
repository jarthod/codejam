#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  k, c, s = gets.split.map &:to_i
  if c == 1
    if s >= k
      puts (1..k).to_a.join(' ')
    else
      puts "IMPOSSIBLE"
    end
  else
    out = []
    (1..k).each_slice(2) do |x, y|
      out << (x-1) * (k**(c-1)) + (y || x)
    end
    if out.size <= s
      puts out.join(' ')
    else
      puts "IMPOSSIBLE"
    end
  end
end