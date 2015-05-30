#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  shyness = gets.split.last.split(//).map &:to_i
  up = 0
  missing = 0
  shyness.each_with_index do |n, i|
    if n > 0
      off = [i - up, 0].max
      missing += off
      up += n + off
    end
  end
  puts missing
end

