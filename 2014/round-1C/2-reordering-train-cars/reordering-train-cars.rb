#!/usr/bin/env ruby

def fact num
  (1..num).inject(:*)
end

def groupings cars
  # groups = []
  mult = 1
  for c in 'a'..'z'
    letter = cars.select {|car| car =~ /^#{c}+$/}
    mult *= fact(letter.size) if letter.any?
    letter = cars.select {|car| car =~ /[^#{c}]#{c}+$/} + letter
    letter += cars.select {|car| car =~ /^#{c}+[^#{c}]/}
    cars.delete_if {|car| car =~ /^#{c}/ or car =~ /#{c}$/ }
    cars << letter.join('') if letter.any?
  end
  return cars, mult
end

def permutations groups
  fact(groups.size)
end

def valid? groups
  taken = {}
  groups.each do |group|
    group.squeeze.each_byte do |c|
      return false if taken[c]
      taken[c] = true
    end
  end
  true
end

def orderings cars
  groups, mult = groupings(cars)
  # p groups, mult
  if valid?(groups)
    mult * permutations(groups)
  else
    0
  end
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  gets
  cars = gets.chomp.split
  puts orderings(cars) % 1_000_000_007
end

