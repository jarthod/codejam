#!/usr/bin/env ruby

def path_to x, y, jump = 1
  if x >= jump
    "E" + path_to(x - jump, y, jump + 1)
  elsif x <= -jump
    "W" + path_to(x + jump, y, jump + 1)
  elsif y >= jump
    "N" + path_to(x, y - jump, jump + 1)
  elsif y <= -jump
    "S" + path_to(x, y + jump, jump + 1)
  elsif x > 0
    "WE" + path_to(x - 1, y, jump + 2)
  elsif x < 0
    "EW" + path_to(x + 1, y, jump + 2)
  elsif y < 0
    "NS" + path_to(x, y + 1, jump + 2)
  elsif y > 0
    "SN" + path_to(x, y - 1, jump + 2)
  else
    ''
  end
end

gets.to_i.times do |i|
  x, y = gets.split.map &:to_i
  print "Case ##{i+1}: "
  $stdout.flush
  puts path_to(x, y)
end

