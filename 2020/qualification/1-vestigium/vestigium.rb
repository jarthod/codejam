#!/usr/bin/env ruby
require 'matrix'

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n = gets.to_i
  m = Matrix[*n.times.map { gets.split.map &:to_i }]
  trace = m.each(:diagonal).inject(:+)
  dup_rows = m.row_vectors.count {|row| row.to_a.uniq.size != n }
  dup_cols = m.column_vectors.count {|col| col.to_a.uniq.size != n }
  puts "#{trace} #{dup_rows} #{dup_cols}"
end

