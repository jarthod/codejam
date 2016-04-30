#!/usr/bin/env ruby

def closest_match c, j, biais = 0
  if c.size == 0 and j.size == 0
    # done
    return ['', '']
  elsif c[0] == '?' and j[0] == '?'
    # easy choice
    if biais > 0
      c, j = closest_match(c[1..-1], j[1..-1], biais)
      return ['0' + c, '9' + j]
    elsif biais < 0
      c, j = closest_match(c[1..-1], j[1..-1], biais)
      return ['9' + c, '0' + j]
    else
      best = nil
      best_diff = Float::INFINITY
      (0..1).each do |x|
        (0..1).each do |y|
          c2, j2 = closest_match(c[1..-1], j[1..-1], (x - y))
          solution = [x.to_s + c2, y.to_s + j2]
          diff = solution.map(&:to_i).reduce(:-).abs
          # puts "solution = #{solution} (#{diff})"
          if diff < best_diff
            best = solution
            best_diff = diff
          end
        end
      end
      return best
      # c, j = closest_match(c[1..-1], j[1..-1], biais)
      # return ['0' + c, '0' + j]
    end
  elsif c[0] != '?' and j[0] != '?'
    # no choice
    biais = c[0].ord - j[0].ord if biais == 0
    c2, j2 = closest_match(c[1..-1], j[1..-1], biais)
    return [c[0] + c2, j[0] + j2]
  elsif j[0] == '?'
    # reverse for simplicity
    return closest_match(j, c, -biais).reverse
  elsif biais == 0
    n = j[0].to_i
    best = nil
    best_diff = Float::INFINITY
    ([n-1, 0].max..[n+1, 9].min).each do |i|
      # puts "try with n = #{i}"
      c2, j2 = closest_match(c[1..-1], j[1..-1], (i - n))
      solution = [i.to_s + c2, n.to_s + j2]
      diff = solution.map(&:to_i).reduce(:-).abs
      # puts "solution = #{solution} (#{diff})"
      if diff < best_diff
        best = solution
        best_diff = diff
      end
    end
    return best
  else
    n = (biais > 0 ? 0 : 9)
    c2, j2 = closest_match(c[1..-1], j[1..-1], biais)
    return [n.to_s + c2, j[0] + j2]
  end
end

def closest_match_brute c_str, j_str
  c_reg = Regexp.new("^#{c_str.gsub('?', '.')}$")
  j_reg = Regexp.new("^#{j_str.gsub('?', '.')}$")
  best = nil
  best_diff = Float::INFINITY
  (0..999).each do |c|
    (0..999).each do |j|
      diff = (j - c).abs
      if diff < best_diff and c.to_s.rjust(c_str.size, '0') =~ c_reg and j.to_s.rjust(c_str.size, '0') =~ j_reg
        best = [c.to_s.rjust(c_str.size, '0'), j.to_s.rjust(c_str.size, '0')]
        best_diff = diff
      end
    end
  end
  best
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  c, j = gets.split
  puts closest_match(c, j).join(' ')
end

