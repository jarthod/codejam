#!/usr/bin/env ruby


def numbers n
  return n if n < 10
  str = n.to_s
  minor = str[str.size/2..-1].to_i
  # puts "numbers(#{n}) minor #{minor}"
  return numbers(n - minor + 1) + minor - 1 if minor > 1
  rev = str.reverse.to_i unless n % 10 == 0
  if rev and rev < n
    # puts "#{rev} -> #{n}"
    numbers(rev) + 1
  else
    numbers(n-1) + 1
  end
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n = gets.to_i
  puts numbers(n)
end

