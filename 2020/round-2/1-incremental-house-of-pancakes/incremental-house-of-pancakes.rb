#!/usr/bin/env ruby

def integral n
  (n**2 + n) / 2
end

def integral2 n, start
  n**2 + n*start
end

def solve1 sum
  delta = 1+8*sum
  (Math::sqrt(delta) - 1) / 2
end

def solve2 sum, start
  delta = start**2 + 4*sum
  (Math::sqrt(delta) - start) / 2
end

def brute l, r
  c = 0
  while c < l or c < r
    c += 1
    if r > l
      r -= c
    else
      l -= c
    end
  end
  return [c, l, r]
end

def optimal l, r
  c = 0
  # Step 1 (one stack)
  if r > l
    res = solve1(r-l).floor
    c += res
    r -= integral(res)
  elsif l > r
    res = solve1(l-r).floor
    c += res
    l -= integral(res)
  end

  # Step 1 (two stacks)
  if r > l
    res_r = solve2(r, c).floor
    res_l = solve2(l, c+1).floor
    r -= integral2(res_r, c)
    l -= integral2(res_l, c+1)
    c += res_r + res_l
  else
    res_l = solve2(l, c).floor
    res_r = solve2(r, c+1).floor
    l -= integral2(res_l, c)
    r -= integral2(res_r, c+1)
    c += res_r + res_l
  end
  return [c, l, r]
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  l, r = gets.split.map &:to_i
  # c1, l1, r1 = brute(l, r)
  # puts "brute: #{c1} #{l1} #{r1}"
  c2, l2, r2 = optimal(l, r)
  # puts "optimal: #{c2} #{l2} #{r2}"
  # raise if not [c1, l1, r1] == [c2, l2, r2]
  # raise if not (l - l2) + (r - r2) == integral(c2)
  puts "#{c2} #{l2} #{r2}"
end

