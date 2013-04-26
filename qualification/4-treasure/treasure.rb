#!/usr/bin/env ruby

Chest = Struct.new(:id, :lock, :content) do
  attr_accessor :open

  def inspect
    "#{open ? 'O' : 'X'}[#{lock} => #{content.join(', ')}]"
  end
end

class State
  attr_accessor :open, :keys, :path

  def initialize keys
    self.open = []
    self.keys = keys
    self.path = []
  end

  def dup
    state = State.new keys.dup
    state.open = open.dup
    state.path = path.dup
    state
  end

  def key
    [open, keys]
  end

  def children chests
    Enumerator.new do |enum|
      chests.each_with_index do |chest, i|
        if !open[i] and keys[chest.lock] > 0
          state = dup
          state.open[i] = true
          state.keys[chest.lock] -= 1
          chest.content.each {|c| state.keys[c] += 1}
          state.path = path + [chest.id]
          enum.yield state
        end
      end
    end
  end
end

def find_path cache, chests, state
  if cache.has_key? state.key
    #p state.path
    return cache[state.key]
  elsif state.path.size == chests.size
    state.path
  else
    #print 'x'
    state.children(chests).each do |child|
      if path = find_path(cache, chests, child)
        return path
      end
    end
    cache[state.key] = false
    false
  end
end

gets.to_i.times do |i|
  _, lines = gets.split.map &:to_i
  keys = Hash.new(0)
  gets.split.each { |key| keys[key.to_i] += 1 }
  chests = []
  lines.times do |i|
    lock, _, *content = gets.split.map(&:to_i)
    chests << Chest.new(i+1, lock, content)
  end
  # p keys, chests
  start = State.new keys
  cache = {}
  path = find_path(cache, chests, start)
  puts "Case ##{i+1}: #{path ? path.join(' ') : "IMPOSSIBLE"}"
end
