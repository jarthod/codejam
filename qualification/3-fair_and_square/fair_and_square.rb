#!/usr/bin/env ruby

class Integer
  def palindrome?
    str = self.to_s
    str == str.reverse
  end
end

def generate_part digits, max_1
  array = Array.new(digits, 0)
  Enumerator.new do |enum|
    if max_1 == 0
      enum.yield array
    else
      generate_part(digits, max_1 - 1).each do |prev|
        enum.yield prev
        if prev.count(1) == max_1 - 1
          prev.each_with_index do |val, i|
            if val == 0
              arr = prev.dup
              arr[i] = 1
              enum.yield arr
            end
          end
        end
      end
    end
  end
end

$numbers = [0, 1, 4, 9]

def try num
  square = num ** 2
  if num.palindrome? and square.palindrome?
    #puts "#{num} => #{square}"
    $numbers << square
  end
  square
end

$stderr.print "computing "
0.upto(24) do |digits|
  $stderr.print "."
  generate_part(digits, 3).each do |num|
    try ('1' + num.join + num.reverse.join + '1').to_i
    ('0'..'2').each do |split|
      try ('1' + num.join + split + num.reverse.join + '1').to_i
    end
  end
end

0.upto(24) do |digits|
  try ('2' + '0' * digits * 2 + '2').to_i
  try ('2' + '0' * digits + '0' + '0' * digits + '2').to_i
  try ('2' + '0' * digits + '1' + '0' * digits + '2').to_i
end
$stderr.puts "."

$numbers.sort!.uniq!

def fair_and_square a, b
  min = (0...$numbers.size).bsearch {|x| $numbers[x] >= a}
  max = (0...$numbers.size).bsearch {|x| $numbers[x] > b}
  max - min
end

gets.to_i.times do |i|
  a, b = gets.split.map &:to_i
  puts "Case ##{i+1}: #{fair_and_square(a, b)}"
end
