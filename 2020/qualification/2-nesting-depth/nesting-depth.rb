#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  s = gets.chomp
  depth = 0
  out = String.new
  s.each_char do |c|
    d = c.to_i
    if depth < d
      out << "("*(d-depth)
      depth = d
    elsif depth > d
      out << ")"*(depth-d)
      depth = d
    end
    out << c
  end
  out << ")"*depth if depth > 0
  puts out
end

