#!/usr/bin/env ruby

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n = gets.to_i
  events = n.times.map { gets.split.map &:to_i }
  cameron = 0
  jamie = 0
  res = events.sort_by(&:first).each do |arr|
    start, finish = *arr
    if cameron <= start
      arr << 'C'
      cameron = finish
    elsif jamie <= start
      arr << 'J'
      jamie = finish
    else
      break "IMPOSSIBLE"
    end
  end
  if res == "IMPOSSIBLE"
    puts res
  else
    puts events.map(&:last).join
  end
end

