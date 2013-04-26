#!/usr/bin/env ruby

def valid rows
  row_max = rows.map {|r| r.max}
  col_max = rows.transpose.map {|r| r.max}
  for i in 0...row_max.size
    for j in 0...col_max.size
      return false if rows[i][j] < [row_max[i], col_max[j]].min
    end
  end
end

gets.to_i.times do |i|
  rows = []
  lines, cols = gets.split.map &:to_i
  lines.times { rows << gets.split.map(&:to_i) }
  puts "Case ##{i+1}: #{valid(rows) ? "YES" : "NO"}"
end
