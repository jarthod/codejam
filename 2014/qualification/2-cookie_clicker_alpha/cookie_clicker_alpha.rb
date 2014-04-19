#!/usr/bin/env ruby

gets.to_i.times do |i|
  print "Case ##{i+1}: "
  $stdout.flush
  production = 2.0
  past = 0
  cost, farm, goal = gets.split.map &:to_f
  total_time = goal/production
  while true do
    past += cost/production
    production += farm
    iter_time = past+goal/production
    break if iter_time > total_time
    total_time = iter_time
  end
  puts total_time
end

