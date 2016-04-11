#!/usr/bin/env ruby

def divisor(k)
  (2..Math.sqrt(k)).find { |n| k % n == 0}
end

def coinjam(n)
  out = [n]
  # puts "n = #{n}"
  (2..10).each do |base|
    num = n.to_i64(base)
    # puts " → #{num} (base #{base})"
    if d = divisor(num)
      out << d.to_s
    else
      return nil
    end
  end
  out
end

puts "Case #1:"
n, j = 32, 50
i = (1 << n-1) + 1
coins = [] of Array(String)
while coins.size < j
  if coin = coinjam(i.to_s(2))
    coins << coin
    puts "#{coins.size} / #{j}"
  end
  i = i+2
end
coins.each do |coin|
  puts coin.join(' ')
end

