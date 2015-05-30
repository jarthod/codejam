#!/usr/bin/env ruby

def swaps_to_be_below(pancakes, threshold)
  pancakes.select {|p| p > threshold}.map {|p| p - threshold}.inject(0) {|s, v| s + (v.to_f / threshold).ceil }
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  gets
  pancakes = gets.split.map(&:to_i).sort
  max = pancakes.last
  res = (1..max).to_a.map do |n|
    n + swaps_to_be_below(pancakes, n)
  end
  puts res.min
end

