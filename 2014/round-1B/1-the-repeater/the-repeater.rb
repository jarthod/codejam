#!/usr/bin/env ruby

def min_moves strings
  return 0 if strings.all? {|s| s.empty?}
  char = strings.first[0]
  return nil if char.nil?
  repeats = strings.map { |str| str.slice!(/^#{char}+/) }
  return nil if repeats.any?(&:nil?)
  target = (repeats.map(&:size).reduce(:+).to_f/repeats.size).round
  moves = repeats.inject(0) {|c, r| c + (r.size - target).abs }
  if rest = min_moves(strings)
    moves + rest
  end
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n = gets.to_i
  strings = n.times.map { gets.chomp }
  if moves = min_moves(strings)
    puts moves
  else
    puts "Fegla Won"
  end
end
