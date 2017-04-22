#!/usr/bin/env ruby

FRIENDS = {
  nil => [:r, :o, :y, :g, :b, :v],
  r: [:y, :g, :b],
  o: [:g, :b, :v],
  y: [:b, :v, :r],
  g: [:v, :r, :o],
  b: [:r, :o, :y],
  v: [:o, :y, :g]
}.freeze

# def cycle(n, colors)
#   if colors.values.max >= 6
#     'YOLO'
#   else
#     place(n, colors)
#   end
# end

def place(n, colors, unicorns = [])
  return (FRIENDS[unicorns.first].include?(unicorns.last) ? unicorns.join.upcase : nil) if n == 0

  # puts "place(#{n}, #{colors}, #{first}, #{last})"
  FRIENDS[unicorns.last].each do |col|
    if colors[col] >= 1
      if (unicorns[0] == col) and unicorns.all? {|c| colors[c] > 1}
        # starting a cycle
        cycle = unicorns.dup
        cycles = 0
        while cycle.all? {|c| colors[c] > 1}
          cycle.each {|c| colors[c] -= 1}
          unicorns += cycle
          n -= cycle.length
          cycles += 1
        end
        # puts "cycle: #{cycle} x #{cycles}"
        res = place(n, colors, unicorns)
        return res if res
        cycle.each {|c| colors[c] += cycles}
        n += cycles * cycle.length
        unicorns.pop(cycles * cycle.length)
      else
        colors[col] -= 1
        res = place(n - 1, colors, unicorns + [col])
        return res if res
        colors[col] += 1
      end
    end
  end
  return nil
end

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n, r, o, y, g, b, v = gets.split.map &:to_i
  puts place(n, {r: r, o: o, y: y, g: g, b: b, v: v}) || 'IMPOSSIBLE'
end

