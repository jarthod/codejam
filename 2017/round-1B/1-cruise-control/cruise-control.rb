#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  d, n = gets.split.map &:to_i
  time = 0
  n.times do
    k, s = gets.split.map &:to_f
    time = [time, (d-k) / s].max
  end
  puts "%.6f" % [d / time]
end

