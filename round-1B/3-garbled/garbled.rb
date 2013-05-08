#!/usr/bin/env ruby

$dictionary = Hash.new { |h, k| h[k] = [] }
$words = []
File.open("dictionary.txt").each_line do |word|
  word = word.chomp
  $dictionary[word[0]] << word
  $words << word
end
$cache = {}

def min_changes email, last_alter = 5, candidate = ''
  if email.empty?
    candidate.empty? ? 0 : Float::INFINITY
  elsif candidate.size > 0
    if email[0] == candidate[0] # word still match
      min_changes(email[1..-1], last_alter+1, candidate[1..-1])
    elsif last_alter >= 5 # a letter could have changed
      1 + min_changes(email[1..-1], 1, candidate[1..-1])
    else # don't match
      Float::INFINITY
    end
  else
    if $cache.has_key? [email, last_alter]
      return $cache.fetch([email, last_alter])
    end
    # puts "min_changes %20s (#{last_alter}), #{candidate}" % email
    min = Float::INFINITY
    $dictionary[email[0]].each do |candidate|
      sub_changes = min_changes email[1..-1], last_alter+1, candidate[1..-1]
      # puts "try with #{candidate} gives #{sub_changes}" if sub_changes < 1000
      min = sub_changes if sub_changes < min
      break if min == 0
    end
    if min > 0 and last_alter >= 5
      $words.each do |candidate|
        sub_changes = 1 + min_changes(email[1..-1], 1, candidate[1..-1])
        # puts "try with #{candidate} gives #{sub_changes}" if sub_changes < 1000
        min = sub_changes if sub_changes < min
        break if min == 1
      end
    end
    # puts "min_changes %20s (#{last_alter}), #{candidate} = #{min}" % email
    $cache[[email, last_alter]] = min
    min
  end
end

gets.to_i.times do |i|
  email = gets.chomp
  print "Case ##{i+1}: "
  $stdout.flush
  puts min_changes(email)
end

