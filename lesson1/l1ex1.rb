puts 'Привет! Как Вас зовут?'
name = gets.chomp

puts 'Какой у тебя рост (в см)?'
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight > 0
  puts "#{name}! Ваш идеальный вес #{ideal_weight} кг."
elsif
  puts "#{name}! Ваш вес уже оптимальный."
end
