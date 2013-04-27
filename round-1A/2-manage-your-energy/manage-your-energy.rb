#!/usr/bin/env ruby

def maximum_score energy, regain, activities, energy_max, cache = {}
  return 0 if activities.empty?
  cache_key = [energy, activities.size]
  cache[cache_key] ||= (0..energy).map do |spent|
    after = [energy - spent + regain, energy_max].min
    win = spent * activities.first
    win + maximum_score(after, regain, activities[1..-1], energy_max, cache)
  end.max
end

gets.to_i.times do |i|
  energy, regain, _ = gets.split.map &:to_i
  activities = gets.split.map &:to_i
  energy_max = energy
  puts "Case ##{i+1}: #{maximum_score(energy, regain, activities, energy_max)}"
end