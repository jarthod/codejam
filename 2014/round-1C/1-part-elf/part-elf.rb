#!/usr/bin/env ruby

MAX_DIV = 2**40

def closest_elf_generation ratio
  return 0 if ratio >= 1
  return 'impossible' if ratio <= 0
  return 'impossible' if (ratio * MAX_DIV).denominator > 1
  for l in 1..40
    max = 2**l
    if (ratio * max).denominator == 1
      if ratio >= Rational(1,2)
        return 1
      else
        return closest_elf_generation(ratio*2) + 1
      end
    end
  end
  return 'impossible'
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  ratio = gets.to_r
  puts closest_elf_generation(ratio)
end

