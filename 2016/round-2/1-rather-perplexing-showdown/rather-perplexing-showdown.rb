#!/usr/bin/env ruby

$beats = {
  'R' => 'S',
  'P' => 'R',
  'S' => 'P'
}

def get_combination(rounds, winner, counts)
  return [winner] if rounds <= 0 # done
  opponent = $beats[winner]
  return nil if counts[opponent] <= 0 or counts[winner] <= 0 # invalid, can't find loosing opponent
  if c1 = get_combination(rounds - 1, winner, counts)
    c = counts.dup
    c1.each { |item| c[item] -= 1 }
    c2 = get_combination(rounds - 1, opponent, c)
    return [c1 + c2, c2 + c1].sort.first if c2
  end
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n, r, p, s = gets.split.map &:to_i
  combinations = ['R', 'P', 'S'].map do |winner|
    get_combination(n, winner, 'R' => r, 'P' => p, 'S' => s)
  end.compact
  if combinations.any?
    puts combinations.sort.first.join
  else
    puts "IMPOSSIBLE"
  end
end