#!/usr/bin/env ruby

def required_changes motes, mote
  if motes.size == 0
    0
  elsif mote > motes.first
    required_changes motes[1..-1], mote + motes.first
  else
    changes = 0
    while motes.first >= mote and changes < motes.size
      mote += mote - 1
      changes += 1
    end
    if changes >= motes.size
      return motes.size
    else
      changes + required_changes(motes, mote)
    end
  end
end

gets.to_i.times do |i|
  mote, _ = gets.split.map &:to_i
  motes = gets.split.map(&:to_i).sort
  puts "Case ##{i+1}: #{[required_changes(motes, mote), motes.size].min}"
end

