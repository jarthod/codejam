#!/usr/bin/env ruby


def min_range min, max, step, offset
  return min if offset <= 0
  width = (max-min)/step+1
  return Float::INFINITY if offset >= width
  #puts "min_range(#{min}, #{max}, #{step}, #{offset}) #{width}"
  left = min_range(min, max-step, step*2, offset)
  right = min_range(min+step, max, step*2, offset - width/2)
  [left, right].min
end

def max_range min, max, step, limit
  #puts "max_range(#{min}, #{max}, #{step}, #{limit})"
  return 0 if limit <= 0
  width = (max-min)/step+1
  return max if limit > width
  left = max_range(min, max-step, step*2, limit)
  right = max_range(min+step, max, step*2, limit - width/2)
  [left, right].max
end

gets.to_i.times do |i|
  rounds, prizes = gets.split.map &:to_i
  teams = 2**rounds
  print "Case ##{i+1}: "
  $stdout.flush
  puts "#{min_range(0, teams-1, 1, prizes) - 1} #{max_range(0, teams-1, 1, prizes)}"
end

