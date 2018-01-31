letters = ('a'..'z')
vovels = ['a', 'e', 'i', 'o', 'u']

letters.each.with_index(1) { |l, i| puts "#{l}: #{i}." if vovels.include?(l) }
