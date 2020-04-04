#!/usr/bin/env ruby

def latin_square size
  out = []
  size.times do |r|
    row = []
    size.times do |c|
      row[c] = (c + r)%size+1
    end
    out << row
  end
  out
end

def find_permutation square, sum, row: 0, taken_cols: []
  if row == square.size
    return (sum == 0 ? taken_cols : nil)
  end
  return if sum <= 0 or sum > (square.size - row) * square.size
  # puts "find_permutation(#{sum}, #{row}, #{taken_cols})"
  res = nil
  square[row].each_with_index do |v, i|
    next if taken_cols.include?(i)
    res = find_permutation square, sum - v, row: row+1, taken_cols: taken_cols + [i]
    return res if res
  end
  return res
end

def prints square, permutation: nil
  square.each do |row|
    if permutation
      puts row.values_at(*permutation).join(' ')
    else
      puts row.join(' ')
    end
  end
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush
  size, sum = gets.split.map &:to_i
  square = latin_square(size)
  # prints(square)
  permutation = find_permutation(square, sum)
  if permutation
    puts "POSSIBLE"
    prints(square, permutation: permutation)
  else
    puts "IMPOSSIBLE"
  end
end
