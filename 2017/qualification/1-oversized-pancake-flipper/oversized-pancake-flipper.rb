#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  s, k = gets.split
  s = s.chars.map {|c| c == '+' ? 1 : 0}
  k = k.to_i
  c = 0
  for i in 0..(s.length - k)
    if s[i] == 0
      k.times do |t|
        s[i+t] ^= 1
      end
      c += 1
    end
  end
  if s.all? {|s| s == 1}
    puts c
  else
    puts 'IMPOSSIBLE'
  end
end

