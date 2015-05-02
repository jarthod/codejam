#!/usr/bin/env ruby

def compute empty, grid, inner_grid, corners, one_row
  res = inner_grid * 4
  empty -= inner_grid
  borders = grid - inner_grid - corners
  res += [borders, empty].min * (one_row ? 2 : 3)
  empty -= [borders, empty].min
  res += [corners, empty].min * (one_row ? 1 : 2)
  empty -= [corners, empty].min
  raise if not empty == 0
  res
end

def min_unhapiness x, y, n
  size = x*y
  inner_size = [x-2, 0].max * [y-2, 0].max
  walls = (x-1) * y + (y-1) * x
  empty = size - n
  grid1 = (x/2.0*y).ceil
  grid2 = (x/2.0*y).floor
  inner_grid1 = ([x-2, 0].max/2.0*[y-2, 0].max).ceil
  inner_grid2 = ([x-2, 0].max/2.0*[y-2, 0].max).floor
  corners1 = [true, x > 1 && x%2 == 1, y > 1 && y%2 == 1, y > 1 && x > 1 && (x+y)%2 == 0].count(true)
  corners2 = [false, x > 1 && x%2 == 0, y > 1 && y%2 == 0, y > 1 && x > 1 && (x+y)%2 == 1].count(true)
  one_row = (x == 1 or y == 1)
  # puts "#{grid1} / #{inner_grid1} - #{grid2} / #{inner_grid2} - #{corners1} / #{corners2}"
  return walls if empty == 0
  return 0 if n <= grid1
  return walls - empty * 4 if empty <= inner_grid1
  walls - [compute(empty, grid1, inner_grid1, corners1, one_row), compute(empty, grid2, inner_grid2, corners2, one_row)].max
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  x, y, n = gets.split.map &:to_i
  puts min_unhapiness(x, y, n)
end

