#!/usr/bin/env ruby

def max_fakes arr, counts1, counts2
  best_fake = 0
  arr.size.times do |i|
    n1, n2 = arr[i]
    if counts1[n1] >= 2 and counts2[n2] >= 2
      counts1[n1] -= 1
      counts2[n2] -= 1
      fake = max_fakes(arr[0...i] + arr[(i+1)..-1], counts1, counts2) + 1
      counts1[n1] += 1
      counts2[n2] += 1
      if (fake > best_fake)
        best_fake = fake
      end
    end
  end
  best_fake
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n = gets.to_i
  names = []
  n.times { names << gets.chomp.split.map(&:downcase).map(&:to_sym) }
  counts1 = Hash.new(0)
  counts2 = Hash.new(0)
  names.each do |n1, n2|
    counts1[n1] += 1
    counts2[n2] += 1
  end
  genuine, donno = names.partition {|n1, n2| [counts1[n1], counts2[n2]].min == 1}
  # viewed1 = {}
  # viewed2 = {}
  # fake = 0
  # names.each do |n1, n2|
  #   fake += 1 if viewed1[n1] and viewed2[n2]
  #   viewed1[n1] = true
  #   viewed2[n2] = true
  # end
  puts max_fakes(donno, counts1, counts2)
end

