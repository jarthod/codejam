#!/usr/bin/env ruby

gets.to_i.times do |i|
  credit, item_count = gets.to_i, gets.to_i
  items = {}
  gets.split.map(&:to_i).each_with_index do |item, index|
    if items[credit - item]
      puts "Case ##{i+1}: #{items[credit - item] + 1} #{index + 1}"
      break
    end
    items[item] = index
  end
end
