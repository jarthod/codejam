#!/usr/bin/env ruby

Source = Struct.new(:rate, :temp)

gets.to_i.times do |c|
  print "Case ##{c+1}: "
  $stdout.flush

  n, v, x = gets.split.map &:to_f
  sources = n.to_i.times.map do
    r, c = gets.split.map(&:to_f)
    Source.new(r, c)
  end
  under = sources.select {|s| s.temp <= x}.sort_by(&:temp)
  over = sources.select {|s| s.temp >= x}.sort_by(&:temp)
  good_temp = (under & over)
  if under.empty? or over.empty?
    puts "IMPOSSIBLE"
  else
    best_sources = []
    best_rate = 0
    if good_temp.any?
      best_sources = good_temp
      best_rate = good_temp.map(&:rate).reduce(:+)
    end

    under = under - good_temp
    over = over - good_temp
    pending = nil
    pending_temp = x
    pending_rate = x
    u = 0
    o = 0
    while 1
      # puts "pending: #{pending}, best_rate: #{best_rate}"
      if pending and pending.temp > x
        break if u >= under.size
        source = under[u]
        ratio = (x - source.temp) / (pending.temp - source.temp)
        # puts "mixing with #{source}, ratio: #{ratio}"
        if ratio * (1/pending.rate) > (1-ratio) * (1/source.rate)
          # pending is empty
          rate = 1/(ratio * (1/pending.rate))
          best_rate += rate
          pending = source
          pending.rate -= rate
        else
          # pending still has some juice
          rate = 1/((1-ratio) * (1/source.rate))
          best_rate += rate
          pending.rate -= rate
        end
        u = u + 1
      else
        break if o >= over.size
        source = over[o]
        if pending
          ratio = (source.temp - x) / (source.temp - pending.temp)
          # pending take more time to fill it's part ?
          # puts "mixing with #{source}, ratio: #{ratio}"
          if ratio * (1/pending.rate) > (1-ratio) * (1/source.rate)
            # pending is empty
            rate = 1/(ratio * (1/pending.rate))
            best_rate += rate
            pending = source
            pending.rate -= rate
          else
            # pending still has some juice
            rate = 1/((1-ratio) * (1/source.rate))
            best_rate += rate
            pending.rate -= rate
          end
        else
          pending = source
        end
        o = o + 1
      end
    end
    # under.each do |u_source|
    #   over.each do |o_source|
    #     next if u_source.temp == o_source.temp
    #     ratio = (x - u_source.temp) / (o_source.temp - u_source.temp)
    #     rate = 1/[ratio * (1/o_source.rate), (1-ratio) * (1/u_source.rate)].max
    #     if rate > best_rate
    #       best_rate = rate
    #       best_sources = [u_source, o_source]
    #     end
    #   end
    # end
    # p best_sources
    puts v / best_rate
  end
end

