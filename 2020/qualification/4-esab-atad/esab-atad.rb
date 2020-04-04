#!/usr/bin/env ruby
T, B = gets.split.map(&:to_i)

def read data
  # $stderr.print "#{data}"
  puts data
  $stdout.flush
  res = gets.chomp
  # $stderr.puts " → #{res}"
  res
end

T.times do |c|
  # $stderr.puts "Start test ##{c} of size #{B}"
  bits = Array.new(B)
  symetric = nil
  asymetric = nil
  guessed = 0
  commands = 0
  while bits.any?(&:nil?)
    if commands > 0 && commands % 10 == 0
      if symetric
        if read(symetric+1).to_i != bits[symetric]
          # $stderr.puts "Inverting!"
          bits.map! {|x| 1-x if x}
        end
        commands += 1
      end
      if asymetric
        if read(asymetric+1).to_i != bits[asymetric]
          # $stderr.puts "Reversing!"
          bits.reverse!
        end
        commands += 1
      end
      if commands % 2 != 0
        read(1)
        commands += 1
      end
    else
      bits[guessed] = read(guessed+1).to_i
      bits[B-guessed-1] = read(B-guessed).to_i
      symetric = guessed if bits[guessed] == bits[B-guessed-1] and !symetric
      asymetric = guessed if bits[guessed] != bits[B-guessed-1] and !asymetric
      commands += 2
      guessed += 1
    end
    # $stderr.puts bits.inspect
    exit 2 if commands % 2 != 0
    exit 3 if commands >= 140
  end
  res = read(bits.join)
  if res != "Y"
    # $stderr.puts "Wrong result"
    exit 1
  end
end
