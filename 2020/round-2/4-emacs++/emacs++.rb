#!/usr/bin/env ruby

def parse code
  jump_table = []
  stack = []
  code.chars.each_with_index do |c, i|
    if c == '('
      stack << i
    elsif c == ')'
      matching = stack.pop
      jump_table[i] = matching
      jump_table[matching] = i
    end
  end
  jump_table
end

def moves position, jump_table
  Enumerator.new do |enum|
    enum.yield position + 1 if position < (jump_table.size - 1)
    enum.yield position - 1 if position > 0
    enum.yield jump_table[position]
  end
end

def compute jump_table
  res = Array.new(jump_table.size) { Array.new(jump_table.size) }
  queue = []
  res.size.times do |i|
    res[i][i] = 0
    queue << [i, i]
  end
  while n = queue.shift
    from, to = n[0], n[1]
    moves(to, jump_table).each do |n|
      if res[to][n].nil?
        res[to][n] = 1
        queue << [to, n]
      end
      if res[from][n].nil?
        res[from][n] = res[from][to] + 1
        queue << [from, n]
      end
    end
  end
  res
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  k, q = gets.split.map &:to_i
  code = gets.chomp
  gets # costs
  gets # costs
  gets # costs
  starts = gets.split.map &:to_i
  ends = gets.split.map &:to_i
  # puts code
  jump_table = parse(code)
  distances = compute(jump_table)
  # distances.each { |line| p line }

  cost = 0
  q.times do |i|
    # puts starts[i]
    # puts ends[i]
    cost += distances[starts[i]-1][ends[i]-1]
  end
  puts cost
end

