puts 'Привет! Как Вас зовут?'
name = gets.chomp

puts 'Какой у тебя рост (в см)?'
height = gets.chomp.to_i

if height - 110 > 0
  puts "#{name}! Ваш идеальный вес #{height - 110} кг."
elsif
  puts "#{name}! Ваш вес уже оптимальный."
end
