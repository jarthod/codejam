#!/usr/bin/env ruby

def brute_force_probs probs, yes:, no:
  if yes < 0 or no < 0
    return 0
  elsif probs == []
    if yes == 0 and no == 0
      return 1
    else
      raise "ERROR"
    end
  end
  newprob = probs.dup
  n = newprob.pop
  brute_force_probs(newprob, yes: yes-1, no: no) * n +
    brute_force_probs(newprob, yes: yes, no: no-1) * (1-n)
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n, k = gets.split.map &:to_i
  probs = gets.split.map &:to_f
  probs.sort!

  selected = probs[-k..-1]
  max_prob = brute_force_probs(selected, yes: k/2, no: k/2)
  k.times.map do |i|
    selected[i] = probs[i]
    prob = brute_force_probs(selected, yes: k/2, no: k/2)
    max_prob = prob if prob > max_prob
  end
  # p selected
  puts max_prob

end

