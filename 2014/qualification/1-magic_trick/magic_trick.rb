#!/usr/bin/env ruby

gets.to_i.times do |i|
  print "Case ##{i+1}: "
  $stdout.flush
  row = gets.to_i
  lines = (1..4).map { gets.split.map &:to_i }
  set = lines[row-1]
  row = gets.to_i
  lines = (1..4).map { gets.split.map &:to_i }
  set &= lines[row-1]
  if set.empty?
    puts "Volunteer cheated!"
  elsif set.size > 1
    puts "Bad magician!"
  else
    puts set.first
  end
end

