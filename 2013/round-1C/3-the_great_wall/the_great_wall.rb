#!/usr/bin/env ruby

Attack = Struct.new :x1, :x2, :strength
offset = 1000

gets.to_i.times do |i|
  tribe_count = gets.to_i
  wall = Array.new(offset * 2, 0)
  attacks = Hash.new {|h, k| h[k] = []}
  tribe_count.times do |i|
    day, count, x1, x2, strength, delta_days, delta_x, delta_strength = gets.split.map &:to_i
    count.times do |i|
      attacks[day + i * delta_days] << Attack.new(x1 + i * delta_x, x2 - 1 + i * delta_x, strength + i * delta_strength)
    end
  end
  succedded = 0
  attacks.keys.sort.each do |day|
    attacks[day].each do |attack|
      zone = (attack.x1 + offset)..(attack.x2 + offset)
      # puts "attack #{attack.inspect}"
      if wall[zone].min < attack.strength
        succedded += 1
        # puts "succed!"
      end
    end
    attacks[day].each do |attack|
      ((attack.x1 + offset)..(attack.x2 + offset)).each do |x|
        wall[x] = attack.strength if wall[x] < attack.strength
      end
    end
    # p wall[90..110]
  end
  print "Case ##{i+1}: "
  $stdout.flush
  puts succedded
end

