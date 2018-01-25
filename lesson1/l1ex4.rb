puts 'Задай первый коэффициент.'
a = gets.chomp.to_f
puts 'Задай второй коэффициент.'
b = gets.chomp.to_f
puts 'Задай третий коэффициент.'
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d < 0
  puts "#{d} - дискриминант. Корней нет."
else
  sqrt_d = Math.sqrt(d)
end

if d > 0
  puts "#{d} - дискриминант. Корни: x1 = #{(- b + sqrt_d) / (2 * a)}, x2 = #{(- b - sqrt_d) / (2 * a)}."
elsif d == 0
  puts "#{d} - дискриминант. Корень: x = #{- b / (2 * a)}."
end
