#!/usr/bin/env ruby

gets.to_i.times do |i|
  print "Case ##{i+1}: "
  $stdout.flush
  n = gets.to_i
  naomis = gets.split.map(&:to_f).sort!
  ken = gets.split.map(&:to_f).sort!
  war = 0
  i = 0
  j = 0
  while j < n do
    if naomis[i] > ken[j]
      j += 1
      war += 1
    else
      i += 1
      j += 1
    end
  end
  deceitful_war = 0
  i = 0
  j = 0
  while i < n do
    if naomis[i] > ken[j]
      deceitful_war += 1
      i += 1
      j += 1
    else
      i += 1
    end
  end
  puts "#{deceitful_war} #{war}"
end

