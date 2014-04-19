#!/usr/bin/env ruby

def mysqrt(x)
  return 0 if x==0
  m=x
  p=x
  loop do
    r=(m+p/m)/2
    return m if m<=r
    m=r
  end
end

gets.to_i.times do |i|
  radius, paint = gets.chomp.split.map &:to_i
  b = (2 * radius)-1
  a = 2
  c = -paint
  d = b**2 - 4*a*c
  rings = (- b + mysqrt(d))/(2*a)
  puts "Case ##{i+1}: #{rings}"
end