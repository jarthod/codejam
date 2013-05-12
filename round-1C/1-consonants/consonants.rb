#!/usr/bin/env ruby

def consonant? char
  not "aeiou".include?(char)
end

def nvalue name, n
  start = 0
  finish = 0
  count = 0
  last_match = -1
  consonants = 0
  while start < name.size
    while finish < name.size and finish - start < n
      if consonant?(name[finish])
        consonants += 1
      else
        consonants -= 1 if consonant?(name[start]) and finish - start > 0
        start += 1
      end
      finish += 1
      # puts "#{start} #{finish}"
    end
    if consonants == n
      # puts "match #{start} - #{finish} (#{name[start...finish]})"
      count += (1 + (name.size - finish)) * (start - last_match)
      last_match = start
    end
    break if start >= name.size
    consonants -= 1 if consonant?(name[start])
    start += 1
  end
  count
end

gets.to_i.times do |i|
  name, n = gets.split
  n = n.to_i
  print "Case ##{i+1}: "
  $stdout.flush
  puts nvalue(name, n)
end

