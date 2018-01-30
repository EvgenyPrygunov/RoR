letters = ('a'..'z').to_a

i = 0
alphabet = Hash.new

while i < 26
  alphabet[letters[i]] = i + 1
  i += 1
end

alphabet.each_with_index do |(key, value), index |
  puts "#{key}: #{value}." if index == 0
  puts "#{key}: #{value}." if index == 4
  puts "#{key}: #{value}." if index == 8
  puts "#{key}: #{value}." if index == 14
  puts "#{key}: #{value}." if index == 20
end
