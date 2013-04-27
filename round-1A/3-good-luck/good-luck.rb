#!/usr/bin/env ruby

require 'prime'

def combi input
  return [1] if input.empty?
  @cache ||= {}
  @cache[input] ||= (combi(input[1..-1]) + combi(input[1..-1]).map {|p| p*input.first}).sort.uniq
end

gets.to_i.times do |i|
  samples_count, digits, max, _ = gets.split.map &:to_i
  inputs = (2..max).to_a.repeated_combination(digits)
  puts "Case ##{i+1}:"
  samples_count.times do
    products = gets.split.map &:to_i
    # puts "guess #{digits} number in 2..#{max} given products: #{products}"
    res = inputs.first
    inputs.each do |input|
      if products.all? {|p| combi(input).bsearch {|x| x >= p} }
        res = input
        break
      end
    end
    puts res.join
  end
end

