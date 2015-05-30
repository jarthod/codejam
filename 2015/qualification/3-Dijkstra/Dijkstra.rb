#!/usr/bin/env ruby

I = 2
J = 3
K = 4

$mult = {
  1 => {1 => 1, I => I, J => J, K => K, -1 => -1, -I => -I, -J => -J, -K => -K},
  I => {1 => I, I => -1, J => K, K => -J, -1 => -I, -I => 1, -J => -K, -K => J},
  J => {1 => J, I => -K, J => -1, K => I, -1 => -J, -I => K, -J => 1, -K => -I},
  K => {1 => K, I => J, J => -I, K => -1, -1 => -K, -I => -J, -J => I, -K => 1},
  -1 => {1 => -1, I => -I, J => -J, K => -K, -1 => 1, -I => I, -J => J, -K => K},
  -I => {1 => -I, I => 1, J => -K, K => J, -1 => I, -I => -1, -J => K, -K => -J},
  -J => {1 => -J, I => K, J => 1, K => -I, -1 => J, -I => -K, -J => -1, -K => I},
  -K => {1 => -K, I => -J, J => I, K => 1, -1 => K, -I => J, -J => -I, -K => -1},
}

def find_split(str, end_result)
  ibuf = 1
  for i in 0...str.size
    ibuf = $mult[ibuf][str[i]]
    if ibuf == I
      # puts "found I at #{i}"
      jbuf = 1
      for j in (i+1)...str.size
        jbuf = $mult[jbuf][str[j]]
        if jbuf == J
          # puts "found J at #{j}"
          if end_result[j+1] == K
            return true
          end
        end
      end
    end
  end
  false
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush
  end_result = []

  _, x = gets.split.map(&:to_i)
  substr = gets.chomp
  str = (substr * x).split(//).map {|i| {'i' => I, 'j' => J, 'k' => K}[i]}
  (str.size-1).downto(0).each do |i|
    end_result[i] = $mult[str[i]][end_result[i+1] || 1]
  end
  puts find_split(str, end_result) ? 'YES' : 'NO'
end

