#!/usr/bin/env ruby

T, A, B = gets.split.map(&:to_i)

def read data
  # $stderr.print "#{data}"
  puts data
  $stdout.flush
  res = gets.chomp
  # $stderr.puts " → #{res}"
  res
end

SIZE = 10**9

def find_min_x x, y, min: -SIZE
  return x if x - min <= 1
  middle = (x + min) / 2
  res = read("#{middle} #{y}")
  if res == "HIT"
    find_min_x middle, y, min: min
  elsif res == "MISS"
    find_min_x x, y, min: middle
  else
    exit 3
  end
end

def find_min_y x, y, min: -SIZE
  return y if y - min <= 1
  middle = (y + min) / 2
  res = read("#{x} #{middle}")
  if res == "HIT"
    find_min_y x, middle, min: min
  elsif res == "MISS"
    find_min_y x, y, min: middle
  else
    exit 3
  end
end

def find_max_x x, y, max: SIZE
  return x if max - x <= 1
  middle = (max + x) / 2
  res = read("#{middle} #{y}")
  if res == "HIT"
    find_max_x middle, y, max: max
  elsif res == "MISS"
    find_max_x x, y, max: middle
  else
    exit 3
  end
end

def find_max_y x, y, max: SIZE
  return y if max - y <= 1
  middle = (max + y) / 2
  res = read("#{x} #{middle}")
  if res == "HIT"
    find_max_y x, middle, max: max
  elsif res == "MISS"
    find_max_y x, y, max: middle
  else
    exit 3
  end
end

T.times do |c|
  # find bullseye using stategic points
  position = [ [ SIZE/4,  SIZE/4],
    [-SIZE/4,  SIZE/4],
    [ SIZE/4, -SIZE/4],
    [-SIZE/4, -SIZE/4] ].each do |x, y|
    res = read("#{x} #{y}")
    break :found if res == "CENTER" # lukcky us
    break [x, y] if res == "HIT"
  end
  next if position == "CENTER"
  exit 2 if position.nil?
  # find 4 points
  min_x = find_min_x(*position)
  max_x = find_max_x(*position)
  min_y = find_min_y(*position)
  max_y = find_max_y(*position)
  # $stderr.puts "found 4 points: #{min_x} #{max_x} #{min_y} #{max_y}"
  center = [(max_x + min_x) / 2, (max_y + min_y) / 2]
  # $stderr.puts "center is: #{center}"
  res = read(center.join(' '))
  if res != "CENTER"
    $stderr.puts "Wrong result"
    exit 1
  end
end

