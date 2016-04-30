#!/usr/bin/env ruby

$word = ["ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE"].map do |word|
  word.chars.reduce(Hash.new(0)) {|acc, l| acc[l] += 1; acc}
end

def remove_letters(letters, digit, n)
  out = letters.dup
  $word[digit].each do |char, times|
    if out[char] < n*times
      raise "can't remove #{n*times} `#{c}` from #{out}"
    elsif out[char] == n*times
      out.delete(char)
    else
      out[char] -= n*times
    end
  end
  out
end

def get_digits(letters, digit: 0)
  return "" if letters.empty?
  return nil if digit > 9
  max = $word[digit].map {|char, times| letters[char] / times}.min
  # puts "D = #{digit}, max = #{max}"
  min = 0
  # if digit have unique letters, there is only one number possible
  min = max if $word[digit].keys.any? {|c| $word[digit+1..-1].none? { |word| word.keys.include?(c) } }
  max.downto(min).each do |n|
    # puts "try with #{digit}: #{n}" if digit < 2
    if rest = get_digits(remove_letters(letters, digit, n), digit: digit+1)
      return "#{digit}" * n + rest
    end
  end
  return nil
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  s = gets.chomp
  letters = s.chars.reduce(Hash.new(0)) {|acc, l| acc[l] += 1; acc}
  puts get_digits(letters)
end

