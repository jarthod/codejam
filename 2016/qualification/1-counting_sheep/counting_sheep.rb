#!/usr/bin/env ruby
require 'set'

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush
  n = gets.to_i
  i = n
  digits = Set.new(i.to_s.chars.map(&:to_i))
  while digits.size < 10 && i < 100_000_000 && n > 0
    i += n
    digits |= i.to_s.chars.map(&:to_i)
  end
  puts (digits.size >= 10 ? i : "INSOMNIA")
end