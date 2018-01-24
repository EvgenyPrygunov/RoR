puts "Привет! Как Вас зовут?"
name = gets.chomp

puts "Какой у тебя рост (в см)?"
height = gets.chomp

if height.to_i - 110 >= 0
  puts "#{name}! Ваш идеальный вес #{height.to_i - 110} кг."
elsif
  puts "#{name}! Ваш вес уже оптимальный."
end
