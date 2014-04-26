#!/usr/bin/env ruby

class Array
  def up_to size
    map {|flow| flow[0..size] }.sort
  end

  def flipped_at position
    map do |flow|
      flow.dup.tap {|f| f[position] = f[position] == '1' ? '0' : '1' }
    end
  end
end

def min_flips outlets, devices, bits, up_to=0
  return 0 if up_to == bits
  values = [Float::INFINITY]
  if outlets.up_to(up_to) == devices.up_to(up_to)
    values << min_flips(outlets, devices, bits, up_to + 1)
  end
  flipped = outlets.flipped_at up_to
  if flipped.up_to(up_to) == devices.up_to(up_to)
    values << 1 + min_flips(flipped, devices, bits, up_to + 1)
  end
  values.compact.min
end

gets.to_i.times do |i|
  print "Case ##{i+1}: "
  $stdout.flush

  _, bits = gets.split.map &:to_i
  outlets = gets.split
  devices = gets.split
  res = min_flips(outlets, devices, bits)
  if res == Float::INFINITY
    puts "NOT POSSIBLE"
  else
    puts res
  end
end

