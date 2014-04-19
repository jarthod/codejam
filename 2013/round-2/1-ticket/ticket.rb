#!/usr/bin/env ruby

Transaction = Struct.new(:from, :count)

def city_cost dist, stations
  dist * stations - (dist*(dist-1))/2
end

gets.to_i.times do |i|
  stations, travel_count = gets.split.map &:to_i
  print "Case ##{i+1}: "
  $stdout.flush
  normal_cost = 0
  transactions = Hash.new(0)
  travel_count.times do
    from, to, count = gets.split.map &:to_i
    transactions[from] += count
    transactions[to] -= count
    normal_cost += city_cost(to-from, stations) * count
  end
  rogue_cost = 0
  tickets = []
  transactions.keys.sort.each do |station|
    diff = transactions[station]
    if diff > 0 # more people in
      tickets << Transaction.new(station, diff)
    elsif diff < 0 # more people out
      while diff < 0
        ticket = tickets.last
        take = [ticket.count, -diff].min
        ticket.count -= take
        diff += take
        rogue_cost += city_cost(station - ticket.from, stations) * take
        if ticket.count == 0
          tickets.pop
        end
      end
    end
  end
  res = normal_cost - rogue_cost
  puts res % 1000002013
end

