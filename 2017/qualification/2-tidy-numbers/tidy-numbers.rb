#!/usr/bin/env ruby

module Enumerable
  def sorted?
    each_cons(2).all? { |a, b| (a <=> b) <= 0 }
  end
end

class Integer
  def tidy?
    to_s.chars.sorted?
  end
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  # n = gets.to_i
  # while !n.tidy?
  #   n = n-1
  # end
  # puts n

  n = gets.chomp.chars.map(&:to_i)
  while !n.sorted?
    for i in 1...n.length
      if n[i] < n[i-1]
        for j in i...n.length
          n[j] = 9
        end
        n[i-1] = n[i-1] - 1
      end
    end
  end
  n = n.drop_while {|n| n.zero?}
  puts n.join
end

