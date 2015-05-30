#!/usr/bin/env ruby

ARROWS = /[><v^]/

def min_changes grid
  res = 0
  grid.each_with_index do |row, r|
    row.each_with_index do |cell, c|
      left = row[0...c].join
      right = row[(c+1)..-1].join
      top = grid[0...r].map {|o| o[c]}.join
      bottom = grid[(r+1)..-1].map {|o| o[c]}.join
      # puts "%d, %d: %5s %5s %5s %5s" % [r, c, left.inspect, right.inspect, top.inspect, bottom.inspect]
      case cell
      when '>'
        if not right =~ ARROWS
          if (left + top + bottom) =~ ARROWS
            res += 1
          else
            return false
          end
        end
      when '<'
        if not left =~ ARROWS
          if (right + top + bottom) =~ ARROWS
            res += 1
          else
            return false
          end
        end
      when '^'
        if not top =~ ARROWS
          if (left + right + bottom) =~ ARROWS
            res += 1
          else
            return false
          end
        end
      when 'v'
        if not bottom =~ ARROWS
          if (left + top + right) =~ ARROWS
            res += 1
          else
            return false
          end
        end
      end
    end
  end
  return res
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  r, _ = gets.split.map(&:to_i)
  grid = r.times.map { gets.chomp.split '' }
  res = min_changes(grid)
  puts (res == false ? 'IMPOSSIBLE' : res)
end

